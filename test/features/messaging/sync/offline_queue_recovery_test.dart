import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/core/network/api_error_mapper.dart';
import 'package:pokidoki/core/network/auth_session_manager.dart';
import 'package:pokidoki/data/models/message.dart';
import 'package:pokidoki/data/models/message_page.dart';
import 'package:pokidoki/features/messaging/data/api/api_conversations_repository.dart';
import 'package:pokidoki/features/messaging/data/api/messaging_api.dart';
import 'package:pokidoki/features/messaging/data/local/database/messaging_database.dart';
import 'package:pokidoki/features/messaging/data/local/database/messaging_database_factory.dart';
import 'package:pokidoki/features/messaging/data/local/database/messaging_database_key_store.dart';
import 'package:pokidoki/features/messaging/data/local/mappers/local_message_mapper.dart';
import 'package:pokidoki/features/messaging/data/messaging_failure.dart';
import 'package:pokidoki/features/messaging/data/realtime/messaging_socket_service.dart';
import 'package:pokidoki/features/messaging/data/repository/offline_first_conversations_repository.dart';
import 'package:pokidoki/features/messaging/data/sync/messaging_sync_engine.dart';
import 'package:pokidoki/features/messaging/data/sync/outbound_message_queue_processor.dart';
import 'package:pokidoki/features/messaging/domain/local_message_status.dart';
import 'package:pokidoki/features/messaging/domain/queue_retry_scheduler.dart';

class FakeMessagingDatabaseKeyStore implements MessagingDatabaseKeyStore {
  String? _key;

  @override
  Future<void> deleteKey() async {
    _key = null;
  }

  @override
  Future<String?> readKey() async => _key;

  @override
  Future<void> writeKey(String hexKey) async {
    _key = hexKey;
  }
}

class FailingThenRecoveringRemote extends ApiConversationsRepository {
  FailingThenRecoveringRemote({
    required super.messagingApi,
    required super.errorMapper,
    required super.sessionManager,
  });

  int sendAttempts = 0;
  bool failSync = true;

  @override
  Future<ChatMessage> sendMessage({
    required String conversationId,
    required String clientMessageId,
    required String text,
  }) {
    sendAttempts++;
    if (failSync) {
      throw const MessagingFailure(code: 'CONNECTION_ERROR');
    }
    final sentAt = DateTime.utc(2026, 7, 6, 4, sendAttempts);
    return Future.value(
      ChatMessage(
        id: 'srv-$clientMessageId',
        conversationId: conversationId,
        clientMessageId: clientMessageId,
        senderId: 'u-me',
        body: text,
        sentAt: sentAt,
        isOutgoing: true,
        deliveryStatus: MessageDeliveryStatus.sent,
      ),
    );
  }
}

class EmptyHistoryRemote extends ApiConversationsRepository {
  EmptyHistoryRemote({
    required super.messagingApi,
    required super.errorMapper,
    required super.sessionManager,
  });

  @override
  Future<MessagePage> getMessages({
    required String conversationId,
    String? before,
    int limit = 50,
  }) {
    return Future.value(
      const MessagePage(items: [], nextCursor: null, hasMore: false),
    );
  }
}

OfflineFirstConversationsRepository _buildRepo({
  required MessagingDatabase db,
  required ApiConversationsRepository remote,
  required DateTime now,
  FakeMessagingSocketService? socket,
}) {
  final sync = MessagingSyncEngine(
    database: db,
    remote: remote,
    currentUserId: () => 'u-me',
  );
  final processor = OutboundMessageQueueProcessor(
    database: db,
    remote: remote,
    socketService: socket ?? FakeMessagingSocketService(),
    syncEngine: sync,
    currentUserId: () => 'u-me',
    retryScheduler: QueueRetryScheduler(random: Random(0)),
    clock: () => now,
  );
  return OfflineFirstConversationsRepository(
    database: db,
    remote: remote,
    syncEngine: sync,
    queueProcessor: processor,
    currentUserId: () => 'u-me',
  );
}

Future<bool> _cipherAvailable() async {
  final probe = MessagingDatabaseFactory(
    keyStore: FakeMessagingDatabaseKeyStore(),
  ).openInMemoryForTests();
  final rows = await probe.customSelect('PRAGMA cipher;').get();
  await probe.close();
  return rows.isNotEmpty &&
      rows.first.data.values.any((value) => '$value'.isNotEmpty);
}

