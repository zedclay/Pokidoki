abstract interface class MessagingDatabaseKeyStore {
  Future<String?> readKey();

  Future<void> writeKey(String hexKey);

  Future<void> deleteKey();
}

const messagingDatabaseKeyStorageId = 'pokidoki.local_database.key.v1';
