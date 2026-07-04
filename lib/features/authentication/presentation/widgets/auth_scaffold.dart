import 'package:flutter/material.dart';

import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../../../design_system/components/layout/pokidoki_safe_area.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.body,
    this.title,
    this.onBack,
    this.centerTitle = true,
    this.trailing,
  });

  final Widget body;
  final String? title;
  final VoidCallback? onBack;
  final bool centerTitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final l10n = AppLocalizations.of(context);

    return PokidokiScaffold(
      backgroundColor: colors.background,
      body: PokidokiSafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 56,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: PokidokiSpacing.sm,
                ),
                child: Row(
                  children: [
                    if (onBack != null)
                      PokidokiIconButton(
                        icon: Icons.arrow_back_rounded,
                        tooltip: l10n.semanticBack,
                        semanticLabel: l10n.semanticBack,
                        onPressed: onBack,
                      )
                    else
                      const SizedBox(width: PokidokiSpacing.minTouchTarget),
                    Expanded(
                      child: title == null
                          ? const SizedBox.shrink()
                          : Text(
                              title!,
                              textAlign: centerTitle
                                  ? TextAlign.center
                                  : TextAlign.start,
                              style: typography.sectionTitle.copyWith(
                                fontWeight: FontWeight.w700,
                                color: colors.primary,
                              ),
                            ),
                    ),
                    trailing ??
                        const SizedBox(width: PokidokiSpacing.minTouchTarget),
                  ],
                ),
              ),
            ),
            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}
