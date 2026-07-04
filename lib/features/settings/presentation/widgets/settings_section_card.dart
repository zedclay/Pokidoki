import 'package:flutter/material.dart';

import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/radii/pokidoki_radii.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';

class SettingsSectionCard extends StatelessWidget {
  const SettingsSectionCard({
    super.key,
    required this.children,
    this.title,
    this.padding = EdgeInsets.zero,
  });

  final String? title;
  final List<Widget> children;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Padding(
            padding: const EdgeInsets.only(
              left: PokidokiSpacing.xs,
              bottom: PokidokiSpacing.sm,
            ),
            child: Text(
              title!,
              style: typography.caption.copyWith(color: colors.textSecondary),
            ),
          ),
        ],
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: PokidokiRadii.borderXl,
            border: Border.all(color: colors.border),
          ),
          child: Padding(
            padding: padding,
            child: Column(
              children: [
                for (var i = 0; i < children.length; i++) ...[
                  children[i],
                  if (i < children.length - 1)
                    Divider(
                      height: 1,
                      indent: PokidokiSpacing.md,
                      endIndent: PokidokiSpacing.md,
                      color: colors.border,
                    ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SettingsIconBadge extends StatelessWidget {
  const SettingsIconBadge({
    super.key,
    required this.icon,
    this.color,
    this.backgroundColor,
  });

  final IconData icon;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: backgroundColor ?? colors.surfaceSecondary,
        borderRadius: PokidokiRadii.borderMd,
      ),
      child: Icon(icon, size: 20, color: color ?? colors.textSecondary),
    );
  }
}
