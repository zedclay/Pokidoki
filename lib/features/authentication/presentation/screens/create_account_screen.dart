import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routing/route_names.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../../../design_system/components/inputs/pokidoki_text_field.dart';
import '../../../../design_system/radii/pokidoki_radii.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/auth_flow_controller.dart';
import '../widgets/auth_requirement_row.dart';
import '../widgets/auth_scaffold.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  ConsumerState<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _agreed = false;
  bool _submitted = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String value) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim());
  }

  bool get _hasMinLength => _passwordController.text.length >= 10;
  bool get _hasUpper => RegExp(r'[A-Z]').hasMatch(_passwordController.text);
  bool get _hasLower => RegExp(r'[a-z]').hasMatch(_passwordController.text);
  bool get _hasNumber => RegExp(r'[0-9]').hasMatch(_passwordController.text);
  bool get _hasSymbol =>
      RegExp(r'[^A-Za-z0-9]').hasMatch(_passwordController.text);
  bool get _passwordsMatch =>
      _passwordController.text.isNotEmpty &&
      _passwordController.text == _confirmController.text;

  bool get _isValid =>
      _isValidEmail(_emailController.text) &&
      _hasMinLength &&
      _hasUpper &&
      _hasLower &&
      _hasNumber &&
      _hasSymbol &&
      _passwordsMatch &&
      _agreed;

  Future<void> _submit() async {
    setState(() => _submitted = true);
    if (!_isValid) {
      return;
    }
    final ok = await ref
        .read(authFlowProvider.notifier)
        .createAccount(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
    if (!mounted) {
      return;
    }
    if (ok) {
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
      title: l10n.authCreateAccountTitle,
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
            Text(
              l10n.authCreateAccountHeading,
              style: typography.screenTitle.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: PokidokiSpacing.xs),
            Text(
              l10n.authCreateAccountBody,
              style: typography.body.copyWith(color: colors.textSecondary),
            ),
            const SizedBox(height: PokidokiSpacing.xl),
            PokidokiTextField(
              controller: _emailController,
              label: l10n.authEmailLabel,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              prefixIcon: Icon(
                Icons.email_outlined,
                color: colors.textTertiary,
              ),
              onChanged: (_) => setState(() {}),
            ),
            if (_submitted && !_isValidEmail(_emailController.text)) ...[
              const SizedBox(height: PokidokiSpacing.xs),
              Text(
                l10n.authInvalidEmail,
                style: typography.caption.copyWith(color: colors.error),
              ),
            ],
            const SizedBox(height: PokidokiSpacing.md),
            PokidokiPasswordField(
              controller: _passwordController,
              label: l10n.authPasswordLabel,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: PokidokiSpacing.md),
            PokidokiPasswordField(
              controller: _confirmController,
              label: l10n.authConfirmPasswordLabel,
              onChanged: (_) => setState(() {}),
            ),
            if (_submitted && !_passwordsMatch) ...[
              const SizedBox(height: PokidokiSpacing.xs),
              Text(
                l10n.authPasswordMismatch,
                style: typography.caption.copyWith(color: colors.error),
              ),
            ],
            const SizedBox(height: PokidokiSpacing.md),
            DecoratedBox(
              decoration: BoxDecoration(
                color: colors.surfaceElevated,
                borderRadius: PokidokiRadii.borderXl,
                border: Border.all(color: colors.border),
              ),
              child: Padding(
                padding: const EdgeInsets.all(PokidokiSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.authPasswordRequirements,
                      style: typography.inputLabel,
                    ),
                    const SizedBox(height: PokidokiSpacing.md),
                    AuthRequirementRow(
                      label: l10n.authPasswordMinLength,
                      met: _hasMinLength,
                    ),
                    const SizedBox(height: PokidokiSpacing.xs),
                    AuthRequirementRow(
                      label: l10n.authPasswordUppercase,
                      met: _hasUpper,
                    ),
                    const SizedBox(height: PokidokiSpacing.xs),
                    AuthRequirementRow(
                      label: l10n.authPasswordLowercase,
                      met: _hasLower,
                    ),
                    const SizedBox(height: PokidokiSpacing.xs),
                    AuthRequirementRow(
                      label: l10n.authPasswordNumber,
                      met: _hasNumber,
                    ),
                    const SizedBox(height: PokidokiSpacing.xs),
                    AuthRequirementRow(
                      label: l10n.authPasswordSymbol,
                      met: _hasSymbol,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: PokidokiSpacing.md),
            InkWell(
              onTap: () => setState(() => _agreed = !_agreed),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: _agreed,
                      onChanged: (value) =>
                          setState(() => _agreed = value ?? false),
                    ),
                  ),
                  const SizedBox(width: PokidokiSpacing.xs),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        style: typography.supportingBody,
                        children: [
                          TextSpan(text: l10n.authAgreePrefix),
                          TextSpan(
                            text: l10n.welcomeTermsOfService,
                            style: TextStyle(color: colors.primary),
                          ),
                          TextSpan(text: l10n.welcomeTermsMiddle),
                          TextSpan(
                            text: l10n.welcomePrivacyPolicy,
                            style: TextStyle(color: colors.primary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: PokidokiSpacing.md),
            DecoratedBox(
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: PokidokiRadii.borderXl,
                border: Border.all(color: colors.border),
              ),
              child: Padding(
                padding: const EdgeInsets.all(PokidokiSpacing.md),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.shield_rounded, color: colors.secure, size: 20),
                    const SizedBox(width: PokidokiSpacing.md),
                    Expanded(
                      child: Text(
                        l10n.authPasswordPrivacyNote,
                        style: typography.caption.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (flow.errorMessageKey != null) ...[
              const SizedBox(height: PokidokiSpacing.md),
              Text(
                l10n.authGenericError,
                style: typography.caption.copyWith(color: colors.error),
              ),
            ],
            const SizedBox(height: PokidokiSpacing.xl),
            PokidokiButton.primary(
              label: l10n.authCreateAccountAction,
              isLoading: flow.isLoading,
              onPressed: _isValid && !flow.isLoading ? _submit : null,
            ),
            const SizedBox(height: PokidokiSpacing.lg),
            Text.rich(
              TextSpan(
                style: typography.supportingBody,
                children: [
                  TextSpan(text: l10n.authAlreadyHaveAccount),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: GestureDetector(
                      onTap: () => context.pushReplacement(AppRoutes.signIn),
                      child: Text(
                        l10n.actionSignIn,
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
