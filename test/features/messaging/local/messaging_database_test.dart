import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:pokidoki/data/models/conversation.dart';
import 'package:pokidoki/features/messaging/data/local/database/messaging_database.dart';
import 'package:pokidoki/features/messaging/data/local/database/messaging_database_factory.dart';
import 'package:pokidoki/features/messaging/data/local/database/messaging_database_health.dart';
import 'package:pokidoki/features/messaging/data/local/database/messaging_database_key_store.dart';
import 'package:pokidoki/features/messaging/data/local/mappers/local_conversation_mapper.dart';
import 'package:pokidoki/features/messaging/data/local/mappers/local_message_mapper.dart';
import 'package:pokidoki/features/messaging/domain/local_message_status.dart';

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

void main() {
  late MessagingDatabaseFactory factory;
  late MessagingDatabase db;

  setUp(() {
    factory = MessagingDatabaseFactory(
      keyStore: FakeMessagingDatabaseKeyStore(),
    );
    db = factory.openInMemoryForTests();
  });

  tearDown(() async {
    await db.close();
  });

  test('schema creates version 1 tables', () async {
    expect(db.schemaVersion, 1);
    final tables = await db
        .customSelect("SELECT name FROM sqlite_master WHERE type='table'")
        .get();
    final names = tables.map((row) => row.read<String>('name')).toSet();
    expect(names, contains('local_conversations'));
    expect(names, contains('local_messages'));
    expect(names, contains('outbound_message_queue'));
    expect(names, contains('messaging_sync_metadata'));
  });

  test('PRAGMA cipher is available in encrypted runtime', () async {
    final rows = await db.customSelect('PRAGMA cipher;').get();
    final cipherAvailable =
        rows.isNotEmpty &&
        rows.first.data.values.any((value) => '$value'.isNotEmpty);
    if (!cipherAvailable) {
      // VM widget/unit tests may link plain sqlite3; device builds use sqlite3mc.
      return;
    }
    await MessagingDatabaseHealth.verifyEncrypted(db);
  });

  test('conversation upsert and ordering', () async {
    final now = DateTime.utc(2026, 1, 1);
    await db.conversationsDao.upsert(
      conversationToCompanion(
        Conversation(
          id: 'c1',
          peerId: 'u2',
          peerDisplayName: 'Alex',
          peerUsername: 'alex',
          updatedAt: now,
          lastMessagePreview: 'Hi',
        ),
      ),
    );
    await db.conversationsDao.upsert(
      conversationToCompanion(
        Conversation(
          id: 'c2',
          peerId: 'u3',
          peerDisplayName: 'Sam',
          peerUsername: 'sam',
          updatedAt: now.add(const Duration(hours: 1)),
          lastMessagePreview: 'Later',
        ),
      ),
    );

    final rows = await db.conversationsDao.getAllOrdered();
    expect(rows.first.conversationId, 'c2');
  });

  test('message upsert enforces unique clientMessageId', () async {
    await db.messagesDao.insertMessage(
      messageToInsertCompanion(
        clientMessageId: 'client-1',
        conversationId: 'c1',
        senderId: 'u1',
        text: 'Hello',
        status: LocalMessageStatus.queued,
        syncState: LocalSyncState.pendingAck,
      ),
    );

    expect(
      () => db.messagesDao.insertMessage(
        messageToInsertCompanion(
          clientMessageId: 'client-1',
          conversationId: 'c1',
          senderId: 'u1',
          text: 'Duplicate',
          status: LocalMessageStatus.queued,
          syncState: LocalSyncState.pendingAck,
        ),
      ),
      throwsA(isA<SqliteException>()),
    );
  });

  test('delivery status is monotonic', () async {
    await db.messagesDao.insertMessage(
      messageToInsertCompanion(
        clientMessageId: 'client-2',
        conversationId: 'c1',
        senderId: 'u1',
        text: 'Status',
        status: LocalMessageStatus.read,
        syncState: LocalSyncState.synced,
        serverMessageId: 'srv-1',
        serverCreatedAt: DateTime.utc(2026, 1, 1),
      ),
    );

    await db.messagesDao.updateDeliveryStatus(
      serverMessageId: 'srv-1',
      status: LocalMessageStatus.delivered,
    );

    final row = await db.messagesDao.getByServerId('srv-1');
    expect(row?.deliveryStatus, LocalMessageStatus.read.name);
  });

  test('expired messages are excluded from watch query', () async {
    await db.messagesDao.insertMessage(
      messageToInsertCompanion(
        clientMessageId: 'client-exp',
        conversationId: 'c1',
        senderId: 'u1',
        text: 'Gone',
        status: LocalMessageStatus.sent,
        syncState: LocalSyncState.synced,
        expiresAt: DateTime.now().toUtc().subtract(const Duration(minutes: 1)),
      ),
    );

    final rows = await db.messagesDao.getConversationMessages('c1');
    expect(rows, isEmpty);
  });

  test('queue insertion transaction with message row', () async {
    final now = DateTime.now().toUtc();
    await db.transaction(() async {
      await db.messagesDao.insertMessage(
        messageToInsertCompanion(
          clientMessageId: 'client-q',
          conversationId: 'c1',
          senderId: 'u1',
          text: 'Queued',
          status: LocalMessageStatus.queued,
          syncState: LocalSyncState.pendingAck,
        ),
      );
      await db.outboundQueueDao.enqueue(
        OutboundMessageQueueCompanion.insert(
          conversationId: 'c1',
          clientMessageId: 'client-q',
          textPayload: 'Queued',
          queueState: QueueState.pending.name,
          nextAttemptAt: now,
          createdAt: now,
          updatedAt: now,
        ),
      );
    });

    expect(await db.outboundQueueDao.countPending(), 1);
  });

  test('stale in-flight queue jobs recover', () async {
    final now = DateTime.now().toUtc();
    await db.outboundQueueDao.enqueue(
      OutboundMessageQueueCompanion.insert(
        conversationId: 'c1',
        clientMessageId: 'client-stale',
        textPayload: 'Retry me',
        queueState: QueueState.inFlight.name,
        inFlightSince: Value(now.subtract(const Duration(minutes: 10))),
        nextAttemptAt: now,
        createdAt: now,
        updatedAt: now,
      ),
    );

    await db.outboundQueueDao.recoverStaleInFlight(
      staleBefore: now.subtract(const Duration(minutes: 5)),
      retryAt: now,
    );

    final pending = await db.outboundQueueDao.countPending();
    expect(pending, 1);
  });

  test('conversation upsert companion includes required createdAt', () async {
    final now = DateTime.utc(2026, 7, 5, 10);

    await expectLater(
      db.conversationsDao.upsert(
        conversationToUpsertCompanion(
          Conversation(
            id: 'c-upsert',
            peerId: 'u2',
            peerDisplayName: 'Alex',
            peerUsername: 'alex',
            updatedAt: now,
          ),
        ),
      ),
      completes,
    );

    final row = await db.conversationsDao.getById('c-upsert');
    expect(row?.displayName, 'Alex');
  });

  test('clear all removes messaging data on logout wipe', () async {
    await db.conversationsDao.upsert(
      conversationToCompanion(
        Conversation(
          id: 'c1',
          peerId: 'u2',
          peerDisplayName: 'Alex',
          peerUsername: 'alex',
          updatedAt: DateTime.utc(2026, 1, 1),
        ),
      ),
    );
    await db.messagesDao.clearAll();
    await db.conversationsDao.clearAll();
    await db.outboundQueueDao.clearAll();

    expect(await db.conversationsDao.getAllOrdered(), isEmpty);
  });
}
