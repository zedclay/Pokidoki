/// Immutable linked-device model for UI development.
class LinkedDevice {
  const LinkedDevice({
    required this.id,
    required this.name,
    required this.platform,
    required this.lastActiveAt,
    this.isCurrentDevice = false,
    this.needsReview = false,
    this.approximateLocation,
  });

  final String id;
  final String name;
  final String platform;
  final DateTime lastActiveAt;
  final bool isCurrentDevice;
  final bool needsReview;
  final String? approximateLocation;
}
