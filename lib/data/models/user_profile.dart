/// Immutable user identity model for UI development.
class UserProfile {
  const UserProfile({
    required this.id,
    required this.displayName,
    required this.username,
    required this.pokidokiId,
    this.email,
    this.avatarUrl,
    this.isVerified = false,
  });

  final String id;
  final String displayName;
  final String username;
  final String pokidokiId;
  final String? email;
  final String? avatarUrl;
  final bool isVerified;
}
