import '../../../../data/models/conversation.dart';
import '../../../../data/models/conversation_page.dart';
import '../../../../data/models/message.dart';
import '../../../../data/models/message_page.dart';
import '../../../../data/models/message_search_page.dart';
import '../../domain/disappearing_duration_mapper.dart';
import 'messaging_api_models.dart';

Conversation mapConversationDto(
  ConversationDto dto, {
  required String? currentUserId,
}) {
  final peer = dto.otherParticipant;
  final hours = DisappearingDurationMapper.secondsToHours(
    dto.disappearingSeconds,
  );
  final preview = dto.lastMessage;
  final isOutgoingPreview =
      preview != null &&
      currentUserId != null &&
      preview.senderId == currentUserId;

  return Conversation(
    id: dto.id,
    peerId: peer.userId,
    peerDisplayName: peer.displayName,
    peerUsername: peer.username,
    updatedAt: DateTime.parse(dto.lastMessageAt ?? dto.updatedAt),
    lastMessagePreview: preview?.body,
    unreadCount: dto.unreadCount,
    isMuted: dto.isMuted,
    isBlocked: !dto.canSend,
    isOutgoingPreview: isOutgoingPreview,
    disappearingDurationHours: hours,
    disappearingMessagesEnabled: hours != null,
  );
}

ConversationPage mapConversationPage(
  PaginatedConversationsDto dto, {
  required String? currentUserId,
}) {
  return ConversationPage(
    items: dto.items
        .map((item) => mapConversationDto(item, currentUserId: currentUserId))
        .toList(),
    nextCursor: dto.nextCursor,
    hasMore: dto.hasMore,
  );
}

MessageContentType mapMessageType(String type) {
  return switch (type) {
    'SYSTEM' => MessageContentType.system,
    'TEXT' => MessageContentType.text,
    _ => MessageContentType.text,
  };
}

MessageDeliveryStatus mapSenderStatus(String status) {
  return switch (status) {
    'read' => MessageDeliveryStatus.read,
    'delivered' => MessageDeliveryStatus.delivered,
    'sent' => MessageDeliveryStatus.sent,
    _ => MessageDeliveryStatus.sent,
  };
}

ChatMessage mapMessageDto(MessageDto dto, {required String? currentUserId}) {
  final isOutgoing =
      currentUserId != null && dto.sender.userId == currentUserId;

  return ChatMessage(
    id: dto.id,
    conversationId: dto.conversationId,
    clientMessageId: dto.clientMessageId,
    senderId: dto.sender.userId,
    body: dto.body,
    sentAt: DateTime.parse(dto.createdAt),
    isOutgoing: isOutgoing,
    type: mapMessageType(dto.type),
    deliveryStatus: isOutgoing
        ? mapSenderStatus(dto.senderStatus)
        : MessageDeliveryStatus.sent,
  );
}

MessagePage mapMessagePage(
  PaginatedMessagesDto dto, {
  required String? currentUserId,
}) {
  final items = dto.items
      .map((m) => mapMessageDto(m, currentUserId: currentUserId))
      .toList();
  return MessagePage(
    items: items.reversed.toList(),
    nextCursor: dto.nextCursor,
    hasMore: dto.hasMore,
  );
}

MessageSearchPage mapMessageSearchPage(
  PaginatedMessagesDto dto, {
  required String? currentUserId,
}) {
  return MessageSearchPage(
    items: dto.items
        .map((m) => mapMessageDto(m, currentUserId: currentUserId))
        .toList(),
    nextCursor: dto.nextCursor,
    hasMore: dto.hasMore,
  );
}

Conversation applyMuteToConversation(
  Conversation conversation,
  MuteResponseDto dto,
) {
  return conversation.copyWith(isMuted: dto.isMuted);
}

Conversation applyDisappearingToConversation(
  Conversation conversation,
  DisappearingResponseDto dto,
) {
  final hours = DisappearingDurationMapper.secondsToHours(
    dto.disappearingSeconds,
  );
  return conversation.copyWith(
    disappearingDurationHours: hours,
    disappearingMessagesEnabled: hours != null,
    clearDisappearing: hours == null,
  );
}
