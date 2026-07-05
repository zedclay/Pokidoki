/// Server-backed relationship state for profile and contact actions.
class UserRelationship {
  const UserRelationship({
    required this.isContact,
    required this.incomingRequestId,
    required this.outgoingRequestId,
    required this.blockedByMe,
    required this.canSendRequest,
  });

  const UserRelationship.none()
    : isContact = false,
      incomingRequestId = null,
      outgoingRequestId = null,
      blockedByMe = false,
      canSendRequest = false;

  final bool isContact;
  final String? incomingRequestId;
  final String? outgoingRequestId;
  final bool blockedByMe;
  final bool canSendRequest;
}
