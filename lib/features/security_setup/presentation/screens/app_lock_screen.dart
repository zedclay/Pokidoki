import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routing/route_names.dart';
import '../../../../core/utilities/bidirectional_text.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../../../design_system/components/identity/pokidoki_identity.dart';
import '../../../../design_system/components/layout/pokidoki_safe_area.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../features/authentication/presentation/controllers/auth_flow_controller.dart';
import '../../../../features/authentication/presentation/widgets/number_pad.dart';
import '../../../../features/authentication/presentation/widgets/pin_indicators.dart';
import '../../../../l10n/app_localizations.dart';

class AppLockScreen extends ConsumerStatefulWidget {
  const AppLockScreen({super.key});

  @override
  ConsumerState<AppLockScreen> createState() => _AppLockScreenState();
}

class _AppLockScreenState extends ConsumerState<AppLockScreen> {
  String _pin = '';
  String? _error;

  void _onDigit(String digit) {
    if (_pin.length >= 6) {
      return;
    }
    final next = _pin + digit;
    setState(() {
      _pin = next;
      _error = null;
    });
    if (next.length == 6) {
      _tryUnlock(next);
    }
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

  void _tryUnlock(String pin) {
    final l10n = AppLocalizations.of(context);
    final ok = ref.read(authFlowProvider.notifier).unlockWithPin(pin);
    if (!ok) {
      setState(() {
        _pin = '';
        _error = l10n.authAppLockError;
      });
      return;
    }
    ref.read(authFlowProvider.notifier).clearSensitiveFlow();
    context.go(AppRoutes.appChats);
  }

  void _tryBiometrics() {
    final l10n = AppLocalizations.of(context);
    final ok = ref.read(authFlowProvider.notifier).unlockWithBiometrics();
    if (!ok) {
      setState(() => _error = l10n.authBiometricsUnavailable);
      return;
    }
    ref.read(authFlowProvider.notifier).clearSensitiveFlow();
    context.go(AppRoutes.appChats);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final flow = ref.watch(authFlowProvider);
    final displayName = flow.displayName.isEmpty
        ? 'Zed Clay'
        : flow.displayName;
    final username = flow.username.isEmpty ? 'zedclay' : flow.username;

    return PokidokiScaffold(
      backgroundColor: colors.background,
      body: PokidokiSafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: PokidokiSpacing.lg),
          child: Column(
            children: [
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: PokidokiIconButton(
                  icon: Icons.help_outline_rounded,
                  tooltip: l10n.authForgotPin,
                  onPressed: () => context.push(AppRoutes.pinRecovery),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        l10n.appName,
                        style: typography.screenTitle.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: PokidokiSpacing.md),
                      PokidokiAvatar(displayName: displayName, size: 80),
                      const SizedBox(height: PokidokiSpacing.md),
                      Text(displayName, style: typography.cardTitle),
                      LtrText('@$username', style: typography.supportingBody),
                      const SizedBox(height: PokidokiSpacing.xl),
                      Text(
                        l10n.authAppLockHeading,
                        style: typography.sectionTitle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: PokidokiSpacing.xs),
                      Text(
                        l10n.authAppLockBody,
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
                        _error ?? l10n.authEnterAppPin,
                        style: typography.caption.copyWith(
                          color: _error != null
                              ? colors.error
                              : colors.textTertiary,
                        ),
                      ),
                      const SizedBox(height: PokidokiSpacing.xl),
                      NumberPad(
                        onDigit: _onDigit,
                        onBackspace: _onBackspace,
                        showBiometrics: true,
                        onBiometrics: _tryBiometrics,
                      ),
                      const SizedBox(height: PokidokiSpacing.lg),
                      TextButton(
                        onPressed: () => context.push(AppRoutes.pinRecovery),
                        child: Text(l10n.authForgotPin),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
