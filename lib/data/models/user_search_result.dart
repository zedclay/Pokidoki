/// Privacy-safe user directory search result.
class UserSearchResult {
  const UserSearchResult({
    required this.id,
    required this.displayName,
    required this.username,
    required this.pokidokiId,
    this.bio,
    this.isVerified = false,
  });

  final String id;
  final String displayName;
  final String username;
  final String pokidokiId;
  final String? bio;
  final bool isVerified;
}
