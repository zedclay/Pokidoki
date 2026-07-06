/// Message delivery presentation state.
enum MessageDeliveryStatus {
  queued,
  retrying,
  sending,
  sent,
  delivered,
  read,
  failed,
}

/// Message content type for UI presentation.
enum MessageContentType { text, image, file, link, system }

/// Immutable chat message model for UI development.
class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.conversationId,
    required this.body,
    required this.sentAt,
    required this.isOutgoing,
    this.senderId = '',
    this.type = MessageContentType.text,
    this.deliveryStatus = MessageDeliveryStatus.sent,
    this.isEdited = false,
    this.replyToMessageId,
    this.replyPreview,
    this.attachmentName,
    this.attachmentSizeBytes,
    this.clientMessageId,
    this.expiresAt,
  });

  final String id;
  final String conversationId;
  final String senderId;
  final String body;
  final DateTime sentAt;
  final bool isOutgoing;
  final MessageContentType type;
  final MessageDeliveryStatus deliveryStatus;
  final bool isEdited;
  final String? replyToMessageId;
  final String? replyPreview;
  final String? attachmentName;
  final int? attachmentSizeBytes;
  final String? clientMessageId;
  final DateTime? expiresAt;

  ChatMessage copyWith({
    MessageDeliveryStatus? deliveryStatus,
    String? body,
    String? id,
    DateTime? expiresAt,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      conversationId: conversationId,
      clientMessageId: clientMessageId,
      senderId: senderId,
      body: body ?? this.body,
      sentAt: sentAt,
      isOutgoing: isOutgoing,
      type: type,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
      isEdited: isEdited,
      replyToMessageId: replyToMessageId,
      replyPreview: replyPreview,
      attachmentName: attachmentName,
      attachmentSizeBytes: attachmentSizeBytes,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}
