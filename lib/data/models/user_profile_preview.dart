/// Privacy-safe public profile preview for contact discovery.
enum ProfileRelationship {
  none,
  pendingOutgoing,
  pendingIncoming,
  contact,
  blockedByMe,
  unavailable,
}

class UserProfilePreview {
  const UserProfilePreview({
    required this.id,
    required this.displayName,
    required this.username,
    required this.pokidokiId,
    required this.relationship,
    this.bio,
    this.isVerified = false,
    this.sharedContext,
  });

  final String id;
  final String displayName;
  final String username;
  final String pokidokiId;
  final ProfileRelationship relationship;
  final String? bio;
  final bool isVerified;
  final String? sharedContext;

  UserProfilePreview copyWith({
    ProfileRelationship? relationship,
    bool? isVerified,
  }) {
    return UserProfilePreview(
      id: id,
      displayName: displayName,
      username: username,
      pokidokiId: pokidokiId,
      relationship: relationship ?? this.relationship,
      bio: bio,
      isVerified: isVerified ?? this.isVerified,
      sharedContext: sharedContext,
    );
  }
}
