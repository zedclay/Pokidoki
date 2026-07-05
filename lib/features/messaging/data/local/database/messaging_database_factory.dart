import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../messaging_failure.dart';
import 'messaging_database.dart';
import 'messaging_database_health.dart';
import 'messaging_database_key_generator.dart';
import 'messaging_database_key_store.dart';
import 'secure_messaging_database_key_store.dart';

const messagingDatabaseFileName = 'pokidoki_messages_v1.sqlite';

class MessagingDatabaseFactory {
  MessagingDatabaseFactory({
    MessagingDatabaseKeyStore? keyStore,
    Directory? databaseDirectory,
  }) : _keyStore = keyStore ?? SecureMessagingDatabaseKeyStore(),
       _databaseDirectory = databaseDirectory;

  final MessagingDatabaseKeyStore _keyStore;
  final Directory? _databaseDirectory;

  Future<MessagingDatabase> openEncrypted() async {
    final hexKey = await _resolveKey(createIfMissing: true);
    final file = await _databaseFile();
    final db = MessagingDatabase(
      await _openEncryptedExecutor(file: file, hexKey: hexKey),
    );
    await MessagingDatabaseHealth.verifyEncrypted(db);
    return db;
  }

  MessagingDatabase openInMemoryForTests({String? hexKey}) {
    final key = hexKey ?? MessagingDatabaseKeyGenerator.generateHexKey();
    final executor = LazyDatabase(() async {
      final db = sqlite3.openInMemory();
      _applyKey(db, key);
      return NativeDatabase.opened(db);
    });
    return MessagingDatabase(executor);
  }

  Future<void> wipeLocalDatabase() async {
    final file = await _databaseFile();
    if (await file.exists()) {
      await file.delete();
    }
    for (final suffix in ['-wal', '-shm']) {
      final sidecar = File('${file.path}$suffix');
      if (await sidecar.exists()) {
        await sidecar.delete();
      }
    }
    await _keyStore.deleteKey();
  }

  Future<String> _resolveKey({required bool createIfMissing}) async {
    var key = await _keyStore.readKey();
    final file = await _databaseFile();
    final fileExists = await file.exists();

    if (key == null && fileExists) {
      await _deleteOrphanDatabase(file);
      key = MessagingDatabaseKeyGenerator.generateHexKey();
      await _keyStore.writeKey(key);
      return key;
    }

    if (key == null) {
      if (!createIfMissing) {
        throw const MessagingFailure(code: 'LOCAL_DATABASE_KEY_UNAVAILABLE');
      }
      key = MessagingDatabaseKeyGenerator.generateHexKey();
      await _keyStore.writeKey(key);
    }

    return key;
  }

  Future<void> _deleteOrphanDatabase(File file) async {
    if (await file.exists()) {
      await file.delete();
    }
    for (final suffix in ['-wal', '-shm']) {
      final sidecar = File('${file.path}$suffix');
      if (await sidecar.exists()) {
        await sidecar.delete();
      }
    }
  }

  Future<File> _databaseFile() async {
    final databaseDirectory = _databaseDirectory;
    if (databaseDirectory != null) {
      return File(p.join(databaseDirectory.path, messagingDatabaseFileName));
    }
    final dir = await getApplicationSupportDirectory();
    return File(p.join(dir.path, messagingDatabaseFileName));
  }

  Future<QueryExecutor> _openEncryptedExecutor({
    required File file,
    required String hexKey,
  }) async {
    return LazyDatabase(() async {
      final db = sqlite3.open(file.path);
      try {
        _applyKey(db, hexKey);
        db.execute('SELECT count(*) FROM sqlite_master');
        return NativeDatabase.opened(db);
      } on Object {
        db.dispose();
        await _handleCorruptDatabase(file, hexKey);
        rethrow;
      }
    });
  }

  Future<void> _handleCorruptDatabase(File file, String hexKey) async {
    await _deleteOrphanDatabase(file);
    await _keyStore.deleteKey();
    final freshKey = MessagingDatabaseKeyGenerator.generateHexKey();
    await _keyStore.writeKey(freshKey);
    throw const MessagingFailure(code: 'LOCAL_DATABASE_CORRUPT');
  }

  void _applyKey(Database db, String hexKey) {
    final escaped = MessagingDatabaseKeyGenerator.escapeForPragma(hexKey);
    db.execute('PRAGMA hexkey = $escaped;');
  }
}
