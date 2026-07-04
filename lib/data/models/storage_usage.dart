/// Immutable storage usage summary for UI development.
class StorageUsage {
  const StorageUsage({
    required this.totalBytes,
    required this.mediaBytes,
    required this.filesBytes,
    required this.voiceBytes,
    required this.cacheBytes,
    required this.otherBytes,
  });

  final int totalBytes;
  final int mediaBytes;
  final int filesBytes;
  final int voiceBytes;
  final int cacheBytes;
  final int otherBytes;

  StorageUsage copyWith({int? cacheBytes, int? totalBytes}) {
    return StorageUsage(
      totalBytes: totalBytes ?? this.totalBytes,
      mediaBytes: mediaBytes,
      filesBytes: filesBytes,
      voiceBytes: voiceBytes,
      cacheBytes: cacheBytes ?? this.cacheBytes,
      otherBytes: otherBytes,
    );
  }
}

enum AppLockDelay { immediately, oneMinute, fiveMinutes, thirtyMinutes }

class AppSecurityPreferences {
  const AppSecurityPreferences({
    this.appLockEnabled = true,
    this.biometricsEnabled = false,
    this.lockDelay = AppLockDelay.oneMinute,
    this.hideContentInAppSwitcher = true,
  });

  final bool appLockEnabled;
  final bool biometricsEnabled;
  final AppLockDelay lockDelay;
  final bool hideContentInAppSwitcher;

  AppSecurityPreferences copyWith({
    bool? appLockEnabled,
    bool? biometricsEnabled,
    AppLockDelay? lockDelay,
    bool? hideContentInAppSwitcher,
  }) {
    return AppSecurityPreferences(
      appLockEnabled: appLockEnabled ?? this.appLockEnabled,
      biometricsEnabled: biometricsEnabled ?? this.biometricsEnabled,
      lockDelay: lockDelay ?? this.lockDelay,
      hideContentInAppSwitcher:
          hideContentInAppSwitcher ?? this.hideContentInAppSwitcher,
    );
  }
}
