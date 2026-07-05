class SocialProfileDto {
  SocialProfileDto({
    required this.userId,
    required this.username,
    required this.displayName,
    required this.publicId,
    required this.avatarInitials,
    this.avatarUrl,
  });

  factory SocialProfileDto.fromJson(Map<String, dynamic> json) {
    return SocialProfileDto(
      userId: json['userId'] as String,
      username: json['username'] as String,
      displayName: json['displayName'] as String,
      publicId: json['publicId'] as String,
      avatarInitials: json['avatarInitials'] as String,
      avatarUrl: json['avatarUrl'] as String?,
    );
  }

  final String userId;
  final String username;
  final String displayName;
  final String publicId;
  final String? avatarUrl;
  final String avatarInitials;
}

class MessagePreviewDto {
  MessagePreviewDto({
    required this.id,
    required this.type,
    required this.body,
    required this.senderId,
    required this.createdAt,
  });

  factory MessagePreviewDto.fromJson(Map<String, dynamic> json) {
    return MessagePreviewDto(
      id: json['id'] as String,
      type: json['type'] as String,
      body: json['body'] as String,
      senderId: json['senderId'] as String,
      createdAt: json['createdAt'] as String,
    );
  }

  final String id;
  final String type;
  final String body;
  final String senderId;
  final String createdAt;
}

class ConversationDto {
  ConversationDto({
    required this.id,
    required this.type,
    required this.otherParticipant,
    required this.disappearingSeconds,
    required this.mutedUntil,
    required this.isMuted,
    required this.canSend,
    required this.isUnavailable,
    required this.createdAt,
    required this.updatedAt,
    this.lastMessageAt,
    this.lastMessage,
    this.unreadCount = 0,
  });

  factory ConversationDto.fromJson(Map<String, dynamic> json) {
    return ConversationDto(
      id: json['id'] as String,
      type: json['type'] as String,
      otherParticipant: SocialProfileDto.fromJson(
        json['otherParticipant'] as Map<String, dynamic>,
      ),
      disappearingSeconds: json['disappearingSeconds'] as int?,
      mutedUntil: json['mutedUntil'] as String?,
      isMuted: json['isMuted'] as bool? ?? false,
      canSend: json['canSend'] as bool? ?? false,
      isUnavailable: json['isUnavailable'] as bool? ?? false,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      lastMessageAt: json['lastMessageAt'] as String?,
      lastMessage: json['lastMessage'] == null
          ? null
          : MessagePreviewDto.fromJson(
              json['lastMessage'] as Map<String, dynamic>,
            ),
      unreadCount: json['unreadCount'] as int? ?? 0,
    );
  }

  final String id;
  final String type;
  final SocialProfileDto otherParticipant;
  final int? disappearingSeconds;
  final String? mutedUntil;
  final bool isMuted;
  final bool canSend;
  final bool isUnavailable;
  final String createdAt;
  final String updatedAt;
  final String? lastMessageAt;
  final MessagePreviewDto? lastMessage;
  final int unreadCount;
}

class MessageDto {
  MessageDto({
    required this.id,
    required this.conversationId,
    required this.clientMessageId,
    required this.sender,
    required this.type,
    required this.body,
    required this.createdAt,
    this.expiresAt,
    this.deliveredAt,
    this.readAt,
    required this.senderStatus,
  });

  factory MessageDto.fromJson(Map<String, dynamic> json) {
    return MessageDto(
      id: json['id'] as String,
      conversationId: json['conversationId'] as String,
      clientMessageId: json['clientMessageId'] as String,
      sender: SocialProfileDto.fromJson(json['sender'] as Map<String, dynamic>),
      type: json['type'] as String,
      body: json['body'] as String,
      createdAt: json['createdAt'] as String,
      expiresAt: json['expiresAt'] as String?,
      deliveredAt: json['deliveredAt'] as String?,
      readAt: json['readAt'] as String?,
      senderStatus: json['senderStatus'] as String? ?? 'sent',
    );
  }

  final String id;
  final String conversationId;
  final String clientMessageId;
  final SocialProfileDto sender;
  final String type;
  final String body;
  final String createdAt;
  final String? expiresAt;
  final String? deliveredAt;
  final String? readAt;
  final String senderStatus;
}

class PaginatedConversationsDto {
  PaginatedConversationsDto({
    required this.items,
    this.nextCursor,
    required this.hasMore,
  });

  factory PaginatedConversationsDto.fromJson(Map<String, dynamic> json) {
    return PaginatedConversationsDto(
      items: (json['items'] as List<dynamic>)
          .map((e) => ConversationDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextCursor: json['nextCursor'] as String?,
      hasMore: json['hasMore'] as bool? ?? false,
    );
  }

  final List<ConversationDto> items;
  final String? nextCursor;
  final bool hasMore;
}

class PaginatedMessagesDto {
  PaginatedMessagesDto({
    required this.items,
    this.nextCursor,
    required this.hasMore,
  });

  factory PaginatedMessagesDto.fromJson(Map<String, dynamic> json) {
    return PaginatedMessagesDto(
      items: (json['items'] as List<dynamic>)
          .map((e) => MessageDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextCursor: json['nextCursor'] as String?,
      hasMore: json['hasMore'] as bool? ?? false,
    );
  }

  final List<MessageDto> items;
  final String? nextCursor;
  final bool hasMore;
}

class MuteResponseDto {
  MuteResponseDto({required this.mutedUntil, required this.isMuted});

  factory MuteResponseDto.fromJson(Map<String, dynamic> json) {
    return MuteResponseDto(
      mutedUntil: json['mutedUntil'] as String?,
      isMuted: json['isMuted'] as bool? ?? false,
    );
  }

  final String? mutedUntil;
  final bool isMuted;
}

class DisappearingResponseDto {
  DisappearingResponseDto({
    required this.disappearingSeconds,
    this.systemMessage,
  });

  factory DisappearingResponseDto.fromJson(Map<String, dynamic> json) {
    return DisappearingResponseDto(
      disappearingSeconds: json['disappearingSeconds'] as int?,
      systemMessage: json['systemMessage'] == null
          ? null
          : MessageDto.fromJson(json['systemMessage'] as Map<String, dynamic>),
    );
  }

  final int? disappearingSeconds;
  final MessageDto? systemMessage;
}
