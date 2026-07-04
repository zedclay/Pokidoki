import 'package:flutter/material.dart';

import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/radii/pokidoki_radii.dart';

/// Pokidoki shield brand mark used on splash and welcome screens.
///
/// Temporary vector implementation until an official logo asset is provided.
class PokidokiBrandMark extends StatelessWidget {
  const PokidokiBrandMark({
    super.key,
    this.size = 128,
    this.iconSize,
    this.showGlow = true,
    this.variant = PokidokiBrandMarkVariant.shield,
  });

  final double size;
  final double? iconSize;
  final bool showGlow;
  final PokidokiBrandMarkVariant variant;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final resolvedIconSize = iconSize ?? size * 0.62;

    return Semantics(
      excludeSemantics: true,
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (showGlow)
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: colors.primary.withValues(alpha: 0.15),
                      blurRadius: 60,
                      spreadRadius: 12,
                    ),
                  ],
                ),
              ),
            Icon(
              variant == PokidokiBrandMarkVariant.shieldLock
                  ? Icons.shield_rounded
                  : Icons.shield_rounded,
              size: resolvedIconSize,
              color: colors.primary,
            ),
          ],
        ),
      ),
    );
  }
}

/// Compact logo tile used on the welcome screen (96×96, 24px radius).
class PokidokiLogoTile extends StatelessWidget {
  const PokidokiLogoTile({super.key, this.size = 96});

  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;

    return Semantics(
      excludeSemantics: true,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(PokidokiRadii.modal),
          border: Border.all(color: colors.border.withValues(alpha: 0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: colors.primary.withValues(alpha: 0.15),
              blurRadius: 80,
              spreadRadius: 8,
            ),
          ],
        ),
        // Material Symbols "shield_lock" is approximated with a filled shield.
        child: Icon(
          Icons.shield_rounded,
          size: size * 0.5,
          color: colors.primary,
        ),
      ),
    );
  }
}

enum PokidokiBrandMarkVariant { shield, shieldLock }
