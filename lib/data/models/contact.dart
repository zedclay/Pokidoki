/// Contact relationship status for UI presentation.
enum ContactStatus {
  none,
  pendingOutgoing,
  pendingIncoming,
  connected,
  blocked,
}

/// Immutable contact model for UI development.
class Contact {
  const Contact({
    required this.id,
    required this.displayName,
    required this.username,
    required this.pokidokiId,
    required this.status,
    this.isVerified = false,
    this.avatarUrl,
  });

  final String id;
  final String displayName;
  final String username;
  final String pokidokiId;
  final ContactStatus status;
  final bool isVerified;
  final String? avatarUrl;

  Contact copyWith({bool? isVerified, ContactStatus? status}) {
    return Contact(
      id: id,
      displayName: displayName,
      username: username,
      pokidokiId: pokidokiId,
      status: status ?? this.status,
      isVerified: isVerified ?? this.isVerified,
      avatarUrl: avatarUrl,
    );
  }
}
