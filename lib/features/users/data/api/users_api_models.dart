class ProfileDto {
  const ProfileDto({
    required this.userId,
    required this.username,
    required this.displayName,
    required this.publicId,
    required this.avatarInitials,
    required this.isDiscoverable,
    required this.createdAt,
    required this.updatedAt,
    this.bio,
    this.avatarUrl,
  });

  factory ProfileDto.fromJson(Map<String, dynamic> json) {
    return ProfileDto(
      userId: json['userId'] as String,
      username: json['username'] as String,
      displayName: json['displayName'] as String,
      bio: json['bio'] as String?,
      publicId: json['publicId'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      avatarInitials: json['avatarInitials'] as String,
      isDiscoverable: json['isDiscoverable'] as bool? ?? true,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }

  final String userId;
  final String username;
  final String displayName;
  final String? bio;
  final String publicId;
  final String? avatarUrl;
  final String avatarInitials;
  final bool isDiscoverable;
  final String createdAt;
  final String updatedAt;
}

class UsernameAvailabilityDto {
  const UsernameAvailabilityDto({
    required this.username,
    required this.available,
  });

  factory UsernameAvailabilityDto.fromJson(Map<String, dynamic> json) {
    return UsernameAvailabilityDto(
      username: json['username'] as String,
      available: json['available'] as bool,
    );
  }

  final String username;
  final bool available;
}

class SearchUserItemDto {
  const SearchUserItemDto({
    required this.userId,
    required this.username,
    required this.displayName,
    required this.publicId,
    required this.avatarInitials,
    this.avatarUrl,
  });

  factory SearchUserItemDto.fromJson(Map<String, dynamic> json) {
    return SearchUserItemDto(
      userId: json['userId'] as String,
      username: json['username'] as String,
      displayName: json['displayName'] as String,
      publicId: json['publicId'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      avatarInitials: json['avatarInitials'] as String,
    );
  }

  final String userId;
  final String username;
  final String displayName;
  final String publicId;
  final String? avatarUrl;
  final String avatarInitials;
}

class SearchUsersResponseDto {
  const SearchUsersResponseDto({
    required this.items,
    required this.page,
    required this.limit,
    required this.total,
    required this.hasMore,
  });

  factory SearchUsersResponseDto.fromJson(Map<String, dynamic> json) {
    final itemsJson = json['items'] as List<dynamic>? ?? const [];
    return SearchUsersResponseDto(
      items: itemsJson
          .map(
            (item) => SearchUserItemDto.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      page: json['page'] as int? ?? 1,
      limit: json['limit'] as int? ?? 20,
      total: json['total'] as int? ?? 0,
      hasMore: json['hasMore'] as bool? ?? false,
    );
  }

  final List<SearchUserItemDto> items;
  final int page;
  final int limit;
  final int total;
  final bool hasMore;
}

class ProfilePreviewDto {
  const ProfilePreviewDto({
    required this.userId,
    required this.username,
    required this.displayName,
    required this.publicId,
    required this.avatarInitials,
    this.bio,
    this.avatarUrl,
  });

  factory ProfilePreviewDto.fromJson(Map<String, dynamic> json) {
    return ProfilePreviewDto(
      userId: json['userId'] as String,
      username: json['username'] as String,
      displayName: json['displayName'] as String,
      bio: json['bio'] as String?,
      publicId: json['publicId'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      avatarInitials: json['avatarInitials'] as String,
    );
  }

  final String userId;
  final String username;
  final String displayName;
  final String? bio;
  final String publicId;
  final String? avatarUrl;
  final String avatarInitials;
}

class ProfileResponseDto {
  const ProfileResponseDto({required this.profile});

  factory ProfileResponseDto.fromJson(Map<String, dynamic> json) {
    return ProfileResponseDto(
      profile: ProfileDto.fromJson(json['profile'] as Map<String, dynamic>),
    );
  }

  final ProfileDto profile;
}

class ProfilePreviewResponseDto {
  const ProfilePreviewResponseDto({required this.profile});

  factory ProfilePreviewResponseDto.fromJson(Map<String, dynamic> json) {
    return ProfilePreviewResponseDto(
      profile: ProfilePreviewDto.fromJson(
        json['profile'] as Map<String, dynamic>,
      ),
    );
  }

  final ProfilePreviewDto profile;
}
