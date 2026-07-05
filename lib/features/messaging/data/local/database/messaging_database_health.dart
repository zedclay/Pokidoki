import 'package:sqlite3/sqlite3.dart';

import '../../messaging_failure.dart';
import 'messaging_database.dart';

class MessagingDatabaseHealth {
  const MessagingDatabaseHealth._();

  /// Confirms SQLite3MultipleCiphers is linked before any key is applied.
  static void verifyCipherAvailable(Database rawDatabase) {
    final rows = rawDatabase.select('PRAGMA cipher;');
    if (rows.isEmpty) {
      throw const MessagingFailure(
        code: 'LOCAL_DATABASE_ENCRYPTION_UNAVAILABLE',
      );
    }
    final hasCipher = rows.first.values.any(
      (value) => '$value'.trim().isNotEmpty,
    );
    if (!hasCipher) {
      throw const MessagingFailure(
        code: 'LOCAL_DATABASE_ENCRYPTION_UNAVAILABLE',
      );
    }
  }

  static Future<void> verifyEncrypted(MessagingDatabase db) async {
    await db.customSelect('SELECT count(*) FROM sqlite_master').get();
  }
}
