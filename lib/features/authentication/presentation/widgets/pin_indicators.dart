import 'package:flutter/material.dart';

import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';

class PinIndicators extends StatelessWidget {
  const PinIndicators({
    super.key,
    required this.length,
    required this.filledCount,
    required this.semanticLabel,
  });

  final int length;
  final int filledCount;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;

    return Semantics(
      label: semanticLabel,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(length, (index) {
          final filled = index < filledCount;
          return Padding(
            padding: EdgeInsetsDirectional.only(
              end: index == length - 1 ? 0 : PokidokiSpacing.md,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: filled ? colors.primary : Colors.transparent,
                border: Border.all(
                  color: filled ? colors.primary : colors.border,
                  width: 2,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
