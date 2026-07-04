import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routing/route_names.dart';
import '../../../../core/utilities/bidirectional_text.dart';
import '../../../../data/mock/mock_sample_data.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/identity/pokidoki_identity.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/components/settings/pokidoki_settings_rows.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../authentication/presentation/controllers/auth_flow_controller.dart';
import '../widgets/settings_app_bar.dart';
import '../widgets/settings_section_card.dart';
import '../widgets/settings_sign_out.dart';

class AccountManagementScreen extends ConsumerWidget {
  const AccountManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final auth = ref.watch(authFlowProvider);
    const user = MockSampleData.currentUser;
    final displayName = auth.displayName.isNotEmpty
        ? auth.displayName
        : user.displayName;
    final username = auth.username.isNotEmpty ? auth.username : user.username;
    final maskedEmail = auth.email.isNotEmpty
        ? auth.maskedEmail
        : 'z••••••@example.com';

    return PokidokiScaffold(
      body: SafeArea(
        child: Column(
          children: [
            SettingsAppBar(title: l10n.settingsAccount),
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
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                PokidokiAvatar(
                                  displayName: displayName,
                                  size: 72,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: colors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.photo_camera_rounded,
                                    size: 14,
                                    color: colors.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: PokidokiSpacing.sm),
                            Text(displayName, style: typography.cardTitle),
                            LtrText(
                              '@$username',
                              style: typography.supportingBody,
                            ),
                            const SizedBox(height: PokidokiSpacing.xs),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.verified_user_rounded,
                                  size: 16,
                                  color: colors.secure,
                                ),
                                const SizedBox(width: PokidokiSpacing.xxs),
                                Text(
                                  l10n.settingsAccountProtected,
                                  style: typography.caption.copyWith(
                                    color: colors.secure,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: PokidokiSpacing.lg),
                  SettingsSectionCard(
                    title: l10n.settingsPublicIdentity,
                    children: [
                      PokidokiValueRow(
                        title: l10n.settingsDisplayName,
                        value: displayName,
                        onTap: () => context.push(AppRoutes.profileSetup),
                      ),
                      PokidokiNavigationRow(
                        title: l10n.settingsUsername,
                        subtitle: '@$username',
                        onTap: () => context.push(AppRoutes.usernameSetup),
                      ),
                      PokidokiSettingsRow(
                        title: l10n.settingsPokidokiId,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LtrText(
                              user.pokidokiId,
                              style: typography.supportingBody,
                            ),
                            IconButton(
                              tooltip: l10n.settingsCopyId,
                              onPressed: () async {
                                await Clipboard.setData(
                                  ClipboardData(text: user.pokidokiId),
                                );
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(l10n.settingsIdCopied),
                                    ),
                                  );
                                }
                              },
                              icon: Icon(
                                Icons.copy_rounded,
                                size: 18,
                                color: colors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PokidokiNavigationRow(
                        title: l10n.qrMyCodeTitle,
                        subtitle: l10n.settingsSharePublicIdentity,
                        leading: const SettingsIconBadge(
                          icon: Icons.qr_code_rounded,
                        ),
                        onTap: () => context.push(AppRoutes.myQrCode),
                      ),
                      PokidokiNavigationRow(
                        title: l10n.settingsPreviewPublicProfile,
                        subtitle: l10n.settingsPreviewPublicProfileBody,
                        leading: const SettingsIconBadge(
                          icon: Icons.visibility_rounded,
                        ),
                        onTap: () =>
                            context.push(AppRoutes.userProfilePath(user.id)),
                      ),
                    ],
                  ),
                  const SizedBox(height: PokidokiSpacing.lg),
                  SettingsSectionCard(
                    title: l10n.settingsSignInRecovery,
                    children: [
                      PokidokiSettingsRow(
                        title: l10n.settingsEmailAddress,
                        subtitle: maskedEmail,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              size: 16,
                              color: colors.secure,
                            ),
                            const SizedBox(width: PokidokiSpacing.xxs),
                            Text(
                              l10n.settingsVerified,
                              style: typography.caption.copyWith(
                                color: colors.secure,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              color: colors.textTertiary,
                            ),
                          ],
                        ),
                        onTap: () =>
                            context.push(AppRoutes.settingsAccountEmail),
                      ),
                      PokidokiNavigationRow(
                        title: l10n.settingsPassword,
                        subtitle: l10n.settingsPasswordChangedAgo,
                        onTap: () => context.push(
                          AppRoutes.settingsAccountChangePassword,
                        ),
                      ),
                      PokidokiNavigationRow(
                        title: l10n.settingsAccountRecovery,
                        subtitle: l10n.settingsAccountRecoverySubtitle,
                        leading: const SettingsIconBadge(
                          icon: Icons.shield_rounded,
                        ),
                        onTap: () =>
                            context.push(AppRoutes.settingsAccountRecovery),
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
                      PokidokiSettingsRow(
                        title: l10n.settingsDeleteAccount,
                        leading: SettingsIconBadge(
                          icon: Icons.delete_forever_rounded,
                          color: colors.textTertiary,
                        ),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                l10n.settingsDeleteAccountUnavailable,
                              ),
                            ),
                          );
                        },
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
}
