import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routing/route_names.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../features/authentication/presentation/controllers/auth_flow_controller.dart';
import '../../../../features/authentication/presentation/widgets/auth_scaffold.dart';
import '../../../../features/authentication/presentation/widgets/number_pad.dart';
import '../../../../features/authentication/presentation/widgets/pin_indicators.dart';
import '../../../../l10n/app_localizations.dart';

class ConfirmPinScreen extends ConsumerStatefulWidget {
  const ConfirmPinScreen({super.key, this.fromSettings = false});

  final bool fromSettings;

  @override
  ConsumerState<ConfirmPinScreen> createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends ConsumerState<ConfirmPinScreen> {
  String _pin = '';
  String? _error;

  void _onDigit(String digit) {
    if (_pin.length >= 6) {
      return;
    }
    setState(() {
      _pin += digit;
      _error = null;
    });
  }

  void _onBackspace() {
    if (_pin.isEmpty) {
      return;
    }
    setState(() {
      _pin = _pin.substring(0, _pin.length - 1);
      _error = null;
    });
  }

  void _confirm() async {
    final l10n = AppLocalizations.of(context);
    final ok = await ref
        .read(authFlowProvider.notifier)
        .confirmPinMatches(_pin);
    if (!ok) {
      setState(() {
        _pin = '';
        _error = l10n.authPinMismatch;
      });
      return;
    }
    if (widget.fromSettings) {
      ref.read(authFlowProvider.notifier).setPendingPin('');
      context.go(AppRoutes.settingsAppLock);
      return;
    }
    context.push(AppRoutes.enableBiometrics);
  }

  void _chooseDifferent() {
    ref.read(authFlowProvider.notifier).setPendingPin('');
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;

    return AuthScaffold(
      title: l10n.authConfirmPinTitle,
      onBack: () => context.pop(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: PokidokiSpacing.lg),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Icon(Icons.lock_rounded, color: colors.primary, size: 36),
                    const SizedBox(height: PokidokiSpacing.md),
                    Text(
                      l10n.authConfirmPinHeading,
                      style: typography.screenTitle.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: PokidokiSpacing.sm),
                    Text(
                      l10n.authConfirmPinBody,
                      style: typography.body.copyWith(
                        color: colors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: PokidokiSpacing.xl),
                    PinIndicators(
                      length: 6,
                      filledCount: _pin.length,
                      semanticLabel: l10n.authPinDigitsEntered(_pin.length),
                    ),
                    const SizedBox(height: PokidokiSpacing.md),
                    Text(
                      _error ?? l10n.authEnterAllSixDigits,
                      style: typography.caption.copyWith(
                        color: _error != null
                            ? colors.error
                            : colors.textTertiary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: PokidokiSpacing.xl),
                    NumberPad(onDigit: _onDigit, onBackspace: _onBackspace),
                  ],
                ),
              ),
            ),
            PokidokiButton.primary(
              label: l10n.authConfirmPinAction,
              onPressed: _pin.length == 6 ? _confirm : null,
            ),
            const SizedBox(height: PokidokiSpacing.sm),
            PokidokiButton.text(
              label: l10n.authChooseDifferentPin,
              onPressed: _chooseDifferent,
            ),
            const SizedBox(height: PokidokiSpacing.md),
          ],
        ),
      ),
    );
  }
}
