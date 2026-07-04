/// Immutable blocked-user model for UI development.
class BlockedUser {
  const BlockedUser({
    required this.id,
    required this.displayName,
    required this.username,
    required this.pokidokiId,
    required this.blockedAt,
  });

  final String id;
  final String displayName;
  final String username;
  final String pokidokiId;
  final DateTime blockedAt;
}
