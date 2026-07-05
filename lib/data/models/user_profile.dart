/// Immutable user identity model for UI development.
class UserProfile {
  const UserProfile({
    required this.id,
    required this.displayName,
    required this.username,
    required this.pokidokiId,
    this.email,
    this.bio,
    this.avatarUrl,
    this.isVerified = false,
    this.isDiscoverable = true,
  });

  final String id;
  final String displayName;
  final String username;
  final String pokidokiId;
  final String? email;
  final String? bio;
  final String? avatarUrl;
  final bool isVerified;
  final bool isDiscoverable;

  UserProfile copyWith({
    String? displayName,
    String? username,
    String? bio,
    bool? isDiscoverable,
  }) {
    return UserProfile(
      id: id,
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      pokidokiId: pokidokiId,
      email: email,
      bio: bio ?? this.bio,
      avatarUrl: avatarUrl,
      isVerified: isVerified,
      isDiscoverable: isDiscoverable ?? this.isDiscoverable,
    );
  }
}
