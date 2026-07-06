/// Immutable conversation summary for list UI.
class Conversation {
  const Conversation({
    required this.id,
    required this.peerId,
    required this.peerDisplayName,
    required this.peerUsername,
    required this.updatedAt,
    this.lastMessagePreview,
    this.unreadCount = 0,
    this.isPeerVerified = false,
    this.disappearingMessagesEnabled = false,
    this.isPinned = false,
    this.isMuted = false,
    this.isOutgoingPreview = false,
    this.isBlocked = false,
    this.canSend = true,
    this.disappearingDurationHours,
  });

  final String id;
  final String peerId;
  final String peerDisplayName;
  final String peerUsername;
  final DateTime updatedAt;
  final String? lastMessagePreview;
  final int unreadCount;
  final bool isPeerVerified;
  final bool disappearingMessagesEnabled;
  final bool isPinned;
  final bool isMuted;
  final bool isOutgoingPreview;
  final bool isBlocked;
  final bool canSend;

  /// `null` means off. Common values: 1, 24, 168.
  final int? disappearingDurationHours;

  Conversation copyWith({
    int? unreadCount,
    String? lastMessagePreview,
    bool? isPeerVerified,
    bool? isMuted,
    bool? isBlocked,
    bool? canSend,
    bool? isOutgoingPreview,
    DateTime? updatedAt,
    bool? disappearingMessagesEnabled,
    int? disappearingDurationHours,
    bool clearDisappearing = false,
  }) {
    return Conversation(
      id: id,
      peerId: peerId,
      peerDisplayName: peerDisplayName,
      peerUsername: peerUsername,
      updatedAt: updatedAt ?? this.updatedAt,
      lastMessagePreview: lastMessagePreview ?? this.lastMessagePreview,
      unreadCount: unreadCount ?? this.unreadCount,
      isPeerVerified: isPeerVerified ?? this.isPeerVerified,
      disappearingMessagesEnabled:
          disappearingMessagesEnabled ?? this.disappearingMessagesEnabled,
      isPinned: isPinned,
      isMuted: isMuted ?? this.isMuted,
      isOutgoingPreview: isOutgoingPreview ?? this.isOutgoingPreview,
      isBlocked: isBlocked ?? this.isBlocked,
      canSend: canSend ?? this.canSend,
      disappearingDurationHours: clearDisappearing
          ? null
          : (disappearingDurationHours ?? this.disappearingDurationHours),
    );
  }
}
