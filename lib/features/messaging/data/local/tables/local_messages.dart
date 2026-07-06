import 'package:drift/drift.dart';

class LocalMessages extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get serverMessageId => text().nullable()();
  TextColumn get clientMessageId => text()();
  TextColumn get conversationId => text()();
  TextColumn get senderId => text()();
  TextColumn get messageType => text().withDefault(const Constant('TEXT'))();
  TextColumn get body => text()();
  DateTimeColumn get localCreatedAt => dateTime()();
  DateTimeColumn get serverCreatedAt => dateTime().nullable()();
  DateTimeColumn get expiresAt => dateTime().nullable()();
  TextColumn get deliveryStatus => text()();
  TextColumn get syncState => text()();
  TextColumn get errorCode => text().nullable()();
  TextColumn get replyToMessageId => text().nullable()();
  TextColumn get replyPreview => text().nullable()();
  DateTimeColumn get lastUpdatedAt => dateTime()();
}
