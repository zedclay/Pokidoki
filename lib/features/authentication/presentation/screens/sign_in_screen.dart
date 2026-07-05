import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../features/users/data/user_providers.dart';
import '../../../../app/routing/route_names.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../../../design_system/components/inputs/pokidoki_text_field.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/auth_flow_controller.dart';
import '../utils/auth_message_localization.dart';
import '../widgets/auth_scaffold.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberDevice = false;
  bool _submitted = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String value) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim()) ||
        RegExp(r'^[a-zA-Z][a-zA-Z0-9._]{2,23}$').hasMatch(value.trim());
  }

  bool get _isValid =>
      _isValidEmail(_emailController.text) &&
      _passwordController.text.isNotEmpty;

  Future<void> _submit() async {
    setState(() => _submitted = true);
    if (!_isValid) {
      return;
    }
    final ok = await ref
        .read(authFlowProvider.notifier)
        .signIn(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
    if (!mounted) {
      return;
    }
    if (ok) {
      _passwordController.clear();
      final profileStatus = ref.read(profileCompletionStatusProvider);
      if (profileStatus == ProfileCompletionStatus.missing) {
        context.push(AppRoutes.usernameSetup);
      } else {
        context.push(AppRoutes.appLock);
      }
      return;
    }

    final flow = ref.read(authFlowProvider);
    if (flow.errorMessageKey == 'authEmailNotVerified' && mounted) {
      context.push(AppRoutes.emailVerification);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final flow = ref.watch(authFlowProvider);

    return AuthScaffold(
      title: l10n.authSignInTitle,
      onBack: () => context.pop(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          PokidokiSpacing.lg,
          PokidokiSpacing.sm,
          PokidokiSpacing.lg,
          PokidokiSpacing.xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.lock_rounded, color: colors.primary, size: 32),
            const SizedBox(height: PokidokiSpacing.sm),
            Text(
              l10n.appName,
              style: typography.sectionTitle.copyWith(color: colors.primary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: PokidokiSpacing.lg),
            Text(
              l10n.authSignInHeading,
              style: typography.screenTitle.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: PokidokiSpacing.xs),
            Text(
              l10n.authSignInBody,
              style: typography.body.copyWith(color: colors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: PokidokiSpacing.xl),
            PokidokiTextField(
              controller: _emailController,
              label: l10n.authEmailOrUsernameLabel,
              prefixIcon: Icon(
                Icons.person_outline,
                color: colors.textTertiary,
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: PokidokiSpacing.md),
            PokidokiPasswordField(
              controller: _passwordController,
              label: l10n.authPasswordLabel,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: PokidokiSpacing.md),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () =>
                        setState(() => _rememberDevice = !_rememberDevice),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: _rememberDevice,
                            onChanged: (value) => setState(
                              () => _rememberDevice = value ?? false,
                            ),
                          ),
                        ),
                        const SizedBox(width: PokidokiSpacing.xs),
                        Flexible(
                          child: Text(
                            l10n.authRememberDevice,
                            style: typography.supportingBody,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => context.push(AppRoutes.accountRecovery),
                  child: Text(l10n.authForgotPassword),
                ),
              ],
            ),
            if (flow.errorMessageKey != null) ...[
              Text(
                l10n.authMessageForKey(flow.errorMessageKey!),
                style: typography.caption.copyWith(color: colors.error),
              ),
              const SizedBox(height: PokidokiSpacing.sm),
            ],
            if (_submitted && !_isValid) ...[
              Text(
                l10n.authInvalidCredentialsForm,
                style: typography.caption.copyWith(color: colors.error),
              ),
              const SizedBox(height: PokidokiSpacing.sm),
            ],
            PokidokiButton.primary(
              label: l10n.authSignInAction,
              isLoading: flow.isLoading,
              onPressed: _isValid && !flow.isLoading ? _submit : null,
            ),
            const SizedBox(height: PokidokiSpacing.md),
            Row(
              children: [
                Expanded(child: Divider(color: colors.border)),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: PokidokiSpacing.md,
                  ),
                  child: Text(
                    l10n.authOrContinueSecurely,
                    style: typography.caption,
                  ),
                ),
                Expanded(child: Divider(color: colors.border)),
              ],
            ),
            const SizedBox(height: PokidokiSpacing.md),
            PokidokiButton.secondary(
              label: l10n.authUseFingerprint,
              icon: Icons.fingerprint_rounded,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.authFingerprintAfterSignIn)),
                );
              },
            ),
            const SizedBox(height: PokidokiSpacing.xxl),
            Text.rich(
              TextSpan(
                style: typography.supportingBody,
                children: [
                  TextSpan(text: l10n.authNewToPokidoki),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: GestureDetector(
                      onTap: () =>
                          context.pushReplacement(AppRoutes.createAccount),
                      child: Text(
                        l10n.authCreateAccountLink,
                        style: typography.supportingBody.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
