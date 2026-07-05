import '../../../../l10n/app_localizations.dart';

/// Maps authentication [messageKey] values to localized user-facing text.
extension AuthMessageLocalization on AppLocalizations {
  String authMessageForKey(String messageKey) {
    return switch (messageKey) {
      'authEmailUnavailable' => authEmailUnavailable,
      'authInvalidCredentials' => authInvalidCredentials,
      'authEmailNotVerified' => authEmailNotVerified,
      'authAccountSuspended' => authAccountSuspended,
      'authAccountDisabled' => authAccountDisabled,
      'authVerificationInvalid' => authVerificationInvalid,
      'authVerificationExpired' => authVerificationExpired,
      'authVerificationAttemptsExceeded' => authVerificationAttemptsExceeded,
      'authVerificationResendTooSoon' => authVerificationResendTooSoon,
      'authSessionExpired' => authSessionExpired,
      'authRateLimited' => authRateLimited,
      'authNoInternet' => authNoInternet,
      'authRequestTimedOut' => authRequestTimedOut,
      'authServerUnavailable' => authServerUnavailable,
      'authUnexpectedError' => authUnexpectedError,
      'authSignInError' => authSignInError,
      'authVerificationError' => authVerificationError,
      'authGenericError' => authGenericError,
      'authPinMismatch' => authPinMismatch,
      'authAppLockError' => authAppLockError,
      'authBiometricsUnavailable' => authBiometricsUnavailable,
      _ => authUnexpectedError,
    };
  }
}
