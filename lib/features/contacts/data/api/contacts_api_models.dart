class SocialProfileDto {
  const SocialProfileDto({
    required this.userId,
    required this.username,
    required this.displayName,
    required this.publicId,
    required this.avatarUrl,
    required this.avatarInitials,
  });

  factory SocialProfileDto.fromJson(Map<String, dynamic> json) {
    return SocialProfileDto(
      userId: json['userId'] as String,
      username: json['username'] as String,
      displayName: json['displayName'] as String,
      publicId: json['publicId'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      avatarInitials: json['avatarInitials'] as String? ?? '',
    );
  }

  final String userId;
  final String username;
  final String displayName;
  final String publicId;
  final String? avatarUrl;
  final String avatarInitials;
}

class ContactRequestDto extends SocialProfileDto {
  const ContactRequestDto({
    required super.userId,
    required super.username,
    required super.displayName,
    required super.publicId,
    required super.avatarUrl,
    required super.avatarInitials,
    required this.requestId,
    required this.direction,
    required this.createdAt,
  });

  factory ContactRequestDto.fromJson(Map<String, dynamic> json) {
    final profile = SocialProfileDto.fromJson(json);
    return ContactRequestDto(
      userId: profile.userId,
      username: profile.username,
      displayName: profile.displayName,
      publicId: profile.publicId,
      avatarUrl: profile.avatarUrl,
      avatarInitials: profile.avatarInitials,
      requestId: json['requestId'] as String,
      direction: json['direction'] as String,
      createdAt: json['createdAt'] as String,
    );
  }

  final String requestId;
  final String direction;
  final String createdAt;
}

class PaginatedContactsDto {
  const PaginatedContactsDto({
    required this.items,
    required this.page,
    required this.limit,
    required this.hasMore,
  });

  factory PaginatedContactsDto.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List<dynamic>? ?? const [])
        .cast<Map<String, dynamic>>();
    return PaginatedContactsDto(
      items: items.map((item) => ContactItemDto.fromJson(item)).toList(),
      page: json['page'] as int? ?? 1,
      limit: json['limit'] as int? ?? 50,
      hasMore: json['hasMore'] as bool? ?? false,
    );
  }

  final List<ContactItemDto> items;
  final int page;
  final int limit;
  final bool hasMore;
}

class ContactItemDto extends SocialProfileDto {
  const ContactItemDto({
    required super.userId,
    required super.username,
    required super.displayName,
    required super.publicId,
    required super.avatarUrl,
    required super.avatarInitials,
    required this.addedAt,
  });

  factory ContactItemDto.fromJson(Map<String, dynamic> json) {
    final profile = SocialProfileDto.fromJson(json);
    return ContactItemDto(
      userId: profile.userId,
      username: profile.username,
      displayName: profile.displayName,
      publicId: profile.publicId,
      avatarUrl: profile.avatarUrl,
      avatarInitials: profile.avatarInitials,
      addedAt: json['addedAt'] as String,
    );
  }

  final String addedAt;
}

class PaginatedContactRequestsDto {
  const PaginatedContactRequestsDto({
    required this.items,
    required this.page,
    required this.limit,
    required this.hasMore,
  });

  factory PaginatedContactRequestsDto.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List<dynamic>? ?? const [])
        .cast<Map<String, dynamic>>();
    return PaginatedContactRequestsDto(
      items: items.map(ContactRequestDto.fromJson).toList(),
      page: json['page'] as int? ?? 1,
      limit: json['limit'] as int? ?? 20,
      hasMore: json['hasMore'] as bool? ?? false,
    );
  }

  final List<ContactRequestDto> items;
  final int page;
  final int limit;
  final bool hasMore;
}

class PaginatedBlockedUsersDto {
  const PaginatedBlockedUsersDto({
    required this.items,
    required this.page,
    required this.limit,
    required this.hasMore,
  });

  factory PaginatedBlockedUsersDto.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List<dynamic>? ?? const [])
        .cast<Map<String, dynamic>>();
    return PaginatedBlockedUsersDto(
      items: items.map(BlockedUserItemDto.fromJson).toList(),
      page: json['page'] as int? ?? 1,
      limit: json['limit'] as int? ?? 50,
      hasMore: json['hasMore'] as bool? ?? false,
    );
  }

  final List<BlockedUserItemDto> items;
  final int page;
  final int limit;
  final bool hasMore;
}

class BlockedUserItemDto extends SocialProfileDto {
  const BlockedUserItemDto({
    required super.userId,
    required super.username,
    required super.displayName,
    required super.publicId,
    required super.avatarUrl,
    required super.avatarInitials,
    required this.blockedAt,
  });

  factory BlockedUserItemDto.fromJson(Map<String, dynamic> json) {
    final profile = SocialProfileDto.fromJson(json);
    return BlockedUserItemDto(
      userId: profile.userId,
      username: profile.username,
      displayName: profile.displayName,
      publicId: profile.publicId,
      avatarUrl: profile.avatarUrl,
      avatarInitials: profile.avatarInitials,
      blockedAt: json['blockedAt'] as String,
    );
  }

  final String blockedAt;
}

class RelationshipDto {
  const RelationshipDto({
    required this.isContact,
    required this.incomingRequestId,
    required this.outgoingRequestId,
    required this.blockedByMe,
    required this.canSendRequest,
  });

  factory RelationshipDto.fromJson(Map<String, dynamic> json) {
    final relationship = json['relationship'] as Map<String, dynamic>? ?? json;
    return RelationshipDto(
      isContact: relationship['isContact'] as bool? ?? false,
      incomingRequestId: relationship['incomingRequestId'] as String?,
      outgoingRequestId: relationship['outgoingRequestId'] as String?,
      blockedByMe: relationship['blockedByMe'] as bool? ?? false,
      canSendRequest: relationship['canSendRequest'] as bool? ?? false,
    );
  }

  final bool isContact;
  final String? incomingRequestId;
  final String? outgoingRequestId;
  final bool blockedByMe;
  final bool canSendRequest;
}

class PublicProfileDto {
  const PublicProfileDto({
    required this.userId,
    required this.username,
    required this.displayName,
    required this.publicId,
    required this.bio,
    required this.avatarUrl,
    required this.avatarInitials,
  });

  factory PublicProfileDto.fromJson(Map<String, dynamic> json) {
    final profile = json['profile'] as Map<String, dynamic>? ?? json;
    return PublicProfileDto(
      userId: profile['userId'] as String,
      username: profile['username'] as String,
      displayName: profile['displayName'] as String,
      publicId: profile['publicId'] as String,
      bio: profile['bio'] as String?,
      avatarUrl: profile['avatarUrl'] as String?,
      avatarInitials: profile['avatarInitials'] as String? ?? '',
    );
  }

  final String userId;
  final String username;
  final String displayName;
  final String publicId;
  final String? bio;
  final String? avatarUrl;
  final String avatarInitials;
}

class UserSearchPageDto {
  const UserSearchPageDto({required this.items});

  factory UserSearchPageDto.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List<dynamic>? ?? const [])
        .cast<Map<String, dynamic>>();
    return UserSearchPageDto(
      items: items.map(PublicProfileDto.fromJson).toList(),
    );
  }

  final List<PublicProfileDto> items;
}
