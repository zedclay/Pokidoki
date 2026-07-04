import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../design_system/colors/pokidoki_colors.dart';
import '../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../design_system/spacing/pokidoki_spacing.dart';
import '../../design_system/typography/pokidoki_typography.dart';
import '../../l10n/app_localizations.dart';
import 'route_names.dart';

/// Safe fallback when navigation targets an unknown route.
class RouteNotFoundScreen extends StatelessWidget {
  const RouteNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;

    return PokidokiScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(PokidokiSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Icon(
                Icons.link_off_rounded,
                size: 48,
                color: colors.textTertiary,
              ),
              const SizedBox(height: PokidokiSpacing.md),
              Text(
                l10n.routeNotFoundTitle,
                style: typography.screenTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: PokidokiSpacing.sm),
              Text(
                l10n.routeNotFoundBody,
                style: typography.supportingBody.copyWith(
                  color: colors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              PokidokiButton.primary(
                label: l10n.routeNotFoundAction,
                onPressed: () => context.go(AppRoutes.welcome),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
