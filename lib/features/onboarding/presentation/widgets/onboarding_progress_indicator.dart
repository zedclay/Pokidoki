import 'package:flutter/material.dart';

import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../models/onboarding_page_data.dart';

/// Onboarding progress indicator matching each Stitch page reference.
///
/// Page 1 uses circular dots only.
/// Pages 2–3 use circular inactive dots with an elongated active indicator.
class OnboardingProgressIndicator extends StatelessWidget {
  const OnboardingProgressIndicator({
    super.key,
    required this.pageCount,
    required this.currentIndex,
    required this.semanticLabel,
    required this.style,
    this.activePillWidth = 24,
  });

  final int pageCount;
  final int currentIndex;
  final String semanticLabel;
  final OnboardingProgressStyle style;
  final double activePillWidth;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;

    return Semantics(
      label: semanticLabel,
      child: SizedBox(
        height: 24,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(pageCount, (index) {
            final isActive = index == currentIndex;
            return Padding(
              padding: EdgeInsetsDirectional.only(
                end: index == pageCount - 1 ? 0 : PokidokiSpacing.xs,
              ),
              child: _Dot(
                isActive: isActive,
                style: style,
                activePillWidth: activePillWidth,
                activeColor: style == OnboardingProgressStyle.circularDots
                    ? const Color(0xFF8C80FF)
                    : colors.primary,
                inactiveColor: style == OnboardingProgressStyle.circularDots
                    ? const Color(0xFF474554).withValues(alpha: 0.5)
                    : const Color(0xFF30353F),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({
    required this.isActive,
    required this.style,
    required this.activePillWidth,
    required this.activeColor,
    required this.inactiveColor,
  });

  final bool isActive;
  final OnboardingProgressStyle style;
  final double activePillWidth;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    // Page 1: 12px inactive, 15px active (scale-125).
    // Pages 2–3: 8px inactive circles, active pill height 8.
    final double width;
    final double height;

    if (style == OnboardingProgressStyle.circularDots) {
      width = isActive ? 15 : 12;
      height = isActive ? 15 : 12;
    } else if (isActive) {
      width = activePillWidth;
      height = 8;
    } else {
      width = 8;
      height = 8;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isActive ? activeColor : inactiveColor,
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}
