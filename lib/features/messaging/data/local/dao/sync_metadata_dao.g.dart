// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_metadata_dao.dart';

// ignore_for_file: type=lint
mixin _$SyncMetadataDaoMixin on DatabaseAccessor<MessagingDatabase> {
  $MessagingSyncMetadataTable get messagingSyncMetadata =>
      attachedDatabase.messagingSyncMetadata;
  SyncMetadataDaoManager get managers => SyncMetadataDaoManager(this);
}

class SyncMetadataDaoManager {
  final _$SyncMetadataDaoMixin _db;
  SyncMetadataDaoManager(this._db);
  $$MessagingSyncMetadataTableTableManager get messagingSyncMetadata =>
      $$MessagingSyncMetadataTableTableManager(
        _db.attachedDatabase,
        _db.messagingSyncMetadata,
      );
}
