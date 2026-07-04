import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routing/route_names.dart';
import '../../../../core/utilities/bidirectional_text.dart';
import '../../../../data/mock/mock_sample_data.dart';
import '../../../../data/models/storage_usage.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/identity/pokidoki_identity.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/components/settings/pokidoki_settings_rows.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../authentication/presentation/controllers/auth_flow_controller.dart';
import '../controllers/settings_controller.dart';
import '../widgets/settings_section_card.dart';
import '../widgets/settings_sign_out.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final auth = ref.watch(authFlowProvider);
    final settings = ref.watch(settingsProvider);
    final prefs = settings.securityPreferences;
    const user = MockSampleData.currentUser;
    final displayName = auth.displayName.isNotEmpty
        ? auth.displayName
        : user.displayName;
    final username = auth.username.isNotEmpty ? auth.username : user.username;

    return PokidokiScaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            PokidokiSpacing.lg,
            PokidokiSpacing.sm,
            PokidokiSpacing.lg,
            PokidokiSpacing.xl,
          ),
          children: [
            Text(l10n.settingsTitle, style: typography.screenTitle),
            const SizedBox(height: PokidokiSpacing.md),
            Semantics(
              button: true,
              label: '$displayName, @$username, ${user.pokidokiId}',
              child: InkWell(
                onTap: () => context.push(AppRoutes.settingsAccount),
                borderRadius: BorderRadius.circular(18),
                child: SettingsSectionCard(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(PokidokiSpacing.md),
                      child: Row(
                        children: [
                          PokidokiAvatar(displayName: displayName, size: 56),
                          const SizedBox(width: PokidokiSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(displayName, style: typography.cardTitle),
                                LtrText(
                                  '@$username',
                                  style: typography.supportingBody,
                                ),
                                LtrText(
                                  user.pokidokiId,
                                  style: typography.caption,
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: colors.textTertiary,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        PokidokiSpacing.md,
                        0,
                        PokidokiSpacing.md,
                        PokidokiSpacing.md,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.verified_user_rounded,
                            size: 18,
                            color: colors.secure,
                          ),
                          const SizedBox(width: PokidokiSpacing.xs),
                          Expanded(
                            child: Text(
                              l10n.settingsAccountProtected,
                              style: typography.caption.copyWith(
                                color: colors.secure,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            tooltip: l10n.qrMyCodeTitle,
                            onPressed: () => context.push(AppRoutes.myQrCode),
                            icon: Icon(
                              Icons.qr_code_scanner_rounded,
                              color: colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: PokidokiSpacing.lg),
            SettingsSectionCard(
              title: l10n.settingsPrivacySecurity,
              children: [
                PokidokiNavigationRow(
                  title: l10n.settingsAppLock,
                  subtitle: l10n.settingsAppLockSubtitle,
                  leading: SettingsIconBadge(
                    icon: Icons.lock_rounded,
                    color: colors.primary,
                  ),
                  onTap: () => context.push(AppRoutes.settingsAppLock),
                ),
                PokidokiToggleRow(
                  title: l10n.settingsBiometricUnlock,
                  value: prefs.biometricsEnabled,
                  onChanged: (value) {
                    ref
                        .read(settingsProvider.notifier)
                        .updateSecurityPreferences(
                          prefs.copyWith(biometricsEnabled: value),
                        );
                  },
                ),
                PokidokiNavigationRow(
                  title: l10n.settingsAutomaticallyLock,
                  subtitle: _lockDelayLabel(l10n, prefs.lockDelay),
                  leading: const SettingsIconBadge(icon: Icons.timer_rounded),
                  onTap: () => context.push(AppRoutes.settingsAppLock),
                ),
                PokidokiToggleRow(
                  title: l10n.settingsScreenPrivacy,
                  subtitle: l10n.settingsScreenPrivacySubtitle,
                  value: prefs.hideContentInAppSwitcher,
                  onChanged: (value) {
                    ref
                        .read(settingsProvider.notifier)
                        .updateSecurityPreferences(
                          prefs.copyWith(hideContentInAppSwitcher: value),
                        );
                  },
                ),
                PokidokiToggleRow(
                  title: l10n.settingsReadReceipts,
                  value: settings.readReceiptsEnabled,
                  onChanged: (value) => ref
                      .read(settingsProvider.notifier)
                      .setReadReceipts(value),
                ),
                PokidokiToggleRow(
                  title: l10n.settingsTypingIndicators,
                  value: settings.typingIndicatorsEnabled,
                  onChanged: (value) => ref
                      .read(settingsProvider.notifier)
                      .setTypingIndicators(value),
                ),
                PokidokiNavigationRow(
                  title: l10n.settingsBlockedUsers,
                  leading: const SettingsIconBadge(icon: Icons.block_rounded),
                  onTap: () => context.push(AppRoutes.settingsBlockedUsers),
                ),
                PokidokiNavigationRow(
                  title: l10n.settingsLinkedDevices,
                  subtitle: l10n.settingsActiveDevices(
                    settings.activeDeviceCount,
                  ),
                  leading: const SettingsIconBadge(icon: Icons.devices_rounded),
                  onTap: () => context.push(AppRoutes.settingsLinkedDevices),
                ),
                PokidokiNavigationRow(
                  title: l10n.settingsSecurityActivity,
                  subtitle: l10n.settingsSecurityActivitySubtitle,
                  leading: const SettingsIconBadge(
                    icon: Icons.security_rounded,
                  ),
                  onTap: () => context.push(AppRoutes.settingsSecurityActivity),
                ),
              ],
            ),
            const SizedBox(height: PokidokiSpacing.lg),
            SettingsSectionCard(
              title: l10n.settingsPreferences,
              children: [
                PokidokiNavigationRow(
                  title: l10n.settingsAppearance,
                  leading: const SettingsIconBadge(icon: Icons.palette_rounded),
                  onTap: () => context.push(AppRoutes.settingsAppearance),
                ),
                PokidokiNavigationRow(
                  title: l10n.settingsLanguage,
                  leading: const SettingsIconBadge(
                    icon: Icons.language_rounded,
                  ),
                  onTap: () => context.push(AppRoutes.settingsLanguage),
                ),
                PokidokiNavigationRow(
                  title: l10n.settingsStorageUsage,
                  leading: const SettingsIconBadge(icon: Icons.storage_rounded),
                  onTap: () => context.push(AppRoutes.settingsStorage),
                ),
              ],
            ),
            const SizedBox(height: PokidokiSpacing.lg),
            SettingsSectionCard(
              title: l10n.settingsNotifications,
              children: [
                PokidokiToggleRow(
                  title: l10n.settingsMessageNotifications,
                  value: settings.messageNotificationsEnabled,
                  onChanged: (value) => ref
                      .read(settingsProvider.notifier)
                      .setMessageNotifications(value),
                ),
                PokidokiToggleRow(
                  title: l10n.settingsNotificationPreviews,
                  subtitle: l10n.settingsNotificationPreviewsSubtitle,
                  value: settings.notificationPreviewsEnabled,
                  onChanged: (value) => ref
                      .read(settingsProvider.notifier)
                      .setNotificationPreviews(value),
                ),
                PokidokiValueRow(
                  title: l10n.settingsNotificationSound,
                  value: l10n.settingsNotificationSoundDefault,
                ),
                PokidokiToggleRow(
                  title: l10n.settingsVibration,
                  value: settings.vibrationEnabled,
                  onChanged: (value) =>
                      ref.read(settingsProvider.notifier).setVibration(value),
                ),
              ],
            ),
            const SizedBox(height: PokidokiSpacing.lg),
            SettingsSectionCard(
              title: l10n.settingsHelpInformation,
              children: [
                PokidokiNavigationRow(
                  title: l10n.settingsHelpCenter,
                  leading: const SettingsIconBadge(
                    icon: Icons.help_outline_rounded,
                  ),
                  onTap: () => _showHelpDialog(context, l10n),
                ),
                PokidokiValueRow(
                  title: l10n.settingsPokidokiVersion,
                  value: '1.0.0',
                ),
              ],
            ),
            const SizedBox(height: PokidokiSpacing.lg),
            SettingsSectionCard(
              children: [
                PokidokiSettingsRow(
                  title: l10n.settingsSignOutAction,
                  leading: SettingsIconBadge(
                    icon: Icons.logout_rounded,
                    color: colors.error,
                  ),
                  onTap: () => confirmAndSignOut(context, ref),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _lockDelayLabel(AppLocalizations l10n, AppLockDelay delay) {
    return switch (delay) {
      AppLockDelay.immediately => l10n.settingsLockImmediately,
      AppLockDelay.oneMinute => l10n.settingsLockAfter1Minute,
      AppLockDelay.fiveMinutes => l10n.settingsLockAfter5Minutes,
      AppLockDelay.thirtyMinutes => l10n.settingsLockAfter30Minutes,
    };
  }

  void _showHelpDialog(BuildContext context, AppLocalizations l10n) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.settingsHelpCenter),
        content: Text(l10n.settingsHelpPlaceholder),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.actionCancel),
          ),
        ],
      ),
    );
  }
}