void main() {
  final now = DateTime.utc(2026, 7, 6, 4);

  group('Offline queue recovery regression', () {
    late Directory tempDir;
    late FakeMessagingDatabaseKeyStore keyStore;
    late MessagingDatabaseFactory fileFactory;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('pokidoki-offline-');
      keyStore = FakeMessagingDatabaseKeyStore();
      await keyStore.writeKey('a' * 64);
      fileFactory = MessagingDatabaseFactory(
        keyStore: keyStore,
        databaseDirectory: tempDir,
      );
    });

    tearDown(() async {
      if (tempDir.existsSync()) {
        await tempDir.delete(recursive: true);
      }
    });

    test(
      'A — offline messages persist across database close and reopen',
      () async {
        if (!await _cipherAvailable()) {
          markTestSkipped(
            'File-backed encrypted DB requires sqlite3mc runtime.',
          );
          return;
        }

        final db1 = await fileFactory.openEncrypted();
        final remote = FailingThenRecoveringRemote(
          messagingApi: MessagingApi(Dio(BaseOptions(baseUrl: 'http://test'))),
          errorMapper: const ApiErrorMapper(),
          sessionManager: AuthSessionManager(),
        );
        final repo1 = _buildRepo(db: db1, remote: remote, now: now);
        final processor1 = repo1.queueProcessor;
        processor1.stop();

        for (var i = 1; i <= 3; i++) {
          await db1.transaction(() async {
            await db1.messagesDao.upsertPendingMessage(
              messageToInsertCompanion(
                clientMessageId: 'client-offline-$i',
                conversationId: 'conv-offline',
                senderId: 'u-me',
                text: 'offline $i',
                status: LocalMessageStatus.queued,
                syncState: LocalSyncState.pendingAck,
              ),
            );
            await db1.outboundQueueDao.enqueue(
              OutboundMessageQueueCompanion.insert(
                conversationId: 'conv-offline',
                clientMessageId: 'client-offline-$i',
                textPayload: 'offline $i',
                queueState: QueueState.pending.name,
                nextAttemptAt: now,
                createdAt: now,
                updatedAt: now,
              ),
            );
          });
        }

        expect(
          (await db1.messagesDao.getConversationMessages('conv-offline')),
          hasLength(3),
        );
        expect(await db1.outboundQueueDao.countPending(), 3);
        await db1.close();

        final db2 = await fileFactory.openEncrypted();
        final messages = await db2.messagesDao.getConversationMessages(
          'conv-offline',
        );
        expect(messages, hasLength(3));
        expect(messages.map((row) => row.clientMessageId).toSet(), {
          'client-offline-1',
          'client-offline-2',
          'client-offline-3',
        });
        expect(await db2.outboundQueueDao.countPending(), 3);
        await db2.close();
      },
    );

    test('C — remote sync cannot delete queued local messages', () async {
      final db = MessagingDatabaseFactory(
        keyStore: FakeMessagingDatabaseKeyStore(),
      ).openInMemoryForTests();
      final remote = EmptyHistoryRemote(
        messagingApi: MessagingApi(Dio(BaseOptions(baseUrl: 'http://test'))),
        errorMapper: const ApiErrorMapper(),
        sessionManager: AuthSessionManager(),
      );
      final repo = _buildRepo(db: db, remote: remote, now: now);
      repo.queueProcessor.stop();

      for (var i = 1; i <= 3; i++) {
        await db.transaction(() async {
          await db.messagesDao.upsertPendingMessage(
            messageToInsertCompanion(
              clientMessageId: 'client-sync-$i',
              conversationId: 'conv-sync',
              senderId: 'u-me',
              text: 'pending $i',
              status: LocalMessageStatus.queued,
              syncState: LocalSyncState.pendingAck,
            ),
          );
          await db.outboundQueueDao.enqueue(
            OutboundMessageQueueCompanion.insert(
              conversationId: 'conv-sync',
              clientMessageId: 'client-sync-$i',
              textPayload: 'pending $i',
              queueState: QueueState.pending.name,
              nextAttemptAt: now,
              createdAt: now,
              updatedAt: now,
            ),
          );
        });
      }

      final page = await repo.getMessages(conversationId: 'conv-sync');
      expect(page.items, hasLength(3));
      expect(await db.outboundQueueDao.countPending(), 3);
      await db.close();
    });

    test('D — backend recovery drains queue in FIFO order', () async {
      final db = fileFactory.openInMemoryForTests();
      final socket = FakeMessagingSocketService();
      await socket.disconnect();
      final remote = FailingThenRecoveringRemote(
        messagingApi: MessagingApi(Dio(BaseOptions(baseUrl: 'http://test'))),
        errorMapper: const ApiErrorMapper(),
        sessionManager: AuthSessionManager(),
      );
      final sync = MessagingSyncEngine(
        database: db,
        remote: remote,
        currentUserId: () => 'u-me',
      );
      final processor = OutboundMessageQueueProcessor(
        database: db,
        remote: remote,
        socketService: socket,
        syncEngine: sync,
        currentUserId: () => 'u-me',
        retryScheduler: QueueRetryScheduler(random: Random(0)),
        clock: () => now,
      );

      final ids = ['client-fifo-1', 'client-fifo-2', 'client-fifo-3'];
      for (var i = 0; i < ids.length; i++) {
        await db.outboundQueueDao.enqueue(
          OutboundMessageQueueCompanion.insert(
            conversationId: 'conv-fifo',
            clientMessageId: ids[i],
            textPayload: 'fifo $i',
            queueState: QueueState.pending.name,
            nextAttemptAt: now.add(Duration(seconds: i)),
            createdAt: now.add(Duration(seconds: i)),
            updatedAt: now,
          ),
        );
        await db.messagesDao.upsertPendingMessage(
          messageToInsertCompanion(
            clientMessageId: ids[i],
            conversationId: 'conv-fifo',
            senderId: 'u-me',
            text: 'fifo $i',
            status: LocalMessageStatus.queued,
            syncState: LocalSyncState.pendingAck,
          ),
        );
      }

      await processor.requestDrain();
      expect(remote.sendAttempts, 3);

      remote.failSync = false;
      await processor.releaseWaitingRetries(now: now);
      await processor.requestDrain();

      expect(remote.sendAttempts, 6);
      final completed = await (db.select(
        db.outboundMessageQueue,
      )..where((t) => t.queueState.equals(QueueState.completed.name))).get();
      expect(completed, hasLength(3));
      final rows = await db.messagesDao.getConversationMessages('conv-fifo');
      expect(rows, hasLength(3));
      expect(rows.every((row) => row.serverMessageId != null), isTrue);
      await db.close();
    });

    test('F — retryable versus permanent classification', () {
      final scheduler = QueueRetryScheduler();
      expect(scheduler.isTransientError('CONNECTION_ERROR'), isTrue);
      expect(scheduler.isTransientError('HTTP_503'), isTrue);
      expect(
        scheduler.isTransientError('SYNC_TEMPORARILY_UNAVAILABLE'),
        isTrue,
      );
      expect(scheduler.isPermanentError('MESSAGE_SEND_NOT_ALLOWED'), isTrue);
      expect(scheduler.isPermanentError('CONVERSATION_BLOCKED'), isTrue);
      expect(scheduler.isTransientError('MESSAGE_SEND_NOT_ALLOWED'), isFalse);
    });

    test('G — failedPermanent messages remain in local history', () async {
      final db = fileFactory.openInMemoryForTests();
      await db.messagesDao.upsertPendingMessage(
        messageToInsertCompanion(
          clientMessageId: 'client-failed',
          conversationId: 'conv-fail',
          senderId: 'u-me',
          text: 'blocked send',
          status: LocalMessageStatus.failedPermanent,
          syncState: LocalSyncState.localOnly,
          errorCode: 'MESSAGE_SEND_NOT_ALLOWED',
        ),
      );

      final rows = await db.messagesDao.getConversationMessages('conv-fail');
      expect(rows, hasLength(1));
      expect(
        rows.single.deliveryStatus,
        LocalMessageStatus.failedPermanent.name,
      );
      await db.close();
    });

    test(
      'unavailable transport marks waitingRetry not failedPermanent',
      () async {
        final db = fileFactory.openInMemoryForTests();
        final socket = FakeMessagingSocketService();
        await socket.disconnect();
        final remote = FailingThenRecoveringRemote(
          messagingApi: MessagingApi(Dio(BaseOptions(baseUrl: 'http://test'))),
          errorMapper: const ApiErrorMapper(),
          sessionManager: AuthSessionManager(),
        );
        final sync = MessagingSyncEngine(
          database: db,
          remote: remote,
          currentUserId: () => 'u-me',
        );
        final processor = OutboundMessageQueueProcessor(
          database: db,
          remote: remote,
          socketService: socket,
          syncEngine: sync,
          currentUserId: () => 'u-me',
          retryScheduler: QueueRetryScheduler(random: Random(0)),
          clock: () => now,
        );

        await db.outboundQueueDao.enqueue(
          OutboundMessageQueueCompanion.insert(
            conversationId: 'conv-retry',
            clientMessageId: 'client-retry',
            textPayload: 'retry me',
            queueState: QueueState.pending.name,
            nextAttemptAt: now,
            createdAt: now,
            updatedAt: now,
          ),
        );

        await processor.requestDrain();

        final queueRow = await (db.select(
          db.outboundMessageQueue,
        )..where((t) => t.clientMessageId.equals('client-retry'))).getSingle();
        expect(queueRow.queueState, QueueState.waitingRetry.name);
        expect(queueRow.queueState, isNot(QueueState.failedPermanent.name));
        await db.close();
      },
    );

    test(
      'recovery without connectivity event drains on socket connected',
      () async {
        final db = fileFactory.openInMemoryForTests();
        final socket = FakeMessagingSocketService();
        await socket.disconnect();
        final remote = FailingThenRecoveringRemote(
          messagingApi: MessagingApi(Dio(BaseOptions(baseUrl: 'http://test'))),
          errorMapper: const ApiErrorMapper(),
          sessionManager: AuthSessionManager(),
        );
        remote.failSync = true;
        final sync = MessagingSyncEngine(
          database: db,
          remote: remote,
          currentUserId: () => 'u-me',
        );
        final processor = OutboundMessageQueueProcessor(
          database: db,
          remote: remote,
          socketService: socket,
          syncEngine: sync,
          currentUserId: () => 'u-me',
          retryScheduler: QueueRetryScheduler(random: Random(0)),
          clock: () => now,
        );

        for (var i = 1; i <= 3; i++) {
          await db.outboundQueueDao.enqueue(
            OutboundMessageQueueCompanion.insert(
              conversationId: 'conv-wake',
              clientMessageId: 'client-wake-$i',
              textPayload: 'payload $i',
              queueState: QueueState.waitingRetry.name,
              nextAttemptAt: now.add(const Duration(minutes: 5)),
              createdAt: now.add(Duration(seconds: i)),
              updatedAt: now,
            ),
          );
          await db.messagesDao.upsertPendingMessage(
            messageToInsertCompanion(
              clientMessageId: 'client-wake-$i',
              conversationId: 'conv-wake',
              senderId: 'u-me',
              text: 'payload $i',
              status: LocalMessageStatus.queued,
              syncState: LocalSyncState.pendingAck,
            ),
          );
        }

        await socket.connect(
          accessToken: 'access-only',
          apiBaseUrl: 'http://127.0.0.1:3000/api/v1',
        );
        await socket.disconnect();
        remote.failSync = false;
        await processor.wakeAndDrain();

        final completed = await (db.select(
          db.outboundMessageQueue,
        )..where((t) => t.queueState.equals(QueueState.completed.name))).get();
        expect(completed, hasLength(3));
        expect(completed.first.clientMessageId, 'client-wake-1');
        await db.close();
      },
    );

    test(
      'new successful send wakes older waitingRetry rows in FIFO order',
      () async {
        final db = fileFactory.openInMemoryForTests();
        final socket = FakeMessagingSocketService();
        await socket.disconnect();
        final remote = FailingThenRecoveringRemote(
          messagingApi: MessagingApi(Dio(BaseOptions(baseUrl: 'http://test'))),
          errorMapper: const ApiErrorMapper(),
          sessionManager: AuthSessionManager(),
        );
        final sync = MessagingSyncEngine(
          database: db,
          remote: remote,
          currentUserId: () => 'u-me',
        );
        final processor = OutboundMessageQueueProcessor(
          database: db,
          remote: remote,
          socketService: socket,
          syncEngine: sync,
          currentUserId: () => 'u-me',
          retryScheduler: QueueRetryScheduler(random: Random(0)),
          clock: () => now,
        );

        for (var i = 1; i <= 3; i++) {
          await db.outboundQueueDao.enqueue(
            OutboundMessageQueueCompanion.insert(
              conversationId: 'conv-fifo-wake',
              clientMessageId: 'client-old-$i',
              textPayload: 'old $i',
              queueState: QueueState.waitingRetry.name,
              nextAttemptAt: now.add(const Duration(minutes: 5)),
              createdAt: now.add(Duration(seconds: i)),
              updatedAt: now,
            ),
          );
          await db.messagesDao.upsertPendingMessage(
            messageToInsertCompanion(
              clientMessageId: 'client-old-$i',
              conversationId: 'conv-fifo-wake',
              senderId: 'u-me',
              text: 'old $i',
              status: LocalMessageStatus.queued,
              syncState: LocalSyncState.pendingAck,
            ),
          );
        }

        remote.failSync = false;
        await db.outboundQueueDao.enqueue(
          OutboundMessageQueueCompanion.insert(
            conversationId: 'conv-fifo-wake',
            clientMessageId: 'client-new',
            textPayload: 'newest',
            queueState: QueueState.pending.name,
            nextAttemptAt: now.add(const Duration(seconds: 4)),
            createdAt: now.add(const Duration(seconds: 4)),
            updatedAt: now,
          ),
        );
        await db.messagesDao.upsertPendingMessage(
          messageToInsertCompanion(
            clientMessageId: 'client-new',
            conversationId: 'conv-fifo-wake',
            senderId: 'u-me',
            text: 'newest',
            status: LocalMessageStatus.queued,
            syncState: LocalSyncState.pendingAck,
          ),
        );
        await processor.wakeAndDrain();

        final completed = await (db.select(
          db.outboundMessageQueue,
        )..where((t) => t.queueState.equals(QueueState.completed.name))).get();
        expect(completed, hasLength(4));
        expect(completed.first.clientMessageId, 'client-old-1');
        await db.close();
      },
    );

    test('requeues failedPermanent transport rows with pending ack', () async {
      final db = fileFactory.openInMemoryForTests();
      await db.outboundQueueDao.enqueue(
        OutboundMessageQueueCompanion.insert(
          conversationId: 'conv-req',
          clientMessageId: 'client-req',
          textPayload: 'stuck',
          queueState: QueueState.failedPermanent.name,
          nextAttemptAt: now,
          createdAt: now,
          updatedAt: now,
          errorCode: const Value('MESSAGE_INVALID'),
        ),
      );
      await db.messagesDao.upsertPendingMessage(
        messageToInsertCompanion(
          clientMessageId: 'client-req',
          conversationId: 'conv-req',
          senderId: 'u-me',
          text: 'stuck',
          status: LocalMessageStatus.failedPermanent,
          syncState: LocalSyncState.pendingAck,
        ),
      );

      final socket = FakeMessagingSocketService();
      await socket.disconnect();
      final remote = FailingThenRecoveringRemote(
        messagingApi: MessagingApi(Dio(BaseOptions(baseUrl: 'http://test'))),
        errorMapper: const ApiErrorMapper(),
        sessionManager: AuthSessionManager(),
      );
      remote.failSync = false;
      final sync = MessagingSyncEngine(
        database: db,
        remote: remote,
        currentUserId: () => 'u-me',
      );
      final processor = OutboundMessageQueueProcessor(
        database: db,
        remote: remote,
        socketService: socket,
        syncEngine: sync,
        currentUserId: () => 'u-me',
        clock: () => now,
      );

      final requeued = await processor.requeueRecoverableTransportFailures();
      expect(requeued, 1);
      await processor.wakeAndDrain();
      expect(remote.sendAttempts, 1);
      await db.close();
    });

    test('UI maps queued with error to retrying delivery status', () async {
      final db = fileFactory.openInMemoryForTests();
      await db.messagesDao.upsertPendingMessage(
        messageToInsertCompanion(
          clientMessageId: 'client-ui',
          conversationId: 'conv-ui',
          senderId: 'u-me',
          text: 'retry soon',
          status: LocalMessageStatus.queued,
          syncState: LocalSyncState.pendingAck,
          errorCode: 'CONNECTION_ERROR',
        ),
      );
      final row = await db.messagesDao.getByClientId('client-ui');
      final message = row!.toDomain(currentUserId: 'u-me');
      expect(message.deliveryStatus, MessageDeliveryStatus.retrying);
      await db.close();
    });
  });
}
