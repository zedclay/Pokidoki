import 'package:drift/drift.dart';

class LocalConversations extends Table {
  TextColumn get conversationId => text()();
  TextColumn get otherParticipantId => text()();
  TextColumn get displayName => text()();
  TextColumn get username => text()();
  TextColumn get avatarInitials => text().withDefault(const Constant(''))();
  TextColumn get avatarUrl => text().nullable()();
  BoolColumn get isPeerVerified =>
      boolean().withDefault(const Constant(false))();
  TextColumn get lastMessageId => text().nullable()();
  TextColumn get lastMessageClientId => text().nullable()();
  TextColumn get lastMessageType => text().nullable()();
  TextColumn get lastMessagePreview => text().nullable()();
  DateTimeColumn get lastMessageAt => dateTime().nullable()();
  IntColumn get unreadCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get mutedUntil => dateTime().nullable()();
  IntColumn get disappearingSeconds => integer().nullable()();
  BoolColumn get canSend => boolean().withDefault(const Constant(true))();
  BoolColumn get isUnavailable =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get isOutgoingPreview =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {conversationId};
}
