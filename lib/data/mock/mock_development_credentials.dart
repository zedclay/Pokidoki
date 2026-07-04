/// Centralized development-only values for mock UI flows.
///
/// These are **not** production secrets. Never log, display in release UI,
/// or persist these values outside in-memory mock repositories.
abstract final class MockDevelopmentCredentials {
  /// Mock account password for change-password and reauthentication flows.
  static const accountPassword = 'Pokidoki!2026';

  /// Email verification during sign-up and email-change flows.
  static const emailVerificationCode = '123456';

  /// Account recovery verification code.
  static const accountRecoveryCode = '654321';

  /// Fallback app PIN when sign-in path has no setup PIN in memory.
  static const appPinFallback = '123456';
}
