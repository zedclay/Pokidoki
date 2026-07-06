import 'dart:io';

import 'package:sqlite3/sqlite3.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pokidoki/data/models/conversation.dart';
import 'package:pokidoki/features/messaging/data/local/database/messaging_database.dart';
import 'package:pokidoki/features/messaging/data/local/database/messaging_database_factory.dart';
import 'package:pokidoki/features/messaging/data/local/database/messaging_database_health.dart';
import 'package:pokidoki/features/messaging/data/local/database/messaging_database_key_store.dart';
import 'package:pokidoki/features/messaging/data/local/database/secure_messaging_database_key_store.dart';
import 'package:pokidoki/features/messaging/data/local/mappers/local_conversation_mapper.dart';
import 'package:pokidoki/features/messaging/data/local/database/messaging_database_key_generator.dart';

class _TestMessagingDatabaseKeyStore implements MessagingDatabaseKeyStore {
  _TestMessagingDatabaseKeyStore({SecureMessagingDatabaseKeyStore? secure})
    : _secure = secure;

  final SecureMessagingDatabaseKeyStore? _secure;
  String? _memoryKey;

  @override
  Future<void> deleteKey() async {
    _memoryKey = null;
    await _secure?.deleteKey();
  }

  @override
  Future<String?> readKey() async {
    return _memoryKey ?? await _secure?.readKey();
  }

  @override
  Future<void> writeKey(String hexKey) async {
    _memoryKey = hexKey;
    await _secure?.writeKey(hexKey);
  }
}

Future<String?> _readCipherImplementation(MessagingDatabase db) async {
  final rows = await db.customSelect('PRAGMA cipher;').get();
  if (rows.isEmpty) {
    return null;
  }
  for (final value in rows.first.data.values) {
    final text = '$value'.trim();
    if (text.isNotEmpty) {
      return text;
    }
  }
  return null;
}

Future<String?> _readCipherFromFreshConnection() async {
  final db = sqlite3.openInMemory();
  try {
    final rows = db.select('PRAGMA cipher;');
    if (rows.isEmpty) {
      return null;
    }
    for (final value in rows.first.values) {
      final text = '$value'.trim();
      if (text.isNotEmpty) {
        return text;
      }
    }
    return null;
  } finally {
    db.close();
  }
}

Future<void> _expectSidecarsAbsent(Directory directory) async {
  final base = File('${directory.path}/$messagingDatabaseFileName');
  expect(await base.exists(), isFalse);
  expect(await File('${base.path}-wal').exists(), isFalse);
  expect(await File('${base.path}-shm').exists(), isFalse);
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late _TestMessagingDatabaseKeyStore keyStore;
  late MessagingDatabaseFactory factory;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp(
      'pokidoki-device-encryption-',
    );
    keyStore = _TestMessagingDatabaseKeyStore(
      secure: SecureMessagingDatabaseKeyStore(),
    );
    await keyStore.deleteKey();
    factory = MessagingDatabaseFactory(
      keyStore: keyStore,
      databaseDirectory: tempDir,
    );
  });

  tearDown(() async {
    await factory.wipeLocalDatabase();
    if (tempDir.existsSync()) {
      await tempDir.delete(recursive: true);
    }
  });

  testWidgets('device sqlite3mc encryption health', (tester) async {
    final cipherPlugin = await _readCipherFromFreshConnection();
    expect(cipherPlugin, isNotNull);
    expect(cipherPlugin, isNotEmpty);

    final db = await factory.openEncrypted();
    final cipher = await _readCipherImplementation(db);
    expect(cipher, isNotNull);
    expect(cipher, isNotEmpty);

    await MessagingDatabaseHealth.verifyEncrypted(db);

    const testConversationId = 'device-encryption-health';
    await db.conversationsDao.upsert(
      conversationToCompanion(
        Conversation(
          id: testConversationId,
          peerId: 'peer-device-test',
          peerDisplayName: 'Device Test',
          peerUsername: 'device-test',
          updatedAt: DateTime.utc(2026, 1, 1),
        ),
      ),
    );

    final tables = await db
        .customSelect("SELECT name FROM sqlite_master WHERE type='table'")
        .get();
    final tableNames = tables.map((row) => row.read<String>('name')).toList();
    expect(
      tableNames.any((name) => name.toLowerCase().contains('key')),
      isFalse,
    );

    await db.close();

    final reopened = await factory.openEncrypted();
    final rows = await reopened.conversationsDao.getAllOrdered();
    expect(rows.any((row) => row.conversationId == testConversationId), isTrue);
    await reopened.close();

    final dbFile = File('${tempDir.path}/$messagingDatabaseFileName');
    expect(await dbFile.exists(), isTrue);
    expect(await keyStore.readKey(), isNotNull);

    final wrongKeyDb = sqlite3.open(dbFile.path);
    try {
      MessagingDatabaseHealth.verifyCipherAvailable(wrongKeyDb);
      final escaped = MessagingDatabaseKeyGenerator.escapeForPragma('0' * 64);
      wrongKeyDb.execute('PRAGMA hexkey = $escaped;');
      expect(
        () => wrongKeyDb.select('SELECT count(*) FROM sqlite_master'),
        throwsA(isA<SqliteException>()),
      );
    } finally {
      wrongKeyDb.close();
    }

    expect(await dbFile.exists(), isTrue);

    await factory.wipeLocalDatabase();
    await _expectSidecarsAbsent(tempDir);
    expect(await keyStore.readKey(), isNull);

    final fresh = await factory.openEncrypted();
    final freshRows = await fresh.conversationsDao.getAllOrdered();
    expect(freshRows, isEmpty);
    await fresh.close();
  });
}
