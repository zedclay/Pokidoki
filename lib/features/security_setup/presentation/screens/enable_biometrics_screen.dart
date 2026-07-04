import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routing/route_names.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../../../design_system/radii/pokidoki_radii.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../features/authentication/presentation/controllers/auth_flow_controller.dart';
import '../../../../features/authentication/presentation/widgets/auth_scaffold.dart';
import '../../../../l10n/app_localizations.dart';

class EnableBiometricsScreen extends ConsumerWidget {
  const EnableBiometricsScreen({super.key});

  void _continue(BuildContext context, WidgetRef ref, {required bool enabled}) {
    ref.read(authFlowProvider.notifier).setBiometricsEnabled(enabled);
    context.push(AppRoutes.appLock);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;

    return AuthScaffold(
      title: l10n.appName,
      onBack: () => context.pop(),
      body: Padding(
        padding: const EdgeInsets.all(PokidokiSpacing.lg),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Icon(
                      Icons.fingerprint_rounded,
                      size: 72,
                      color: colors.primary,
                    ),
                    const SizedBox(height: PokidokiSpacing.xl),
                    Text(
                      l10n.authBiometricsHeading,
                      style: typography.screenTitle.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: PokidokiSpacing.sm),
                    Text(
                      l10n.authBiometricsBody,
                      style: typography.body.copyWith(
                        color: colors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: PokidokiSpacing.xl),
                    _BenefitRow(
                      icon: Icons.bolt_rounded,
                      title: l10n.authBiometricsFasterTitle,
                      body: l10n.authBiometricsFasterBody,
                    ),
                    const SizedBox(height: PokidokiSpacing.sm),
                    _BenefitRow(
                      icon: Icons.smartphone_rounded,
                      title: l10n.authBiometricsDeviceTitle,
                      body: l10n.authBiometricsDeviceBody,
                    ),
                    const SizedBox(height: PokidokiSpacing.sm),
                    _BenefitRow(
                      icon: Icons.lock_rounded,
                      title: l10n.authBiometricsPinTitle,
                      body: l10n.authBiometricsPinBody,
                    ),
                    const SizedBox(height: PokidokiSpacing.lg),
                    Text(
                      l10n.authBiometricsPrivacyNote,
                      style: typography.caption.copyWith(
                        color: colors.textTertiary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            PokidokiButton.primary(
              label: l10n.authEnableBiometricsAction,
              onPressed: () => _continue(context, ref, enabled: true),
            ),
            const SizedBox(height: PokidokiSpacing.md),
            PokidokiButton.secondary(
              label: l10n.authNotNow,
              onPressed: () => _continue(context, ref, enabled: false),
            ),
          ],
        ),
      ),
    );
  }
}

class _BenefitRow extends StatelessWidget {
  const _BenefitRow({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: PokidokiRadii.borderXl,
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(PokidokiSpacing.md),
        child: Row(
          children: [
            Icon(icon, color: colors.primary),
            const SizedBox(width: PokidokiSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: typography.cardTitle),
                  Text(body, style: typography.supportingBody),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
