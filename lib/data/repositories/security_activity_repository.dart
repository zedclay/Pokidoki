/// Security activity event summary for settings.
class SecurityActivityEvent {
  const SecurityActivityEvent({
    required this.id,
    required this.type,
    required this.summary,
    required this.occurredAt,
  });

  final String id;
  final String type;
  final String summary;
  final DateTime occurredAt;
}

/// Backend security activity boundary (full integration deferred).
abstract interface class SecurityActivityRepository {
  Future<List<SecurityActivityEvent>> listEvents({
    int page = 1,
    int limit = 20,
  });
}
