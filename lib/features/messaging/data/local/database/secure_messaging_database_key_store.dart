import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'messaging_database_key_store.dart';

class SecureMessagingDatabaseKeyStore implements MessagingDatabaseKeyStore {
  SecureMessagingDatabaseKeyStore({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  @override
  Future<String?> readKey() {
    return _storage.read(key: messagingDatabaseKeyStorageId);
  }

  @override
  Future<void> writeKey(String hexKey) {
    return _storage.write(key: messagingDatabaseKeyStorageId, value: hexKey);
  }

  @override
  Future<void> deleteKey() {
    return _storage.delete(key: messagingDatabaseKeyStorageId);
  }
}

class InMemoryMessagingDatabaseKeyStore implements MessagingDatabaseKeyStore {
  String? _key;

  @override
  Future<String?> readKey() async => _key;

  @override
  Future<void> writeKey(String hexKey) async {
    _key = hexKey;
  }

  @override
  Future<void> deleteKey() async {
    _key = null;
  }
}
