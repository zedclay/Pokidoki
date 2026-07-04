import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utilities/bidirectional_text.dart';
import '../../../../data/models/account_security.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../../../design_system/components/inputs/pokidoki_text_field.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/components/settings/pokidoki_settings_rows.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../authentication/presentation/widgets/verification_code_input.dart';
import '../../../settings/presentation/widgets/settings_app_bar.dart';
import '../../../settings/presentation/widgets/settings_section_card.dart';
import '../controllers/account_security_controller.dart';
import '../widgets/secure_password_field.dart';

class EmailManagementScreen extends ConsumerStatefulWidget {
  const EmailManagementScreen({super.key});

  @override
  ConsumerState<EmailManagementScreen> createState() =>
      _EmailManagementScreenState();
}

class _EmailManagementScreenState extends ConsumerState<EmailManagementScreen> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  String _code = '';

  @override
  void dispose() {
    _passwordController.clear();
    _emailController.clear();
    _passwordController.dispose();
    _emailController.dispose();
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
            SettingsAppBar(title: l10n.accountEmailTitle),
            Expanded(
              child: switch (security.emailStep) {
                EmailManagementStep.overview => _Overview(
                  onChangeEmail: () {
                    _passwordController.clear();
                    ref
                        .read(accountSecurityProvider.notifier)
                        .beginEmailChange();
                  },
                ),
                EmailManagementStep.reauthenticate => _ReauthStep(
                  controller: _passwordController,
                  onCancel: () {
                    _passwordController.clear();
                    ref
                        .read(accountSecurityProvider.notifier)
                        .cancelEmailChange();
                  },
                  onContinue: () async {
                    final ok = await ref
                        .read(accountSecurityProvider.notifier)
                        .reauthenticateForEmail(_passwordController.text);
                    if (ok) {
                      _passwordController.clear();
                    }
                  },
                ),
                EmailManagementStep.enterEmail => _EnterEmailStep(
                  controller: _emailController,
                  onCancel: () {
                    _emailController.clear();
                    ref
                        .read(accountSecurityProvider.notifier)
                        .cancelEmailChange();
                  },
                  onContinue: () async {
                    await ref
                        .read(accountSecurityProvider.notifier)
                        .submitNewEmail(_emailController.text);
                  },
                ),
                EmailManagementStep.verifyCode => _VerifyEmailStep(
                  code: _code,
                  onCodeChanged: (value) => setState(() => _code = value),
                  onCancel: () {
                    setState(() => _code = '');
                    ref
                        .read(accountSecurityProvider.notifier)
                        .cancelEmailChange();
                  },
                  onVerify: () async {
                    final messenger = ScaffoldMessenger.of(context);
                    final ok = await ref
                        .read(accountSecurityProvider.notifier)
                        .verifyEmailCode(_code);
                    if (!mounted) {
                      return;
                    }
                    if (ok) {
                      setState(() => _code = '');
                      _emailController.clear();
                      messenger.showSnackBar(
                        SnackBar(content: Text(l10n.accountEmailUpdated)),
                      );
                    }
                  },
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Overview extends ConsumerWidget {
  const _Overview({required this.onChangeEmail});

  final VoidCallback onChangeEmail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final email = ref.watch(accountSecurityProvider).email;

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SettingsIconBadge(
                        icon: Icons.mark_email_read_rounded,
                        color: colors.secure,
                      ),
                      const SizedBox(width: PokidokiSpacing.sm),
                      Expanded(
                        child: Text(
                          l10n.accountEmailVerifiedTitle,
                          style: typography.cardTitle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: PokidokiSpacing.sm),
                  LtrText(email.maskedEmail, style: typography.body),
                  Text(
                    l10n.accountEmailRecoveryHelp,
                    style: typography.supportingBody,
                  ),
                  const SizedBox(height: PokidokiSpacing.xs),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_rounded,
                        color: colors.secure,
                        size: 18,
                      ),
                      const SizedBox(width: PokidokiSpacing.xxs),
                      Text(
                        l10n.accountVerifiedOn('18 June 2026'),
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
          title: l10n.accountEmailSection,
          children: [
            PokidokiSettingsRow(
              title: l10n.settingsEmailAddress,
              subtitle: email.maskedEmail,
              trailing: Text(
                l10n.settingsVerified,
                style: typography.caption.copyWith(color: colors.secure),
              ),
            ),
            PokidokiValueRow(
              title: l10n.accountLastVerified,
              value: '18 June 2026',
            ),
            PokidokiValueRow(
              title: l10n.settingsAccountRecovery,
              value: l10n.accountRecoveryAvailable,
            ),
          ],
        ),
        const SizedBox(height: PokidokiSpacing.lg),
        SettingsSectionCard(
          children: [
            PokidokiNavigationRow(
              title: l10n.accountChangeEmail,
              subtitle: l10n.accountChangeEmailSubtitle,
              leading: const SettingsIconBadge(icon: Icons.edit_rounded),
              onTap: onChangeEmail,
            ),
          ],
        ),
        const SizedBox(height: PokidokiSpacing.lg),
        SettingsSectionCard(
          title: l10n.accountSecurityEmails,
          children: [
            PokidokiSettingsRow(
              title: l10n.accountSecurityAlerts,
              subtitle: l10n.accountSecurityAlertsBody,
              trailing: Text(
                l10n.accountAlwaysOn,
                style: typography.caption.copyWith(color: colors.textSecondary),
              ),
            ),
            PokidokiToggleRow(
              title: l10n.accountNewDeviceAlerts,
              subtitle: l10n.accountNewDeviceAlertsBody,
              value: email.newDeviceAlertsEnabled,
              onChanged: (value) => ref
                  .read(accountSecurityProvider.notifier)
                  .setNewDeviceAlerts(value),
            ),
            PokidokiSettingsRow(
              title: l10n.accountRecoveryAlerts,
              subtitle: l10n.accountRecoveryAlertsBody,
              trailing: Text(
                l10n.accountAlwaysOn,
                style: typography.caption.copyWith(color: colors.textSecondary),
              ),
            ),
          ],
        ),
        const SizedBox(height: PokidokiSpacing.lg),
        SettingsSectionCard(
          title: l10n.accountOptionalCommunications,
          children: [
            PokidokiToggleRow(
              title: l10n.accountProductUpdates,
              value: email.productUpdatesEnabled,
              onChanged: (value) => ref
                  .read(accountSecurityProvider.notifier)
                  .setProductUpdates(value),
            ),
            PokidokiToggleRow(
              title: l10n.accountResearchInvitations,
              value: email.researchInvitationsEnabled,
              onChanged: (value) => ref
                  .read(accountSecurityProvider.notifier)
                  .setResearchInvitations(value),
            ),
          ],
        ),
        const SizedBox(height: PokidokiSpacing.md),
        Text(l10n.accountEmailNotPublic, style: typography.supportingBody),
      ],
    );
  }
}

class _ReauthStep extends ConsumerWidget {
  const _ReauthStep({
    required this.controller,
    required this.onCancel,
    required this.onContinue,
  });

  final TextEditingController controller;
  final VoidCallback onCancel;
  final Future<void> Function() onContinue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final security = ref.watch(accountSecurityProvider);

    return ListView(
      padding: const EdgeInsets.all(PokidokiSpacing.lg),
      children: [
        Text(l10n.accountReauthenticateTitle, style: typography.sectionTitle),
        const SizedBox(height: PokidokiSpacing.sm),
        Text(l10n.accountReauthenticateBody, style: typography.supportingBody),
        const SizedBox(height: PokidokiSpacing.lg),
        SecurePasswordField(
          controller: controller,
          label: l10n.accountCurrentPassword,
          autofillHints: const [AutofillHints.password],
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
          label: l10n.actionContinue,
          isLoading: security.isSubmitting,
          onPressed: security.isSubmitting ? null : onContinue,
        ),
        const SizedBox(height: PokidokiSpacing.sm),
        PokidokiButton.secondary(label: l10n.actionCancel, onPressed: onCancel),
      ],
    );
  }
}

