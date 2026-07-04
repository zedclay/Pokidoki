/// Immutable account and privacy settings for UI development.
class AccountSettings {
  const AccountSettings({
    required this.appLockEnabled,
    required this.biometricsEnabled,
    required this.disappearingMessagesDefaultHours,
    required this.readReceiptsEnabled,
    required this.themeModeName,
    required this.localeCode,
  });

  final bool appLockEnabled;
  final bool biometricsEnabled;
  final int? disappearingMessagesDefaultHours;
  final bool readReceiptsEnabled;
  final String themeModeName;
  final String localeCode;
}
