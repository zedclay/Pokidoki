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

class CreatePinScreen extends ConsumerStatefulWidget {
  const CreatePinScreen({super.key, this.fromSettings = false});

  final bool fromSettings;

  @override
  ConsumerState<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends ConsumerState<CreatePinScreen> {
  String _pin = '';

  void _onDigit(String digit) {
    if (_pin.length >= 6) {
      return;
    }
    setState(() => _pin += digit);
  }

  void _onBackspace() {
    if (_pin.isEmpty) {
      return;
    }
    setState(() => _pin = _pin.substring(0, _pin.length - 1));
  }

  void _continue() {
    if (_pin.length != 6) {
      return;
    }
    ref.read(authFlowProvider.notifier).setPendingPin(_pin);
    final confirmPath = widget.fromSettings
        ? '${AppRoutes.confirmPin}?mode=settings'
        : AppRoutes.confirmPin;
    context.push(confirmPath);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;

    return AuthScaffold(
      title: l10n.authCreatePinTitle,
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
                      l10n.authCreatePinHeading,
                      style: typography.screenTitle.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: PokidokiSpacing.sm),
                    Text(
                      l10n.authCreatePinBody,
                      style: typography.body.copyWith(
                        color: colors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: PokidokiSpacing.xs),
                    Text(
                      l10n.authPinDifferentFromPassword,
                      style: typography.caption.copyWith(
                        color: colors.textTertiary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: PokidokiSpacing.xl),
                    PinIndicators(
                      length: 6,
                      filledCount: _pin.length,
                      semanticLabel: l10n.authPinDigitsEntered(_pin.length),
                    ),
                    const SizedBox(height: PokidokiSpacing.xl),
                    NumberPad(onDigit: _onDigit, onBackspace: _onBackspace),
                  ],
                ),
              ),
            ),
            PokidokiButton.primary(
              label: l10n.actionContinue,
              onPressed: _pin.length == 6 ? _continue : null,
            ),
            const SizedBox(height: PokidokiSpacing.md),
            Text(
              l10n.authPinLocalProtectionNote,
              style: typography.caption.copyWith(color: colors.textTertiary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: PokidokiSpacing.md),
          ],
        ),
      ),
    );
  }
}
