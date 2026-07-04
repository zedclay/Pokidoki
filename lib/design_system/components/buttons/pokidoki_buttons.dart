import 'package:flutter/material.dart';

import '../../colors/pokidoki_colors.dart';
import '../../radii/pokidoki_radii.dart';
import '../../spacing/pokidoki_spacing.dart';
import '../../typography/pokidoki_typography.dart';

enum PokidokiButtonVariant { primary, secondary, text, destructive }

class PokidokiButton extends StatelessWidget {
  const PokidokiButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = PokidokiButtonVariant.primary,
    this.isLoading = false,
    this.expanded = true,
    this.icon,
    this.height = 52,
    this.letterSpacing = 0.6,
  });

  const PokidokiButton.primary({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.expanded = true,
    this.icon,
    this.height = 52,
    this.letterSpacing = 0.6,
  }) : variant = PokidokiButtonVariant.primary;

  const PokidokiButton.secondary({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.expanded = true,
    this.icon,
    this.height = 52,
    this.letterSpacing = 0.2,
  }) : variant = PokidokiButtonVariant.secondary;

  const PokidokiButton.text({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.expanded = false,
    this.icon,
    this.height = PokidokiSpacing.minTouchTarget,
    this.letterSpacing = 0,
  }) : variant = PokidokiButtonVariant.text;

  const PokidokiButton.destructive({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.expanded = true,
    this.icon,
    this.height = 52,
    this.letterSpacing = 0.6,
  }) : variant = PokidokiButtonVariant.destructive;

  final String label;
  final VoidCallback? onPressed;
  final PokidokiButtonVariant variant;
  final bool isLoading;
  final bool expanded;
  final IconData? icon;
  final double height;
  final double letterSpacing;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final enabled = onPressed != null && !isLoading;

    final (
      Color background,
      Color foreground,
      Color? border,
    ) = switch (variant) {
      PokidokiButtonVariant.primary => (colors.primary, colors.onPrimary, null),
      PokidokiButtonVariant.secondary => (
        Colors.transparent,
        colors.textPrimary,
        colors.border,
      ),
      PokidokiButtonVariant.text => (Colors.transparent, colors.primary, null),
      PokidokiButtonVariant.destructive => (
        colors.error,
        colors.onPrimary,
        null,
      ),
    };

    final child = Row(
      mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading)
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2, color: foreground),
          )
        else ...[
          if (icon != null) ...[
            Icon(icon, size: 20, color: foreground),
            const SizedBox(width: PokidokiSpacing.xs),
          ],
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: typography.button.copyWith(
                  color: foreground,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: letterSpacing,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ],
    );

    return Semantics(
      button: true,
      enabled: enabled,
      label: label,
      excludeSemantics: true,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: height < PokidokiSpacing.minTouchTarget
              ? PokidokiSpacing.minTouchTarget
              : height,
          minWidth: PokidokiSpacing.minTouchTarget,
        ),
        child: Material(
          color: background,
          borderRadius: PokidokiRadii.borderLg,
          child: InkWell(
            onTap: enabled ? onPressed : null,
            borderRadius: PokidokiRadii.borderLg,
            child: Container(
              width: expanded ? double.infinity : null,
              height: height,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width < 360
                    ? PokidokiSpacing.md
                    : PokidokiSpacing.xl,
              ),
              decoration: BoxDecoration(
                borderRadius: PokidokiRadii.borderLg,
                border: border == null
                    ? null
                    : Border.all(color: border, width: 1.5),
                boxShadow: variant == PokidokiButtonVariant.primary
                    ? [
                        BoxShadow(
                          color: colors.primary.withValues(alpha: 0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class PokidokiIconButton extends StatelessWidget {
  const PokidokiIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.semanticLabel,
    this.color,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final String? semanticLabel;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: PokidokiSpacing.minTouchTarget,
        minHeight: PokidokiSpacing.minTouchTarget,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: color ?? colors.textPrimary),
        tooltip: semanticLabel ?? tooltip,
      ),
    );
  }
}