class _EnterEmailStep extends ConsumerWidget {
  const _EnterEmailStep({
    required this.controller,
    required this.onCancel,
    required this.onContinue,
  });

  final TextEditingController controller;
  final VoidCallback onCancel;
  final Future<void> Function() onContinue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final security = ref.watch(accountSecurityProvider);
    final error = switch (security.errorKey) {
      'accountEmailInvalid' => l10n.accountEmailInvalid,
      'accountEmailConflict' => l10n.accountEmailConflict,
      _ => null,
    };

    return ListView(
      padding: const EdgeInsets.all(PokidokiSpacing.lg),
      children: [
        Text(l10n.accountChangeEmail, style: typography.sectionTitle),
        const SizedBox(height: PokidokiSpacing.sm),
        Text(l10n.accountEnterNewEmailBody, style: typography.supportingBody),
        const SizedBox(height: PokidokiSpacing.lg),
        Directionality(
          textDirection: TextDirection.ltr,
          child: PokidokiTextField(
            controller: controller,
            label: l10n.settingsEmailAddress,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: PokidokiSpacing.sm),
          Text(
            error,
            style: typography.supportingBody.copyWith(color: colors.error),
          ),
        ],
        const SizedBox(height: PokidokiSpacing.xl),
        PokidokiButton.primary(
          label: l10n.actionContinue,
          isLoading: security.isSubmitting,
          onPressed: security.isSubmitting ? null : onContinue,
        ),
        const SizedBox(height: PokidokiSpacing.sm),
        PokidokiButton.secondary(label: l10n.actionCancel, onPressed: onCancel),
      ],
    );
  }
}

class _VerifyEmailStep extends ConsumerWidget {
  const _VerifyEmailStep({
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
    final pending = security.email.pendingMaskedEmail ?? '';

    return ListView(
      padding: const EdgeInsets.all(PokidokiSpacing.lg),
      children: [
        Text(l10n.accountVerifyEmailTitle, style: typography.sectionTitle),
        const SizedBox(height: PokidokiSpacing.sm),
        Text(
          l10n.accountVerifyEmailBody(pending),
          style: typography.supportingBody,
        ),
        const SizedBox(height: PokidokiSpacing.lg),
        VerificationCodeInput(
          onChanged: onCodeChanged,
          semanticLabel: l10n.accountVerificationCode,
        ),
        if (security.errorKey == 'accountCodeInvalid') ...[
          const SizedBox(height: PokidokiSpacing.sm),
          Text(
            l10n.accountCodeInvalid,
            style: typography.supportingBody.copyWith(color: colors.error),
          ),
        ],
        const SizedBox(height: PokidokiSpacing.xl),
        PokidokiButton.primary(
          label: l10n.accountVerifyAction,
          isLoading: security.isSubmitting,
          onPressed: security.isSubmitting || code.length != 6
              ? null
              : onVerify,
        ),
        const SizedBox(height: PokidokiSpacing.sm),
        PokidokiButton.secondary(label: l10n.actionCancel, onPressed: onCancel),
      ],
    );
  }
}
