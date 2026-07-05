import 'dart:async';

import 'package:drift/drift.dart';

import '../../../../data/models/conversation.dart';
import '../../../../data/models/conversation_page.dart';
import '../../../../data/models/message.dart';
import '../../../../data/models/message_page.dart';
import '../../../../data/models/message_search_page.dart';
import '../../../../data/models/shared_media_item.dart';
import '../../../../data/repositories/conversations_repository.dart';
import '../../domain/disappearing_duration_mapper.dart';
import '../../domain/local_message_status.dart';
import '../api/api_conversations_repository.dart';
import '../local/database/messaging_database.dart';
import '../local/mappers/local_conversation_mapper.dart';
import '../local/mappers/local_message_mapper.dart';
import '../sync/messaging_sync_engine.dart';
import '../sync/outbound_message_queue_processor.dart';

class OfflineFirstConversationsRepository implements ConversationsRepository {
  OfflineFirstConversationsRepository({
    required MessagingDatabase database,
    required ApiConversationsRepository remote,
    required MessagingSyncEngine syncEngine,
    required OutboundMessageQueueProcessor queueProcessor,
    required String? Function() currentUserId,
  }) : _db = database,
       _remote = remote,
       _sync = syncEngine,
       _queue = queueProcessor,
       _currentUserId = currentUserId;

  final MessagingDatabase _db;
  final ApiConversationsRepository _remote;
  final MessagingSyncEngine _sync;
  final OutboundMessageQueueProcessor _queue;
  final String? Function() _currentUserId;

  String? _messagesCursor;

  Stream<List<Conversation>> watchConversations() {
    return _db.conversationsDao.watchConversationsOrdered().map(
      (rows) => rows.map((row) => row.toDomain()).toList(),
    );
  }

  Stream<List<ChatMessage>> watchMessages(String conversationId) {
    final userId = _currentUserId();
    return _db.messagesDao
        .watchConversationMessages(conversationId)
        .map(
          (rows) =>
              rows.map((row) => row.toDomain(currentUserId: userId)).toList(),
        );
  }

  MessagingSyncEngine get syncEngine => _sync;

  OutboundMessageQueueProcessor get queueProcessor => _queue;

  @override
  Future<Conversation> createOrGetConversation(String userId) async {
    final conversation = await _remote.createOrGetConversation(userId);
    await _db.conversationsDao.upsert(
      conversationToUpsertCompanion(conversation),
    );
    return conversation;
  }

  @override
  Future<ConversationPage> getConversations({
    String? cursor,
    int limit = 20,
  }) async {
    await _sync.refreshConversations(cursor: cursor);
    final rows = await _db.conversationsDao.getAllOrdered();
    return ConversationPage(
      items: rows.map((row) => row.toDomain()).toList(),
      nextCursor: null,
      hasMore: false,
    );
  }

  @override
  Future<Conversation> getConversation(String conversationId) async {
    await _sync.syncConversation(conversationId);
    final row = await _db.conversationsDao.getById(conversationId);
    if (row != null) {
      return row.toDomain();
    }
    return _remote.getConversation(conversationId);
  }

  @override
  Future<MessagePage> getMessages({
    required String conversationId,
    String? before,
    int limit = 50,
  }) async {
    if (before == null) {
      _messagesCursor = null;
    }
    await _sync.syncMessages(conversationId: conversationId, before: before);
    final rows = await _db.messagesDao.getConversationMessages(conversationId);
    return MessagePage(
      items: rows
          .map((row) => row.toDomain(currentUserId: _currentUserId()))
          .toList(),
      nextCursor: _messagesCursor,
      hasMore: false,
    );
  }

