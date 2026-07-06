import 'package:drift/drift.dart';

import '../../../../data/models/message.dart';
import '../../domain/local_message_status.dart';
import '../api/api_conversations_repository.dart';
import '../api/messaging_api_mapper.dart';
import '../api/messaging_api_models.dart';
import '../local/database/messaging_database.dart';
import '../local/mappers/local_conversation_mapper.dart';

/// Persists remote REST and Socket.IO messaging data into Drift.
class MessagingSyncEngine {
  MessagingSyncEngine({
    required MessagingDatabase database,
    required ApiConversationsRepository remote,
    required String? Function() currentUserId,
  }) : _db = database,
       _remote = remote,
       _currentUserId = currentUserId;

  final MessagingDatabase _db;
  final ApiConversationsRepository _remote;
  final String? Function() _currentUserId;

  Future<void> refreshConversations({String? cursor}) async {
    final page = await _remote.getConversations(cursor: cursor);
    for (final conversation in page.items) {
      try {
        await _db.conversationsDao.upsert(
          conversationToUpsertCompanion(conversation),
        );
      } on Object {
        // Keep syncing remaining conversations when one row fails validation.
      }
    }
  }

  Future<void> syncConversation(String conversationId) async {
    final conversation = await _remote.getConversation(conversationId);
    await _db.conversationsDao.upsert(
      conversationToUpsertCompanion(conversation),
    );
  }

  Future<void> syncMessages({
    required String conversationId,
    String? before,
  }) async {
    final page = await _remote.getMessages(
      conversationId: conversationId,
      before: before,
    );
    final userId = _currentUserId();
    for (final message in page.items) {
      await _upsertRemoteMessage(message, userId: userId);
    }
  }

  Future<void> handleMessageCreated(Map<String, dynamic> rawMessage) async {
    final dto = MessageDto.fromJson(rawMessage);
    final message = mapMessageDto(dto, currentUserId: _currentUserId());
    await _upsertRemoteMessage(message, userId: _currentUserId());
    await _db.conversationsDao.updatePreview(
      conversationId: message.conversationId,
      preview: message.body,
      at: message.sentAt,
      isOutgoing: message.isOutgoing,
      lastMessageId: message.id.startsWith('local-') ? null : message.id,
      lastMessageClientId: message.clientMessageId,
      lastMessageType: message.type.name.toUpperCase(),
    );
  }

  Future<void> handleMessageDelivered({required String messageId}) async {
    await _db.messagesDao.updateDeliveryStatus(
      serverMessageId: messageId,
      status: LocalMessageStatus.delivered,
    );
  }

  Future<void> handleMessageRead({required String messageId}) async {
    await _db.messagesDao.updateDeliveryStatus(
      serverMessageId: messageId,
      status: LocalMessageStatus.read,
    );
  }

  Future<void> handleMessageDeleted({required String messageId}) async {
    await _db.messagesDao.deleteByServerId(messageId);
  }

  Future<void> handleConversationUpdated(Map<String, dynamic> raw) async {
    final dto = ConversationDto.fromJson(raw);
    final conversation = mapConversationDto(
      dto,
      currentUserId: _currentUserId(),
    );
    await _db.conversationsDao.upsert(
      conversationToUpsertCompanion(conversation),
    );
  }

  Future<void> handleConversationSettingsUpdated({
    required String conversationId,
    required int? disappearingSeconds,
    Map<String, dynamic>? rawSystemMessage,
  }) async {
    await _db.conversationsDao.updateDisappearing(
      conversationId,
      disappearingSeconds,
    );
    if (rawSystemMessage != null) {
      await handleMessageCreated(rawSystemMessage);
    }
  }

  Future<void> purgeExpiredMessages() async {
    await _db.messagesDao.deleteExpiredMessages();
  }

  Future<void> upsertRemoteChatMessage(ChatMessage message) {
    return _upsertRemoteMessage(message, userId: _currentUserId());
  }

  LocalMessageStatus _mapUiStatus(MessageDeliveryStatus status) {
    return switch (status) {
      MessageDeliveryStatus.queued => LocalMessageStatus.queued,
      MessageDeliveryStatus.sending => LocalMessageStatus.sending,
      MessageDeliveryStatus.sent => LocalMessageStatus.sent,
      MessageDeliveryStatus.delivered => LocalMessageStatus.delivered,
      MessageDeliveryStatus.read => LocalMessageStatus.read,
      MessageDeliveryStatus.failed => LocalMessageStatus.failedPermanent,
    };
  }

  Future<void> _upsertRemoteMessage(
    ChatMessage message, {
    required String? userId,
  }) async {
    final status = message.isOutgoing
        ? _mapUiStatus(message.deliveryStatus)
        : LocalMessageStatus.sent;
    await _db.messagesDao.reconcileByClientId(
      clientMessageId: message.clientMessageId ?? message.id,
      serverFields: LocalMessagesCompanion(
        serverMessageId: Value(
          message.id.startsWith('local-') ? null : message.id,
        ),
        clientMessageId: Value(message.clientMessageId ?? message.id),
        conversationId: Value(message.conversationId),
        senderId: Value(
          message.senderId.isEmpty ? (userId ?? '') : message.senderId,
        ),
        messageType: Value(message.type.name.toUpperCase()),
        body: Value(message.body),
        localCreatedAt: Value(message.sentAt),
        serverCreatedAt: Value(message.sentAt),
        expiresAt: Value(message.expiresAt),
        deliveryStatus: Value(status.name),
        syncState: Value(LocalSyncState.synced.name),
        replyToMessageId: Value(message.replyToMessageId),
        replyPreview: Value(message.replyPreview),
        lastUpdatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }
}
