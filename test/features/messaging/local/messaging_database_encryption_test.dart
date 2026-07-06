import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/data/models/conversation.dart';
import 'package:pokidoki/features/messaging/data/local/database/messaging_database.dart';
import 'package:pokidoki/features/messaging/data/local/database/messaging_database_factory.dart';
import 'package:pokidoki/features/messaging/data/local/database/messaging_database_health.dart';
import 'package:pokidoki/features/messaging/data/local/database/messaging_database_key_store.dart';
import 'package:pokidoki/features/messaging/data/local/mappers/local_conversation_mapper.dart';
import 'package:pokidoki/features/messaging/data/messaging_failure.dart';

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

class _DelayedKeyStore implements MessagingDatabaseKeyStore {
  _DelayedKeyStore({
    required this.resolvedKey,
    required this.nullReadsBeforeResolve,
  });

  final String? resolvedKey;
  final int nullReadsBeforeResolve;
  int _reads = 0;

  @override
  Future<void> deleteKey() async {}

  @override
  Future<String?> readKey() async {
    _reads += 1;
    if (_reads <= nullReadsBeforeResolve) {
      return null;
    }
    return resolvedKey;
  }

  @override
  Future<void> writeKey(String hexKey) async {}
}

Future<bool> _cipherAvailable(MessagingDatabase db) async {
  final rows = await db.customSelect('PRAGMA cipher;').get();
  return rows.isNotEmpty &&
      rows.first.data.values.any((value) => '$value'.isNotEmpty);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late FakeMessagingDatabaseKeyStore keyStore;
  late MessagingDatabaseFactory factory;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('pokidoki-db-test-');
    keyStore = FakeMessagingDatabaseKeyStore();
    factory = MessagingDatabaseFactory(
      keyStore: keyStore,
      databaseDirectory: tempDir,
    );
  });

  tearDown(() async {
    if (tempDir.existsSync()) {
      await tempDir.delete(recursive: true);
    }
  });

  test('encryption key is stored only in MessagingDatabaseKeyStore', () async {
    final db = factory.openInMemoryForTests();
    final tables = await db
        .customSelect("SELECT name FROM sqlite_master WHERE type='table'")
        .get();
    final names = tables.map((row) => row.read<String>('name')).toList();
    expect(names.any((name) => name.toLowerCase().contains('key')), isFalse);
    await db.close();
  });

  test('PRAGMA cipher is non-empty when sqlite3mc is linked', () async {
    final db = factory.openInMemoryForTests();
    if (!await _cipherAvailable(db)) {
      await db.close();
      markTestSkipped(
        'Host VM tests use plain sqlite3; sqlite3mc runs on device builds.',
      );
      return;
    }
    await MessagingDatabaseHealth.verifyEncrypted(db);
    await db.close();
  });

  test('database opens with correct key and rejects wrong key', () async {
    final probe = factory.openInMemoryForTests();
    if (!await _cipherAvailable(probe)) {
      await probe.close();
      markTestSkipped('Wrong-key validation requires sqlite3mc runtime.');
      return;
    }
    await probe.close();

    final db = await factory.openEncrypted();
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
    await db.close();

    final wrongKeyStore = FakeMessagingDatabaseKeyStore();
    await wrongKeyStore.writeKey('0' * 64);
    final wrongFactory = MessagingDatabaseFactory(
      keyStore: wrongKeyStore,
      databaseDirectory: tempDir,
    );

    await expectLater(
      wrongFactory.openEncrypted(),
      throwsA(isA<MessagingFailure>()),
    );
  });

  test('transient key miss does not wipe existing database', () async {
    final probe = factory.openInMemoryForTests();
    if (!await _cipherAvailable(probe)) {
      await probe.close();
      markTestSkipped('Transient key recovery requires sqlite3mc runtime.');
      return;
    }
    await probe.close();

    final db = await factory.openEncrypted();
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
    await db.close();

    final delayedKeyStore = _DelayedKeyStore(
      resolvedKey: await keyStore.readKey(),
      nullReadsBeforeResolve: 2,
    );
    final delayedFactory = MessagingDatabaseFactory(
      keyStore: delayedKeyStore,
      databaseDirectory: tempDir,
    );
    final reopened = await delayedFactory.openEncrypted();
    final conversations = await reopened.conversationsDao.getAllOrdered();
    expect(conversations, hasLength(1));
    expect(conversations.first.conversationId, 'c1');
    await reopened.close();
  });

  test('missing key with existing database wipes local cache only', () async {
    final probe = factory.openInMemoryForTests();
    if (!await _cipherAvailable(probe)) {
      await probe.close();
      markTestSkipped('Orphan database recovery requires sqlite3mc runtime.');
      return;
    }
    await probe.close();

    final db = await factory.openEncrypted();
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
    await db.close();

    final orphanKeyStore = FakeMessagingDatabaseKeyStore();
    final orphanFactory = MessagingDatabaseFactory(
      keyStore: orphanKeyStore,
      databaseDirectory: tempDir,
    );
    final reopened = await orphanFactory.openEncrypted();
    final conversations = await reopened.conversationsDao.getAllOrdered();
    expect(conversations, isEmpty);
    expect(await orphanKeyStore.readKey(), isNotNull);
    await reopened.close();
  });

  test('logout wipe removes database file and key', () async {
    final dbFile = File('${tempDir.path}/$messagingDatabaseFileName');
    await dbFile.writeAsString('placeholder');
    await keyStore.writeKey('a' * 64);

    await factory.wipeLocalDatabase();

    expect(await dbFile.exists(), isFalse);
    expect(await keyStore.readKey(), isNull);
  });
}
