/// Categories of security activity for UI presentation.
enum SecurityEventType {
  signIn,
  appLockChanged,
  deviceLinked,
  deviceRemoved,
  passwordChanged,
  passwordReset,
  verificationCompleted,
  emailVerified,
  emailChangeRequested,
  emailChanged,
  recoveryStarted,
  recoveryCompleted,
  reportSubmitted,
  otherDevicesSignedOut,
  screenPrivacyEnabled,
}

enum SecurityEventFilter { all, devices, identity, signIn }

/// Immutable security activity event for UI development.
class SecurityEvent {
  const SecurityEvent({
    required this.id,
    required this.type,
    required this.occurredAt,
    required this.title,
    required this.summary,
    this.deviceLabel,
    this.requiresAttention = false,
  });

  final String id;
  final SecurityEventType type;
  final DateTime occurredAt;
  final String title;
  final String summary;
  final String? deviceLabel;
  final bool requiresAttention;
}
