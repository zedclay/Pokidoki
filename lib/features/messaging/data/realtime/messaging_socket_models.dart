enum MessagingSocketStatus {
  disconnected,
  connecting,
  connected,
  reconnecting,
  failed,
}

class SocketMessageCreatedEvent {
  const SocketMessageCreatedEvent({required this.rawMessage});

  final Map<String, dynamic> rawMessage;
}

class SocketMessageReceiptEvent {
  const SocketMessageReceiptEvent({
    required this.messageId,
    required this.conversationId,
    required this.at,
  });

  final String messageId;
  final String conversationId;
  final DateTime at;
}

class SocketConversationUpdatedEvent {
  const SocketConversationUpdatedEvent({required this.rawConversation});

  final Map<String, dynamic> rawConversation;
}

class SocketTypingEvent {
  const SocketTypingEvent({required this.conversationId, required this.userId});

  final String conversationId;
  final String userId;
}

class SocketSendAck {
  const SocketSendAck({required this.ok, this.code, this.rawMessage});

  factory SocketSendAck.fromJson(Map<String, dynamic> json) {
    return SocketSendAck(
      ok: json['ok'] as bool? ?? false,
      code: json['code'] as String?,
      rawMessage: json['message'] as Map<String, dynamic>?,
    );
  }

  final bool ok;
  final String? code;
  final Map<String, dynamic>? rawMessage;
}
