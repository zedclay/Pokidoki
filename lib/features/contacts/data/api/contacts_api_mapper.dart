import '../../../../data/models/blocked_user.dart';
import '../../../../data/models/contact.dart';
import '../../../../data/models/contact_page.dart';
import '../../../../data/models/contact_request.dart';
import '../../../../data/models/user_profile_preview.dart';
import '../../../../data/models/user_relationship.dart';
import '../../../../data/models/user_search_result.dart';
import 'contacts_api_models.dart';

Contact mapContactDto(ContactItemDto dto) {
  return Contact(
    id: dto.userId,
    displayName: dto.displayName,
    username: dto.username,
    pokidokiId: dto.publicId,
    status: ContactStatus.connected,
    avatarUrl: dto.avatarUrl,
  );
}

ContactRequest mapContactRequestDto(ContactRequestDto dto) {
  return ContactRequest(
    id: dto.requestId,
    userId: dto.userId,
    displayName: dto.displayName,
    username: dto.username,
    pokidokiId: dto.publicId,
    direction: dto.direction == 'incoming'
        ? ContactRequestDirection.incoming
        : ContactRequestDirection.outgoing,
    createdAt: DateTime.parse(dto.createdAt),
  );
}

BlockedUser mapBlockedUserDto(BlockedUserItemDto dto) {
  return BlockedUser(
    id: dto.userId,
    displayName: dto.displayName,
    username: dto.username,
    pokidokiId: dto.publicId,
    blockedAt: DateTime.parse(dto.blockedAt),
  );
}

UserRelationship mapRelationshipDto(RelationshipDto dto) {
  return UserRelationship(
    isContact: dto.isContact,
    incomingRequestId: dto.incomingRequestId,
    outgoingRequestId: dto.outgoingRequestId,
    blockedByMe: dto.blockedByMe,
    canSendRequest: dto.canSendRequest,
  );
}

UserSearchResult mapSearchResultDto(PublicProfileDto dto) {
  return UserSearchResult(
    id: dto.userId,
    displayName: dto.displayName,
    username: dto.username,
    pokidokiId: dto.publicId,
    bio: dto.bio,
  );
}

ProfileRelationship mapProfileRelationship(UserRelationship relationship) {
  if (relationship.blockedByMe) {
    return ProfileRelationship.blockedByMe;
  }
  if (relationship.isContact) {
    return ProfileRelationship.contact;
  }
  if (relationship.incomingRequestId != null) {
    return ProfileRelationship.pendingIncoming;
  }
  if (relationship.outgoingRequestId != null) {
    return ProfileRelationship.pendingOutgoing;
  }
  if (!relationship.canSendRequest) {
    return ProfileRelationship.unavailable;
  }
  return ProfileRelationship.none;
}

UserProfilePreview mapPublicProfilePreview({
  required PublicProfileDto profile,
  required UserRelationship relationship,
  String? sharedContext,
}) {
  return UserProfilePreview(
    id: profile.userId,
    displayName: profile.displayName,
    username: profile.username,
    pokidokiId: profile.publicId,
    bio: profile.bio,
    relationship: mapProfileRelationship(relationship),
    sharedContext: sharedContext,
  );
}

ContactPage mapContactPage(PaginatedContactsDto dto) {
  return ContactPage(
    items: dto.items.map(mapContactDto).toList(),
    page: dto.page,
    limit: dto.limit,
    hasMore: dto.hasMore,
  );
}

ContactRequestPage mapContactRequestPage(PaginatedContactRequestsDto dto) {
  return ContactRequestPage(
    items: dto.items.map(mapContactRequestDto).toList(),
    page: dto.page,
    limit: dto.limit,
    hasMore: dto.hasMore,
  );
}

BlockedUserPage mapBlockedUserPage(PaginatedBlockedUsersDto dto) {
  return BlockedUserPage(
    items: dto.items.map(mapBlockedUserDto).toList(),
    page: dto.page,
    limit: dto.limit,
    hasMore: dto.hasMore,
  );
}
