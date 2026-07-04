/// Shared application constants that are not design tokens.
abstract final class AppConstants {
  static const String appName = 'Pokidoki';

  /// Supported application locales.
  static const supportedLanguageCodes = <String>['en', 'ar', 'fr'];

  /// Brief minimum splash presentation so branding is visible without a long delay.
  /// Production bootstrap should not add artificial delay beyond real work.
  static const Duration splashMinDuration = Duration(milliseconds: 700);

  /// Maximum time splash will wait for bootstrap before continuing.
  static const Duration splashTimeout = Duration(seconds: 8);
}
