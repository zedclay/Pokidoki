import 'package:drift/drift.dart';

import '../database/messaging_database.dart';
import '../tables/local_conversations.dart';

part 'conversations_dao.g.dart';

@DriftAccessor(tables: [LocalConversations])
class ConversationsDao extends DatabaseAccessor<MessagingDatabase>
    with _$ConversationsDaoMixin {
  ConversationsDao(super.db);

  Stream<List<LocalConversation>> watchConversationsOrdered() {
    return (select(localConversations)..orderBy([
          (t) => OrderingTerm(
            expression: t.lastMessageAt,
            mode: OrderingMode.desc,
            nulls: NullsOrder.last,
          ),
          (t) => OrderingTerm.desc(t.updatedAt),
        ]))
        .watch();
  }

  Future<List<LocalConversation>> getAllOrdered() {
    return (select(localConversations)..orderBy([
          (t) => OrderingTerm(
            expression: t.lastMessageAt,
            mode: OrderingMode.desc,
            nulls: NullsOrder.last,
          ),
          (t) => OrderingTerm.desc(t.updatedAt),
        ]))
        .get();
  }

  Future<LocalConversation?> getById(String conversationId) {
    return (select(
      localConversations,
    )..where((t) => t.conversationId.equals(conversationId))).getSingleOrNull();
  }

  Future<void> upsert(LocalConversationsCompanion companion) async {
    if (!companion.conversationId.present) {
      await into(localConversations).insertOnConflictUpdate(companion);
      return;
    }

    final conversationId = companion.conversationId.value;
    final existing = await getById(conversationId);
    if (existing == null) {
      final insertCompanion = companion.createdAt.present
          ? companion
          : companion.copyWith(
              createdAt: Value(
                companion.updatedAt.present
                    ? companion.updatedAt.value
                    : DateTime.now().toUtc(),
              ),
            );
      await into(localConversations).insert(insertCompanion);
      return;
    }

    await (update(localConversations)
          ..where((t) => t.conversationId.equals(conversationId)))
        .write(companion.copyWith(createdAt: const Value.absent()));
  }

  Future<void> upsertAll(List<LocalConversationsCompanion> companions) async {
    for (final companion in companions) {
      await upsert(companion);
    }
  }

  Future<void> updatePreview({
    required String conversationId,
    required String preview,
    required DateTime at,
    required bool isOutgoing,
    String? lastMessageId,
    String? lastMessageClientId,
    String? lastMessageType,
  }) {
    return (update(
      localConversations,
    )..where((t) => t.conversationId.equals(conversationId))).write(
      LocalConversationsCompanion(
        lastMessagePreview: Value(preview),
        lastMessageAt: Value(at),
        lastMessageId: Value(lastMessageId),
        lastMessageClientId: Value(lastMessageClientId),
        lastMessageType: Value(lastMessageType),
        isOutgoingPreview: Value(isOutgoing),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<void> updateUnreadCount(String conversationId, int unreadCount) {
    return (update(
      localConversations,
    )..where((t) => t.conversationId.equals(conversationId))).write(
      LocalConversationsCompanion(
        unreadCount: Value(unreadCount),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<void> updateMute(String conversationId, DateTime? mutedUntil) {
    return (update(
      localConversations,
    )..where((t) => t.conversationId.equals(conversationId))).write(
      LocalConversationsCompanion(
        mutedUntil: Value(mutedUntil),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<void> updateDisappearing(
    String conversationId,
    int? disappearingSeconds,
  ) {
    return (update(
      localConversations,
    )..where((t) => t.conversationId.equals(conversationId))).write(
      LocalConversationsCompanion(
        disappearingSeconds: Value(disappearingSeconds),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<void> updateSendCapability({
    required String conversationId,
    required bool canSend,
    required bool isUnavailable,
  }) {
    return (update(
      localConversations,
    )..where((t) => t.conversationId.equals(conversationId))).write(
      LocalConversationsCompanion(
        canSend: Value(canSend),
        isUnavailable: Value(isUnavailable),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<void> clearAll() => delete(localConversations).go();
}
