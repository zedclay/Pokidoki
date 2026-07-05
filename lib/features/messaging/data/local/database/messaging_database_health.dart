import 'package:flutter/foundation.dart';

import '../../messaging_failure.dart';
import 'messaging_database.dart';

class MessagingDatabaseHealth {
  const MessagingDatabaseHealth._();

  static Future<void> verifyEncrypted(MessagingDatabase db) async {
    final rows = await db.customSelect('PRAGMA cipher;').get();
    if (rows.isEmpty || rows.first.data.values.every((v) => '$v'.isEmpty)) {
      if (kDebugMode) {
        throw const MessagingFailure(
          code: 'LOCAL_DATABASE_ENCRYPTION_UNAVAILABLE',
        );
      }
      throw const MessagingFailure(
        code: 'LOCAL_DATABASE_ENCRYPTION_UNAVAILABLE',
      );
    }
  }
}
