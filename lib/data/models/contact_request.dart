/// Direction of a contact request.
enum ContactRequestDirection { incoming, outgoing }

/// Immutable contact request model for UI development.
class ContactRequest {
  const ContactRequest({
    required this.id,
    required this.userId,
    required this.displayName,
    required this.username,
    required this.pokidokiId,
    required this.direction,
    required this.createdAt,
    this.bio,
  });

  final String id;
  final String userId;
  final String displayName;
  final String username;
  final String pokidokiId;
  final ContactRequestDirection direction;
  final DateTime createdAt;
  final String? bio;
}
