import 'package:flutter/material.dart';

import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/radii/pokidoki_radii.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';

/// Incoming-style bubble with animated dots while the peer is typing.
class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key, this.label});

  final String? label;

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;

    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surfaceElevated,
          borderRadius: PokidokiRadii.borderLg,
          border: Border.all(color: colors.border),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: PokidokiSpacing.md,
            vertical: PokidokiSpacing.sm,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _AnimatedDots(
                animation: _controller,
                color: colors.textSecondary,
              ),
              if (widget.label != null) ...[
                const SizedBox(width: PokidokiSpacing.sm),
                Text(
                  widget.label!,
                  style: typography.caption.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedDots extends StatelessWidget {
  const _AnimatedDots({required this.animation, required this.color});

  final Animation<double> animation;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(3, (index) {
          return AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              final phase = (animation.value + index * 0.2) % 1.0;
              final scale = 0.55 + (0.45 * _bounce(phase));
              return Transform.scale(scale: scale, child: child);
            },
            child: Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          );
        }),
      ),
    );
  }

  double _bounce(double t) {
    if (t < 0.5) {
      return Curves.easeOut.transform(t * 2);
    }
    return Curves.easeIn.transform(2 - t * 2);
  }
}
