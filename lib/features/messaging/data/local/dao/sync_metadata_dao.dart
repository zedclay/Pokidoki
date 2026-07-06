import 'package:drift/drift.dart';

import '../database/messaging_database.dart';
import '../tables/messaging_sync_metadata.dart';

part 'sync_metadata_dao.g.dart';

@DriftAccessor(tables: [MessagingSyncMetadata])
class SyncMetadataDao extends DatabaseAccessor<MessagingDatabase>
    with _$SyncMetadataDaoMixin {
  SyncMetadataDao(super.db);

  Future<String?> read(String key) async {
    final row = await (select(
      messagingSyncMetadata,
    )..where((t) => t.key.equals(key))).getSingleOrNull();
    return row?.value;
  }

  Future<void> write(String key, String value) {
    return into(messagingSyncMetadata).insertOnConflictUpdate(
      MessagingSyncMetadataCompanion.insert(
        key: key,
        value: value,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }

  Future<void> clearAll() => delete(messagingSyncMetadata).go();
}
