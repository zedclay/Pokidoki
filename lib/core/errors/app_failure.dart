/// User-safe failure representation.
///
/// Never expose stack traces, exception class names, or internal identifiers
/// through [messageKey] consumers.
sealed class AppFailure {
  const AppFailure({required this.messageKey});

  /// Localization key or stable message identifier for UI presentation.
  final String messageKey;
}

final class RecoverableFailure extends AppFailure {
  const RecoverableFailure({super.messageKey = 'stateError'});
}

final class OfflineFailure extends AppFailure {
  const OfflineFailure({super.messageKey = 'stateOffline'});
}

final class NotFoundFailure extends AppFailure {
  const NotFoundFailure({super.messageKey = 'stateEmpty'});
}
