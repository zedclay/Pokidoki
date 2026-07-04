import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routing/route_names.dart';
import '../../../../data/models/storage_usage.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/components/settings/pokidoki_settings_rows.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/settings_controller.dart';
import '../widgets/settings_app_bar.dart';
import '../widgets/settings_section_card.dart';

class AppLockSettingsScreen extends ConsumerWidget {
  const AppLockSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final prefs = ref.watch(settingsProvider).securityPreferences;

    return PokidokiScaffold(
      body: SafeArea(
        child: Column(
          children: [
            SettingsAppBar(title: l10n.settingsAppLock),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  PokidokiSpacing.lg,
                  PokidokiSpacing.sm,
                  PokidokiSpacing.lg,
                  PokidokiSpacing.xl,
                ),
                children: [
                  SettingsSectionCard(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(PokidokiSpacing.md),
                        child: Row(
                          children: [
                            SettingsIconBadge(
                              icon: Icons.shield_rounded,
                              color: colors.secure,
                            ),
                            const SizedBox(width: PokidokiSpacing.sm),
                            Text(
                              l10n.settingsProtected,
                              style: typography.cardTitle.copyWith(
                                color: colors.secure,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PokidokiToggleRow(
                        title: l10n.settingsUseAppLock,
                        value: prefs.appLockEnabled,
                        onChanged: (value) async {
                          if (!value) {
                            final confirmed = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(l10n.settingsTurnOffAppLockTitle),
                                content: Text(l10n.settingsTurnOffAppLockBody),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: Text(l10n.actionCancel),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: Text(
                                      l10n.settingsTurnOffAppLockAction,
                                    ),
                                  ),
                                ],
                              ),
                            );
                            if (confirmed != true) {
                              return;
                            }
                          }
                          ref
                              .read(settingsProvider.notifier)
                              .updateSecurityPreferences(
                                prefs.copyWith(appLockEnabled: value),
                              );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: PokidokiSpacing.lg),
                  SettingsSectionCard(
                    title: l10n.settingsUnlockMethods,
                    children: [
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
                        title: l10n.settingsChangeAppPin,
                        onTap: () => context.push(
                          '${AppRoutes.createPin}?mode=settings',
                        ),
                      ),
                      PokidokiValueRow(
                        title: l10n.settingsPinLength,
                        value: l10n.settingsPinLengthValue,
                      ),
                    ],
                  ),
                  const SizedBox(height: PokidokiSpacing.lg),
                  SettingsSectionCard(
                    title: l10n.settingsAutomaticLocking,
                    children: [
                      PokidokiNavigationRow(
                        title: l10n.settingsAutomaticallyLock,
                        subtitle: _delayLabel(l10n, prefs.lockDelay),
                        onTap: () => _pickDelay(context, ref, prefs),
                      ),
                      PokidokiValueRow(
                        title: l10n.settingsLockAfterRestart,
                        value: l10n.settingsAlwaysRequired,
                      ),
                    ],
                  ),
                  const SizedBox(height: PokidokiSpacing.lg),
                  SettingsSectionCard(
                    title: l10n.settingsPrivacyWhileLocked,
                    children: [
                      PokidokiToggleRow(
                        title: l10n.settingsHideContentInAppSwitcher,
                        value: prefs.hideContentInAppSwitcher,
                        onChanged: (value) {
                          ref
                              .read(settingsProvider.notifier)
                              .updateSecurityPreferences(
                                prefs.copyWith(hideContentInAppSwitcher: value),
                              );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: PokidokiSpacing.lg),
                  SettingsSectionCard(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(PokidokiSpacing.md),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              color: colors.textSecondary,
                            ),
                            const SizedBox(width: PokidokiSpacing.sm),
                            Expanded(
                              child: Text(
                                l10n.settingsPinNotPassword,
                                style: typography.supportingBody,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _delayLabel(AppLocalizations l10n, AppLockDelay delay) {
    return switch (delay) {
      AppLockDelay.immediately => l10n.settingsLockImmediately,
      AppLockDelay.oneMinute => l10n.settingsLockAfter1Minute,
      AppLockDelay.fiveMinutes => l10n.settingsLockAfter5Minutes,
      AppLockDelay.thirtyMinutes => l10n.settingsLockAfter30Minutes,
    };
  }

  Future<void> _pickDelay(
    BuildContext context,
    WidgetRef ref,
    AppSecurityPreferences prefs,
  ) async {
    final l10n = AppLocalizations.of(context);
    final selected = await showModalBottomSheet<AppLockDelay>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final delay in AppLockDelay.values)
                ListTile(
                  title: Text(_delayLabel(l10n, delay)),
                  trailing: prefs.lockDelay == delay
                      ? const Icon(Icons.check_rounded)
                      : null,
                  onTap: () => Navigator.pop(context, delay),
                ),
            ],
          ),
        );
      },
    );
    if (selected != null) {
      ref
          .read(settingsProvider.notifier)
          .updateSecurityPreferences(prefs.copyWith(lockDelay: selected));
    }
  }
}
