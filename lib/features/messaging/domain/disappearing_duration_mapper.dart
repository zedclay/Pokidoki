/// Centralized mapping between Flutter UI hours and Backend seconds.
class DisappearingDurationMapper {
  const DisappearingDurationMapper._();

  static const hourOptions = [1, 24, 168];

  static int? hoursToSeconds(int? hours) {
    if (hours == null) {
      return 0;
    }
    return switch (hours) {
      1 => 3600,
      24 => 86400,
      168 => 604800,
      _ => throw ArgumentError('Unsupported disappearing hours: $hours'),
    };
  }

  static int? secondsToHours(int? seconds) {
    if (seconds == null || seconds == 0) {
      return null;
    }
    return switch (seconds) {
      3600 => 1,
      86400 => 24,
      604800 => 168,
      _ => null,
    };
  }
}
