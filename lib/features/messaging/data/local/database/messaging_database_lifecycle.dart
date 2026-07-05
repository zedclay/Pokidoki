import 'dart:async';

import 'messaging_database.dart';
import 'messaging_database_factory.dart';
import '../../sync/outbound_message_queue_processor.dart';

class MessagingDatabaseLifecycle {
  MessagingDatabaseLifecycle({MessagingDatabaseFactory? factory})
    : _factory = factory ?? MessagingDatabaseFactory();

  final MessagingDatabaseFactory _factory;
  MessagingDatabase? _database;
  OutboundMessageQueueProcessor? _queueProcessor;

  MessagingDatabase? get database => _database;

  OutboundMessageQueueProcessor? get queueProcessor => _queueProcessor;

  void attachQueueProcessor(OutboundMessageQueueProcessor processor) {
    _queueProcessor = processor;
  }

  Future<MessagingDatabase> open() async {
    if (_database != null) {
      return _database!;
    }
    _database = await _factory.openEncrypted();
    return _database!;
  }

  Future<void> closeAndWipe() async {
    _queueProcessor?.stop();
    final db = _database;
    _database = null;
    _queueProcessor = null;
    if (db != null) {
      await db.close();
    }
    await _factory.wipeLocalDatabase();
  }

  Future<void> close() async {
    _queueProcessor?.stop();
    final db = _database;
    _database = null;
    if (db != null) {
      await db.close();
    }
  }
}
