import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routing/route_names.dart';
import '../../../../data/models/account_security.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/components/settings/pokidoki_settings_rows.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../settings/presentation/widgets/settings_app_bar.dart';
import '../../../settings/presentation/widgets/settings_section_card.dart';
import '../controllers/account_security_controller.dart';
import '../widgets/password_requirement_list.dart';
import '../widgets/secure_password_field.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _touched = false;

  @override
  void dispose() {
    _currentController.clear();
    _newController.clear();
    _confirmController.clear();
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  bool get _matches =>
      _newController.text.isNotEmpty &&
      _newController.text == _confirmController.text;

  bool get _canSubmit =>
      _currentController.text.isNotEmpty &&
      AccountPasswordPolicy.isStrong(_newController.text) &&
      _newController.text != _currentController.text &&
      _matches;

  Future<void> _submit() async {
    setState(() => _touched = true);
    if (!_canSubmit) {
      return;
    }
    final ok = await ref
        .read(accountSecurityProvider.notifier)
        .changePassword(
          currentPassword: _currentController.text,
          newPassword: _newController.text,
        );
    if (!mounted) {
      return;
    }
    if (ok) {
      _currentController.clear();
      _newController.clear();
      _confirmController.clear();
      final l10n = AppLocalizations.of(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.accountPasswordUpdated)));
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final security = ref.watch(accountSecurityProvider);
    final error = _messageFor(l10n, security.errorKey);

    return PokidokiScaffold(
      body: SafeArea(
        child: Column(
          children: [
            SettingsAppBar(title: l10n.accountChangePassword),
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
                              icon: Icons.lock_rounded,
                              color: colors.primary,
                            ),
                            const SizedBox(width: PokidokiSpacing.sm),
                            Expanded(
                              child: Text(
                                l10n.accountProtectAccount,
                                style: typography.cardTitle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: PokidokiSpacing.lg),
                  SecurePasswordField(
                    controller: _currentController,
                    label: l10n.accountCurrentPassword,
                    autofillHints: const [AutofillHints.password],
                    textInputAction: TextInputAction.next,
                    onChanged: (_) => setState(() {}),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextButton(
                      onPressed: () =>
                          context.push(AppRoutes.settingsAccountRecovery),
                      child: Text(l10n.accountForgotCurrentPassword),
                    ),
                  ),
                  const SizedBox(height: PokidokiSpacing.sm),
                  SecurePasswordField(
                    controller: _newController,
                    label: l10n.accountNewPassword,
                    autofillHints: const [AutofillHints.newPassword],
                    textInputAction: TextInputAction.next,
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: PokidokiSpacing.sm),
                  PasswordRequirementList(
                    password: _newController.text,
                    currentPassword: _currentController.text,
                    showDifferentFromCurrent: true,
                  ),
                  const SizedBox(height: PokidokiSpacing.md),
                  SecurePasswordField(
                    controller: _confirmController,
                    label: l10n.accountConfirmNewPassword,
                    autofillHints: const [AutofillHints.newPassword],
                    textInputAction: TextInputAction.done,
                    onChanged: (_) => setState(() {}),
                  ),
                  if (_touched &&
                      !_matches &&
                      _confirmController.text.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: PokidokiSpacing.xs),
                      child: Text(
                        l10n.accountPasswordMismatch,
                        style: typography.caption.copyWith(color: colors.error),
                      ),
                    ),
                  const SizedBox(height: PokidokiSpacing.lg),
                  SettingsSectionCard(
                    children: [
                      PokidokiToggleRow(
                        title: l10n.accountSignOutOtherDevices,
                        value: security.signOutOtherDevices,
                        onChanged: (value) => ref
                            .read(accountSecurityProvider.notifier)
                            .setSignOutOtherDevices(value),
                      ),
                    ],
                  ),
                  const SizedBox(height: PokidokiSpacing.md),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: colors.textSecondary,
                      ),
                      const SizedBox(width: PokidokiSpacing.sm),
                      Expanded(
                        child: Text(
                          l10n.accountPasswordPinDifferent,
                          style: typography.supportingBody,
                        ),
                      ),
                    ],
                  ),
                  if (error != null) ...[
                    const SizedBox(height: PokidokiSpacing.md),
                    Text(
                      error,
                      style: typography.supportingBody.copyWith(
                        color: colors.error,
                      ),
                    ),
                  ],
                  const SizedBox(height: PokidokiSpacing.xl),
                  PokidokiButton.primary(
                    label: l10n.accountUpdatePassword,
                    isLoading: security.isSubmitting,
                    onPressed: security.isSubmitting || !_canSubmit
                        ? null
                        : _submit,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _messageFor(AppLocalizations l10n, String? key) {
    return switch (key) {
      'accountPasswordUpdateFailed' => l10n.accountPasswordUpdateFailed,
      'accountSecurityGenericError' => l10n.accountSecurityGenericError,
      _ => null,
    };
  }
}
