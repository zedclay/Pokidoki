import 'package:drift/drift.dart';

class OutboundMessageQueue extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get operationType =>
      text().withDefault(const Constant('sendTextMessage'))();
  TextColumn get conversationId => text()();
  TextColumn get clientMessageId => text()();
  TextColumn get textPayload => text()();
  TextColumn get queueState => text()();
  IntColumn get attemptCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get nextAttemptAt => dateTime()();
  DateTimeColumn get lastAttemptAt => dateTime().nullable()();
  DateTimeColumn get inFlightSince => dateTime().nullable()();
  TextColumn get errorCode => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
