import 'package:drift/drift.dart';

import '../../../domain/local_message_status.dart';
import '../database/messaging_database.dart';
import '../tables/local_messages.dart';

part 'messages_dao.g.dart';

@DriftAccessor(tables: [LocalMessages])
class MessagesDao extends DatabaseAccessor<MessagingDatabase>
    with _$MessagesDaoMixin {
  MessagesDao(super.db);

  Stream<List<LocalMessage>> watchConversationMessages(String conversationId) {
    final now = DateTime.now().toUtc();
    return (select(localMessages)
          ..where(
            (t) =>
                t.conversationId.equals(conversationId) &
                (t.expiresAt.isNull() | t.expiresAt.isBiggerThanValue(now)),
          )
          ..orderBy([
            (t) => OrderingTerm(
              expression: coalesce([t.serverCreatedAt, t.localCreatedAt]),
            ),
            (t) => OrderingTerm(expression: t.id),
          ]))
        .watch();
  }

  Future<List<LocalMessage>> getConversationMessages(
    String conversationId, {
    int? limit,
  }) {
    final now = DateTime.now().toUtc();
    final query = select(localMessages)
      ..where(
        (t) =>
            t.conversationId.equals(conversationId) &
            (t.expiresAt.isNull() | t.expiresAt.isBiggerThanValue(now)),
      )
      ..orderBy([
        (t) => OrderingTerm(
          expression: coalesce([t.serverCreatedAt, t.localCreatedAt]),
        ),
        (t) => OrderingTerm(expression: t.id),
      ]);
    if (limit != null) {
      query.limit(limit);
    }
    return query.get();
  }

  Future<LocalMessage?> getByServerId(String serverMessageId) {
    return (select(localMessages)
          ..where((t) => t.serverMessageId.equals(serverMessageId)))
        .getSingleOrNull();
  }

  Future<LocalMessage?> getByClientId(String clientMessageId) {
    return (select(localMessages)
          ..where((t) => t.clientMessageId.equals(clientMessageId)))
        .getSingleOrNull();
  }

  Future<int> insertMessage(LocalMessagesCompanion companion) {
    return into(localMessages).insert(companion);
  }

  Future<void> upsertPendingMessage(LocalMessagesCompanion companion) {
    return into(localMessages).insert(
      companion,
      onConflict: DoUpdate(
        (old) => companion,
        target: [localMessages.clientMessageId],
      ),
    );
  }

  Future<void> upsertRemoteMessage(LocalMessagesCompanion companion) {
    return into(localMessages).insertOnConflictUpdate(companion);
  }

  Future<void> reconcileByClientId({
    required String clientMessageId,
    required LocalMessagesCompanion serverFields,
  }) async {
    final existing = await getByClientId(clientMessageId);
    if (existing == null) {
      await into(localMessages).insert(serverFields);
      return;
    }
    final mergedStatus = MessageStatusRank.max(
      MessageStatusRank.fromStorage(existing.deliveryStatus),
      MessageStatusRank.fromStorage(serverFields.deliveryStatus.value),
    );
    await (update(
      localMessages,
    )..where((t) => t.clientMessageId.equals(clientMessageId))).write(
      serverFields.copyWith(
        deliveryStatus: Value(mergedStatus.name),
        id: const Value.absent(),
      ),
    );
  }

  Future<void> updateDeliveryStatus({
    required String serverMessageId,
    required LocalMessageStatus status,
  }) async {
    final existing = await getByServerId(serverMessageId);
    if (existing == null) {
      return;
    }
    final merged = MessageStatusRank.max(
      MessageStatusRank.fromStorage(existing.deliveryStatus),
      status,
    );
    await (update(
      localMessages,
    )..where((t) => t.serverMessageId.equals(serverMessageId))).write(
      LocalMessagesCompanion(
        deliveryStatus: Value(merged.name),
        lastUpdatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<void> updateByClientId({
    required String clientMessageId,
    required LocalMessagesCompanion fields,
  }) {
    return (update(
      localMessages,
    )..where((t) => t.clientMessageId.equals(clientMessageId))).write(fields);
  }

  Future<int> deleteExpiredMessages({DateTime? before}) {
    final cutoff = before ?? DateTime.now().toUtc();
    return (delete(localMessages)..where(
          (t) =>
              t.expiresAt.isNotNull() &
              t.expiresAt.isSmallerOrEqualValue(cutoff),
        ))
        .go();
  }

  Future<void> clearConversation(String conversationId) {
    return (delete(
      localMessages,
    )..where((t) => t.conversationId.equals(conversationId))).go();
  }

  Future<void> clearAll() => delete(localMessages).go();

  Future<void> deleteByServerId(String serverMessageId) {
    return (delete(
      localMessages,
    )..where((t) => t.serverMessageId.equals(serverMessageId))).go();
  }

  Future<void> markClientMessageFailed({
    required String clientMessageId,
    required String errorCode,
  }) {
    return updateByClientId(
      clientMessageId: clientMessageId,
      fields: LocalMessagesCompanion(
        deliveryStatus: Value(LocalMessageStatus.failedPermanent.name),
        syncState: Value(LocalSyncState.localOnly.name),
        errorCode: Value(errorCode),
        lastUpdatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }
}
