import 'package:flutter/material.dart';

import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../models/onboarding_page_data.dart';
import 'onboarding_illustration.dart';

class OnboardingPageContent extends StatelessWidget {
  const OnboardingPageContent({
    super.key,
    required this.data,
    required this.title,
    required this.body,
    required this.illustrationSemanticLabel,
  });

  final OnboardingPageData data;
  final String title;
  final String body;
  final String illustrationSemanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final titleHeight = data.titleFontSize == 24 ? 32 / 24 : 36 / 28;

    return LayoutBuilder(
      builder: (context, constraints) {
        final illustrationSide = data.illustrationSize.clamp(
          180.0,
          constraints.maxWidth,
        );

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: PokidokiSpacing.lg),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OnboardingIllustration(
                  assetPath: data.illustrationAsset,
                  semanticLabel: illustrationSemanticLabel,
                  size: illustrationSide,
                ),
                SizedBox(
                  height: data.illustrationSize <= 256
                      ? PokidokiSpacing.section
                      : PokidokiSpacing.xl,
                ),
                Text(
                  title,
                  style: typography.screenTitle.copyWith(
                    fontSize: data.titleFontSize,
                    fontWeight: data.titleFontWeight,
                    height: titleHeight,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: data.titleFontSize == 24
                      ? PokidokiSpacing.xs
                      : PokidokiSpacing.sm,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: data.bodyMaxWidth),
                  child: Text(
                    body,
                    style: typography.body.copyWith(
                      color: colors.textSecondary,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
