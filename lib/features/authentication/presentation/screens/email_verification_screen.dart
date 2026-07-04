import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routing/route_names.dart';
import '../../../../core/utilities/bidirectional_text.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/auth_flow_controller.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/verification_code_input.dart';

class EmailVerificationScreen extends ConsumerStatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  ConsumerState<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState
    extends ConsumerState<EmailVerificationScreen> {
  String _code = '';
  int _secondsRemaining = 42;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining <= 0) {
        timer.cancel();
        return;
      }
      setState(() => _secondsRemaining -= 1);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _verify() async {
    final ok = await ref.read(authFlowProvider.notifier).verifyEmailCode(_code);
    if (!mounted) {
      return;
    }
    if (ok) {
      context.push(AppRoutes.usernameSetup);
    }
  }

  void _resend() {
    if (_secondsRemaining > 0) {
      return;
    }
    setState(() => _secondsRemaining = 42);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining <= 0) {
        timer.cancel();
        return;
      }
      setState(() => _secondsRemaining -= 1);
    });
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.authCodeResent)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final flow = ref.watch(authFlowProvider);
    final canVerify = _code.length == 6 && !flow.isLoading;

    return AuthScaffold(
      title: l10n.authVerifyEmailTitle,
      onBack: () => context.pop(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(PokidokiSpacing.lg),
        child: Column(
          children: [
            Icon(Icons.mail_outline_rounded, size: 48, color: colors.primary),
            const SizedBox(height: PokidokiSpacing.lg),
            Text(
              l10n.authCheckYourEmail,
              style: typography.screenTitle.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: PokidokiSpacing.sm),
            Text(
              l10n.authVerificationBody,
              style: typography.body.copyWith(color: colors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: PokidokiSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.alternate_email,
                  size: 18,
                  color: colors.textTertiary,
                ),
                const SizedBox(width: PokidokiSpacing.xs),
                LtrText(
                  flow.maskedEmail,
                  style: typography.supportingBody.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: PokidokiSpacing.xl),
            VerificationCodeInput(
              semanticLabel: l10n.authVerificationCodeSemantic,
              onChanged: (value) => setState(() => _code = value),
            ),
            const SizedBox(height: PokidokiSpacing.md),
            Text(
              _secondsRemaining > 0
                  ? l10n.authResendCountdown(
                      _secondsRemaining.toString().padLeft(2, '0'),
                    )
                  : l10n.authResendReady,
              style: typography.caption,
            ),
            if (flow.errorMessageKey != null) ...[
              const SizedBox(height: PokidokiSpacing.sm),
              Text(
                l10n.authVerificationError,
                style: typography.caption.copyWith(color: colors.error),
              ),
            ],
            const SizedBox(height: PokidokiSpacing.xl),
            PokidokiButton.primary(
              label: l10n.authVerifyEmailAction,
              isLoading: flow.isLoading,
              onPressed: canVerify ? _verify : null,
            ),
            const SizedBox(height: PokidokiSpacing.md),
            TextButton(
              onPressed: _secondsRemaining == 0 ? _resend : null,
              child: Text(l10n.authResendCode),
            ),
            TextButton(
              onPressed: () => context.pop(),
              child: Text(l10n.authChangeEmail),
            ),
          ],
        ),
      ),
    );
  }
}