  @override
  Future<ChatMessage> sendMessage({
    required String conversationId,
    required String clientMessageId,
    required String text,
  }) async {
    final userId = _currentUserId() ?? '';
    final now = DateTime.now().toUtc();
    final conversation = await _db.conversationsDao.getById(conversationId);
    final expiresAt = DisappearingDurationMapper.expiresAtForSend(
      conversation == null
          ? null
          : DisappearingDurationMapper.secondsToHours(
              conversation.disappearingSeconds,
            ),
      now,
    );

    await _db.transaction(() async {
      await _db.messagesDao.insertMessage(
        messageToInsertCompanion(
          clientMessageId: clientMessageId,
          conversationId: conversationId,
          senderId: userId,
          text: text,
          status: LocalMessageStatus.queued,
          syncState: LocalSyncState.pendingAck,
          expiresAt: expiresAt,
        ),
      );
      await _db.outboundQueueDao.enqueue(
        OutboundMessageQueueCompanion.insert(
          conversationId: conversationId,
          clientMessageId: clientMessageId,
          textPayload: text,
          queueState: QueueState.pending.name,
          nextAttemptAt: now,
          createdAt: now,
          updatedAt: now,
        ),
      );
      await _db.conversationsDao.updatePreview(
        conversationId: conversationId,
        preview: text,
        at: now,
        isOutgoing: true,
        lastMessageClientId: clientMessageId,
      );
    });

    unawaited(_queue.requestDrain());

    return ChatMessage(
      id: 'local-$clientMessageId',
      conversationId: conversationId,
      clientMessageId: clientMessageId,
      senderId: userId,
      body: text,
      sentAt: now,
      isOutgoing: true,
      deliveryStatus: MessageDeliveryStatus.sending,
      expiresAt: expiresAt,
    );
  }

  Future<void> retrySend({
    required String conversationId,
    required String clientMessageId,
  }) async {
    final now = DateTime.now().toUtc();
    await _db.outboundQueueDao.enqueue(
      OutboundMessageQueueCompanion.insert(
        conversationId: conversationId,
        clientMessageId: clientMessageId,
        textPayload:
            (await _db.messagesDao.getByClientId(clientMessageId))?.body ?? '',
        queueState: QueueState.pending.name,
        nextAttemptAt: now,
        createdAt: now,
        updatedAt: now,
      ),
    );
    await _db.messagesDao.updateByClientId(
      clientMessageId: clientMessageId,
      fields: LocalMessagesCompanion(
        deliveryStatus: Value(LocalMessageStatus.queued.name),
        errorCode: const Value(null),
        lastUpdatedAt: Value(now),
      ),
    );
    unawaited(_queue.requestDrain());
  }

  @override
  Future<void> markDelivered(String messageId) {
    return _remote.markDelivered(messageId);
  }

  @override
  Future<void> markConversationRead({
    required String conversationId,
    required String throughMessageId,
  }) {
    return _remote.markConversationRead(
      conversationId: conversationId,
      throughMessageId: throughMessageId,
    );
  }

  @override
  Future<Conversation> updateMute({
    required String conversationId,
    DateTime? mutedUntil,
  }) async {
    final updated = await _remote.updateMute(
      conversationId: conversationId,
      mutedUntil: mutedUntil,
    );
    await _db.conversationsDao.updateMute(conversationId, mutedUntil);
    return updated;
  }

  @override
  Future<Conversation> updateDisappearingMessages({
    required String conversationId,
    required int durationSeconds,
  }) async {
    final updated = await _remote.updateDisappearingMessages(
      conversationId: conversationId,
      durationSeconds: durationSeconds,
    );
    await _db.conversationsDao.updateDisappearing(
      conversationId,
      durationSeconds == 0 ? null : durationSeconds,
    );
    return updated;
  }

  @override
  Future<MessageSearchPage> searchMessages({
    required String conversationId,
    required String query,
    String? cursor,
    int limit = 20,
  }) {
    return _remote.searchMessages(
      conversationId: conversationId,
      query: query,
      cursor: cursor,
      limit: limit,
    );
  }

  @override
  Future<List<SharedMediaItem>> getSharedMedia(String conversationId) {
    return _remote.getSharedMedia(conversationId);
  }
}
