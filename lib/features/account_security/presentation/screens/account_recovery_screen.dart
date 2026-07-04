import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../data/models/account_security.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/components/settings/pokidoki_settings_rows.dart';
import '../../../../design_system/radii/pokidoki_radii.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../authentication/presentation/widgets/verification_code_input.dart';
import '../../../settings/presentation/widgets/settings_app_bar.dart';
import '../../../settings/presentation/widgets/settings_section_card.dart';
import '../controllers/account_security_controller.dart';
import '../widgets/password_requirement_list.dart';
import '../widgets/secure_password_field.dart';

class AccountRecoveryScreen extends ConsumerStatefulWidget {
  const AccountRecoveryScreen({super.key});

  @override
  ConsumerState<AccountRecoveryScreen> createState() =>
      _AccountRecoveryScreenState();
}

class _AccountRecoveryScreenState extends ConsumerState<AccountRecoveryScreen> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  String _code = '';

  @override
  void dispose() {
    _passwordController.clear();
    _confirmController.clear();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final security = ref.watch(accountSecurityProvider);

    return PokidokiScaffold(
      body: SafeArea(
        child: Column(
          children: [
            SettingsAppBar(title: l10n.accountRecoveryTitle),
            Expanded(
              child: switch (security.recoveryStep) {
                RecoveryStep.introduction => _Introduction(
                  onStart: () => _confirmStart(context),
                  onCannotAccess: () => _showSupportSheet(context),
                ),
                RecoveryStep.codeVerification => _CodeStep(
                  code: _code,
                  onCodeChanged: (value) => setState(() => _code = value),
                  onCancel: () {
                    setState(() => _code = '');
                    ref.read(accountSecurityProvider.notifier).cancelRecovery();
                  },
                  onVerify: () async {
                    await ref
                        .read(accountSecurityProvider.notifier)
                        .verifyRecoveryCode(_code);
                    if (mounted) {
                      setState(() => _code = '');
                    }
                  },
                ),
                RecoveryStep.newPassword => _PasswordStep(
                  passwordController: _passwordController,
                  confirmController: _confirmController,
                  onComplete: () async {
                    if (_passwordController.text != _confirmController.text) {
                      return;
                    }
                    final ok = await ref
                        .read(accountSecurityProvider.notifier)
                        .completeRecovery(_passwordController.text);
                    if (ok) {
                      _passwordController.clear();
                      _confirmController.clear();
                    }
                  },
                ),
                RecoveryStep.completed => _Completed(
                  onDone: () {
                    ref.read(accountSecurityProvider.notifier).resetRecovery();
                    context.pop();
                  },
                ),
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmStart(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final email = ref.read(accountSecurityProvider).email.maskedEmail;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.accountStartRecoveryTitle),
        content: Text(l10n.accountStartRecoveryBody(email)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.actionCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.accountStartRecoveryAction),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(accountSecurityProvider.notifier).startRecovery();
    }
  }

  void _showSupportSheet(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final typography = context.pokidokiTypography;
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(PokidokiSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.accountCannotAccessEmail, style: typography.cardTitle),
              const SizedBox(height: PokidokiSpacing.sm),
              Text(
                l10n.accountSupportNeverasks,
                style: typography.supportingBody,
              ),
              const SizedBox(height: PokidokiSpacing.md),
              PokidokiButton.secondary(
                label: l10n.actionCancel,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Introduction extends ConsumerWidget {
  const _Introduction({required this.onStart, required this.onCannotAccess});

  final VoidCallback onStart;
  final VoidCallback onCannotAccess;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final security = ref.watch(accountSecurityProvider);

    return ListView(
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.accountRecoveryAvailableTitle,
                          style: typography.cardTitle,
                        ),
                        Text(
                          l10n.accountRecoveryAvailable,
                          style: typography.caption.copyWith(
                            color: colors.secure,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: PokidokiSpacing.lg),
        SettingsSectionCard(
          title: l10n.accountRecoveryMethod,
          children: [
            PokidokiSettingsRow(
              title: l10n.accountVerifiedEmail,
              subtitle: security.email.maskedEmail,
              leading: const SettingsIconBadge(icon: Icons.mail_rounded),
              trailing: Text(
                l10n.settingsVerified,
                style: typography.caption.copyWith(color: colors.secure),
              ),
            ),
            PokidokiSettingsRow(
              title: l10n.settingsThisDevice,
              subtitle: l10n.accountThisPhone,
              leading: const SettingsIconBadge(icon: Icons.smartphone_rounded),
              trailing: Text(
                l10n.accountRecognized,
                style: typography.caption.copyWith(color: colors.secure),
              ),
            ),
          ],
        ),
        const SizedBox(height: PokidokiSpacing.lg),
        Text(l10n.accountWhatHappensNext, style: typography.cardTitle),
        const SizedBox(height: PokidokiSpacing.sm),
        SettingsSectionCard(
          children: [
            _StepRow(
              number: '1',
              title: l10n.accountRecoveryStep1,
              body: l10n.accountRecoveryStep1Body,
            ),
            _StepRow(
              number: '2',
              title: l10n.accountRecoveryStep2,
              body: l10n.accountRecoveryStep2Body,
            ),
            _StepRow(
              number: '3',
              title: l10n.accountRecoveryStep3,
              body: l10n.accountRecoveryStep3Body,
            ),
            _StepRow(
              number: '4',
              title: l10n.accountRecoveryStep4,
              body: l10n.accountRecoveryStep4Body,
            ),
          ],
        ),
        const SizedBox(height: PokidokiSpacing.md),
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.warning.withValues(alpha: 0.12),
            borderRadius: PokidokiRadii.borderXl,
            border: Border.all(color: colors.warning.withValues(alpha: 0.4)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(PokidokiSpacing.md),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.warning_amber_rounded, color: colors.warning),
                const SizedBox(width: PokidokiSpacing.sm),
                Expanded(
                  child: Text(
                    l10n.accountLocalDataWarning,
                    style: typography.supportingBody,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: PokidokiSpacing.md),
        SettingsSectionCard(
          children: [
            PokidokiToggleRow(
              title: l10n.accountSignOutOtherDevices,
              subtitle: l10n.accountSignOutOtherDevicesRecommended,
              value: security.recoverySignOutOtherDevices,
              onChanged: (value) => ref
                  .read(accountSecurityProvider.notifier)
                  .setRecoverySignOutOtherDevices(value),
            ),
          ],
        ),
        const SizedBox(height: PokidokiSpacing.xl),
        PokidokiButton.primary(
          label: l10n.accountStartRecoveryAction,
          isLoading: security.isSubmitting,
          onPressed: security.isSubmitting ? null : onStart,
        ),
        const SizedBox(height: PokidokiSpacing.sm),
        PokidokiButton.secondary(
          label: l10n.actionCancel,
          onPressed: () => context.pop(),
        ),
        TextButton(
          onPressed: onCannotAccess,
          child: Text(l10n.accountCannotAccessEmail),
        ),
      ],
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({
    required this.number,
    required this.title,
    required this.body,
  });

  final String number;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final typography = context.pokidokiTypography;
    return Padding(
      padding: const EdgeInsets.all(PokidokiSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$number.', style: typography.cardTitle),
          const SizedBox(width: PokidokiSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: typography.body),
                Text(body, style: typography.supportingBody),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeStep extends ConsumerWidget {
  const _CodeStep({
    required this.code,
    required this.onCodeChanged,
    required this.onCancel,
    required this.onVerify,
  });

  final String code;
  final ValueChanged<String> onCodeChanged;
  final VoidCallback onCancel;
  final Future<void> Function() onVerify;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final security = ref.watch(accountSecurityProvider);

    return ListView(
      padding: const EdgeInsets.all(PokidokiSpacing.lg),
      children: [
        Text(l10n.accountVerificationCode, style: typography.sectionTitle),
        const SizedBox(height: PokidokiSpacing.sm),
        Text(
          l10n.accountStartRecoveryBody(security.email.maskedEmail),
          style: typography.supportingBody,
        ),
        const SizedBox(height: PokidokiSpacing.lg),
        VerificationCodeInput(
          onChanged: onCodeChanged,
          semanticLabel: l10n.accountVerificationCode,
        ),
        if (security.errorKey == 'accountRecoveryCodeInvalid') ...[
          const SizedBox(height: PokidokiSpacing.sm),
          Text(
            l10n.accountRecoveryCodeInvalid,
            style: typography.supportingBody.copyWith(color: colors.error),
          ),
        ],
        const SizedBox(height: PokidokiSpacing.xl),
        PokidokiButton.primary(
          label: l10n.actionContinue,
          isLoading: security.isSubmitting,
          onPressed: security.isSubmitting || code.length != 6
              ? null
              : onVerify,
        ),
        const SizedBox(height: PokidokiSpacing.sm),
        PokidokiButton.secondary(
          label: l10n.accountCancelRecovery,
          onPressed: onCancel,
        ),
      ],
    );
  }
}

class _PasswordStep extends ConsumerStatefulWidget {
  const _PasswordStep({
    required this.passwordController,
    required this.confirmController,
    required this.onComplete,
  });

  final TextEditingController passwordController;
  final TextEditingController confirmController;
  final Future<void> Function() onComplete;

  @override
  ConsumerState<_PasswordStep> createState() => _PasswordStepState();
}

class _PasswordStepState extends ConsumerState<_PasswordStep> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final security = ref.watch(accountSecurityProvider);
    final password = widget.passwordController.text;
    final matches =
        password.isNotEmpty && password == widget.confirmController.text;
    final canSubmit = AccountPasswordPolicy.isStrong(password) && matches;

    return ListView(
      padding: const EdgeInsets.all(PokidokiSpacing.lg),
      children: [
        Text(l10n.accountCreateNewPassword, style: typography.sectionTitle),
        const SizedBox(height: PokidokiSpacing.lg),
        SecurePasswordField(
          controller: widget.passwordController,
          label: l10n.accountNewPassword,
          autofillHints: const [AutofillHints.newPassword],
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: PokidokiSpacing.sm),
        PasswordRequirementList(password: password),
        const SizedBox(height: PokidokiSpacing.md),
        SecurePasswordField(
          controller: widget.confirmController,
          label: l10n.accountConfirmNewPassword,
          autofillHints: const [AutofillHints.newPassword],
          onChanged: (_) => setState(() {}),
        ),
        if (security.errorKey != null) ...[
          const SizedBox(height: PokidokiSpacing.sm),
          Text(
            l10n.accountSecurityGenericError,
            style: typography.supportingBody.copyWith(color: colors.error),
          ),
        ],
        const SizedBox(height: PokidokiSpacing.xl),
        PokidokiButton.primary(
          label: l10n.accountRestoreAccess,
          isLoading: security.isSubmitting,
          onPressed: security.isSubmitting || !canSubmit
              ? null
              : widget.onComplete,
        ),
      ],
    );
  }
}

class _Completed extends StatelessWidget {
  const _Completed({required this.onDone});

  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;

    return Padding(
      padding: const EdgeInsets.all(PokidokiSpacing.lg),
      child: Column(
        children: [
          const Spacer(),
          Icon(Icons.check_circle_rounded, size: 64, color: colors.secure),
          const SizedBox(height: PokidokiSpacing.md),
          Text(l10n.accountRecoveryCompleted, style: typography.sectionTitle),
          const SizedBox(height: PokidokiSpacing.sm),
          Text(
            l10n.accountRecoveryCompletedBody,
            style: typography.supportingBody,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          PokidokiButton.primary(label: l10n.actionContinue, onPressed: onDone),
        ],
      ),
    );
  }
}
