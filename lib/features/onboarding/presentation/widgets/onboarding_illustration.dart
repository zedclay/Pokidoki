import 'package:flutter/material.dart';

import '../../../../design_system/colors/pokidoki_colors.dart';

class OnboardingIllustration extends StatelessWidget {
  const OnboardingIllustration({
    super.key,
    required this.assetPath,
    required this.semanticLabel,
    this.size = 320,
  });

  final String assetPath;
  final String semanticLabel;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final side = size;

    return Semantics(
      label: semanticLabel,
      image: true,
      child: SizedBox(
        width: side,
        height: side,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: side * 0.85,
              height: side * 0.85,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: colors.primary.withValues(alpha: 0.12),
                    blurRadius: 80,
                    spreadRadius: 8,
                  ),
                ],
              ),
            ),
            Image.asset(
              assetPath,
              width: side,
              height: side,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.shield_rounded,
                  size: side * 0.35,
                  color: colors.primary,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
