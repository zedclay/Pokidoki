// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outbound_queue_dao.dart';

// ignore_for_file: type=lint
mixin _$OutboundQueueDaoMixin on DatabaseAccessor<MessagingDatabase> {
  $OutboundMessageQueueTable get outboundMessageQueue =>
      attachedDatabase.outboundMessageQueue;
  OutboundQueueDaoManager get managers => OutboundQueueDaoManager(this);
}

class OutboundQueueDaoManager {
  final _$OutboundQueueDaoMixin _db;
  OutboundQueueDaoManager(this._db);
  $$OutboundMessageQueueTableTableManager get outboundMessageQueue =>
      $$OutboundMessageQueueTableTableManager(
        _db.attachedDatabase,
        _db.outboundMessageQueue,
      );
}
