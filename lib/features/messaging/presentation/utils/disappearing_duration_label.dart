import '../../../../l10n/app_localizations.dart';

String disappearingDurationLabel(AppLocalizations l10n, int? hours) {
  return switch (hours) {
    1 => l10n.chatDisappearingOneHour,
    24 => l10n.chatDisappearingOneDay,
    168 => l10n.chatDisappearingOneWeek,
    _ => l10n.chatDisappearingOff,
  };
}
