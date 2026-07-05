import '../../../../data/models/user_profile.dart';
import '../../../../data/models/user_profile_preview.dart';
import '../../../../data/models/user_search_result.dart';
import '../../domain/user_search_page.dart';
import '../../domain/username_availability.dart';
import 'users_api_models.dart';

UserProfile mapProfileDto(ProfileDto dto, {String? email}) {
  return UserProfile(
    id: dto.userId,
    displayName: dto.displayName,
    username: dto.username,
    pokidokiId: dto.publicId,
    email: email,
    bio: dto.bio,
    avatarUrl: dto.avatarUrl,
    isVerified: true,
    isDiscoverable: dto.isDiscoverable,
  );
}

UsernameAvailability mapUsernameAvailabilityDto(UsernameAvailabilityDto dto) {
  return UsernameAvailability(username: dto.username, available: dto.available);
}

UserSearchPage mapSearchPageDto(SearchUsersResponseDto dto) {
  return UserSearchPage(
    items: dto.items.map(mapSearchItemDto).toList(),
    page: dto.page,
    limit: dto.limit,
    total: dto.total,
    hasMore: dto.hasMore,
  );
}

UserSearchResult mapSearchItemDto(SearchUserItemDto dto) {
  return UserSearchResult(
    id: dto.userId,
    displayName: dto.displayName,
    username: dto.username,
    pokidokiId: dto.publicId,
    isVerified: true,
  );
}

UserProfilePreview mapProfilePreviewDto(ProfilePreviewDto dto) {
  return UserProfilePreview(
    id: dto.userId,
    displayName: dto.displayName,
    username: dto.username,
    pokidokiId: dto.publicId,
    bio: dto.bio,
    isVerified: true,
    relationship: ProfileRelationship.none,
  );
}
