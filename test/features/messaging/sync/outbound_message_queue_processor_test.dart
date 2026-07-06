import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/core/network/api_error_mapper.dart';
import 'package:pokidoki/core/network/auth_session_manager.dart';
import 'package:pokidoki/data/models/message.dart';
import 'package:pokidoki/features/messaging/data/api/api_conversations_repository.dart';
import 'package:pokidoki/features/messaging/data/api/messaging_api.dart';
import 'package:pokidoki/features/messaging/data/local/database/messaging_database.dart';
import 'package:pokidoki/features/messaging/data/local/database/messaging_database_factory.dart';
import 'package:pokidoki/features/messaging/data/local/database/messaging_database_key_store.dart';
import 'package:pokidoki/features/messaging/data/messaging_failure.dart';
import 'package:pokidoki/features/messaging/data/realtime/messaging_socket_service.dart';
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

class TestApiRemote extends ApiConversationsRepository {
  TestApiRemote({
    required super.messagingApi,
    required super.errorMapper,
    required super.sessionManager,
  });

  int sendCount = 0;

  @override
  Future<ChatMessage> sendMessage({
    required String conversationId,
    required String clientMessageId,
    required String text,
  }) {
    sendCount++;
    throw const MessagingFailure(code: 'REST_SHOULD_NOT_RUN');
  }
}

Future<void> _enqueueItem({
  required MessagingDatabase db,
  required String clientMessageId,
  required DateTime createdAt,
}) async {
  await db.outboundQueueDao.enqueue(
    OutboundMessageQueueCompanion.insert(
      conversationId: 'c1',
      clientMessageId: clientMessageId,
      textPayload: 'queued-text',
      queueState: QueueState.pending.name,
      nextAttemptAt: createdAt,
      createdAt: createdAt,
      updatedAt: createdAt,
    ),
  );
}

void main() {
  late MessagingDatabase db;
  late FakeMessagingSocketService socket;
  late TestApiRemote remote;
  late MessagingSyncEngine sync;
  late OutboundMessageQueueProcessor processor;
  final now = DateTime.utc(2026, 1, 1, 12);

  setUp(() async {
    final factory = MessagingDatabaseFactory(
      keyStore: FakeMessagingDatabaseKeyStore(),
    );
    db = factory.openInMemoryForTests();
    socket = FakeMessagingSocketService();
    await socket.connect(
      accessToken: 'access-only',
      apiBaseUrl: 'http://127.0.0.1:3000/api/v1',
    );
    remote = TestApiRemote(
      messagingApi: MessagingApi(Dio(BaseOptions(baseUrl: 'http://test'))),
      errorMapper: const ApiErrorMapper(),
      sessionManager: AuthSessionManager(),
    );
    sync = MessagingSyncEngine(
      database: db,
      remote: remote,
      currentUserId: () => 'u-me',
    );
    processor = OutboundMessageQueueProcessor(
      database: db,
      remote: remote,
      socketService: socket,
      syncEngine: sync,
      currentUserId: () => 'u-me',
      retryScheduler: QueueRetryScheduler(random: Random(0)),
      clock: () => now,
    );
  });

  tearDown(() async {
    await db.close();
  });

  test('FIFO processes oldest queue item first', () async {
    await _enqueueItem(db: db, clientMessageId: 'client-newer', createdAt: now);
    await _enqueueItem(
      db: db,
      clientMessageId: 'client-older',
      createdAt: now.subtract(const Duration(minutes: 5)),
    );

    final next = await db.outboundQueueDao.acquireNextEligible(now);
    expect(next?.clientMessageId, 'client-older');

    await processor.requestDrain();

    final completed = await (db.select(
      db.outboundMessageQueue,
    )..where((t) => t.queueState.equals(QueueState.completed.name))).get();
    expect(completed, hasLength(2));
  });

  test('concurrent drain triggers cannot send one item twice', () async {
    await socket.disconnect();
    await _enqueueItem(db: db, clientMessageId: 'client-1', createdAt: now);

    final first = processor.requestDrain();
    final second = processor.requestDrain();
    await Future.wait([first, second]);

    expect(remote.sendCount, 1);
    expect(await db.outboundQueueDao.countPending(), 1);
  });

  test('permanent socket errors stop retries', () async {
    await _enqueueItem(db: db, clientMessageId: 'client-perm', createdAt: now);
    socket.failNextSend = true;

    await processor.requestDrain();
    await processor.requestDrain();

    expect(await db.outboundQueueDao.countPending(), 0);
    final queueRow = await (db.select(
      db.outboundMessageQueue,
    )..where((t) => t.clientMessageId.equals('client-perm'))).getSingleOrNull();
    expect(queueRow?.queueState, QueueState.failedPermanent.name);
  });

  test('stale inFlight item returns to eligible retry state', () async {
    await db.outboundQueueDao.enqueue(
      OutboundMessageQueueCompanion.insert(
        conversationId: 'c1',
        clientMessageId: 'client-stale',
        textPayload: 'retry',
        queueState: QueueState.inFlight.name,
        inFlightSince: Value(now.subtract(const Duration(minutes: 10))),
        nextAttemptAt: now,
        createdAt: now,
        updatedAt: now,
      ),
    );

    await processor.recoverStaleJobs();
    expect(await db.outboundQueueDao.countPending(), 1);
  });

  test('queue survives database close and reopen on disk', () async {
    await db.close();
    final tempDir = await Directory.systemTemp.createTemp('pokidoki-queue-');
    addTearDown(() async {
      if (tempDir.existsSync()) {
        await tempDir.delete(recursive: true);
      }
    });

    final keyStore = FakeMessagingDatabaseKeyStore();
    final fileFactory = MessagingDatabaseFactory(
      keyStore: keyStore,
      databaseDirectory: tempDir,
    );
    final probeFactory = MessagingDatabaseFactory(
      keyStore: FakeMessagingDatabaseKeyStore(),
    );
    final probe = probeFactory.openInMemoryForTests();
    final rows = await probe.customSelect('PRAGMA cipher;').get();
    await probe.close();
    final cipherAvailable =
        rows.isNotEmpty &&
        rows.first.data.values.any((value) => '$value'.isNotEmpty);
    if (!cipherAvailable) {
      markTestSkipped('Queue persistence on disk requires sqlite3mc runtime.');
      return;
    }

    final db1 = await fileFactory.openEncrypted();
    await _enqueueItem(
      db: db1,
      clientMessageId: 'client-persist',
      createdAt: now,
    );
    await db1.close();

    final db2 = await fileFactory.openEncrypted();
    expect(await db2.outboundQueueDao.countPending(), 1);
    await db2.close();
  });

  test('logout wipe clears queue table', () async {
    await _enqueueItem(
      db: db,
      clientMessageId: 'client-logout',
      createdAt: now,
    );
    expect(await db.outboundQueueDao.countPending(), 1);
    await db.outboundQueueDao.clearAll();
    expect(await db.outboundQueueDao.countPending(), 0);
  });
}
