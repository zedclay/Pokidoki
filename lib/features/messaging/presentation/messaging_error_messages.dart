import '../../../l10n/app_localizations.dart';
import '../data/messaging_failure.dart';

String messagingFailureMessage(
  AppLocalizations l10n,
  MessagingFailure failure,
) {
  return messagingErrorMessage(l10n, failure.resolvedMessageKey);
}

String messagingErrorMessage(AppLocalizations l10n, String? messageKey) {
  return switch (messageKey) {
    'conversationContactRequired' => l10n.conversationContactRequired,
    'conversationUnavailable' => l10n.conversationUnavailable,
    'conversationSelfNotAllowed' => l10n.cannotMessageUser,
    'localDatabaseUnavailable' => l10n.localDatabaseUnavailable,
    'localDatabaseKeyUnavailable' => l10n.localDatabaseKeyUnavailable,
    'localDatabaseCorrupt' => l10n.localDatabaseCorrupt,
    'localDatabaseEncryptionUnavailable' =>
      l10n.localDatabaseEncryptionUnavailable,
    'syncTemporarilyUnavailable' => l10n.syncTemporarilyUnavailable,
    'messagingUnavailable' => l10n.messagingUnavailable,
    _ => l10n.messagingUnavailable,
  };
}
