import 'package:flutter/material.dart';

import '../../../../core/utilities/bidirectional_text.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/radii/pokidoki_radii.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';

/// LTR safety-number groups for manual comparison (mock UI data only).
class SafetyNumberBlock extends StatelessWidget {
  const SafetyNumberBlock({
    super.key,
    required this.groups,
    required this.semanticLabel,
  });

  final List<String> groups;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;

    return Semantics(
      label: semanticLabel,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: PokidokiRadii.borderXl,
          border: Border.all(color: colors.border),
        ),
        child: Padding(
          padding: const EdgeInsets.all(PokidokiSpacing.lg),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  spacing: PokidokiSpacing.sm,
                  runSpacing: PokidokiSpacing.sm,
                  children: groups
                      .map(
                        (group) => SizedBox(
                          width:
                              (constraints.maxWidth - PokidokiSpacing.sm * 3) /
                              4,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: LtrText(
                              group,
                              style: typography.sectionTitle.copyWith(
                                fontFamily: 'monospace',
                                letterSpacing: 1.2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
