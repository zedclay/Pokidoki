import 'package:flutter/material.dart';

import '../../colors/pokidoki_colors.dart';
import '../../radii/pokidoki_radii.dart';
import '../../spacing/pokidoki_spacing.dart';
import '../../typography/pokidoki_typography.dart';

class PokidokiCard extends StatelessWidget {
  const PokidokiCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(PokidokiSpacing.md),
    this.color,
    this.borderColor,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color ?? colors.surface,
        borderRadius: PokidokiRadii.borderXl,
        border: Border.all(color: borderColor ?? colors.border),
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}

class PokidokiInfoCard extends StatelessWidget {
  const PokidokiInfoCard({
    super.key,
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    return PokidokiCard(
      borderColor: colors.information.withValues(alpha: 0.4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: typography.cardTitle),
          const SizedBox(height: PokidokiSpacing.xs),
          Text(message, style: typography.supportingBody),
        ],
      ),
    );
  }
}

class PokidokiWarningCard extends StatelessWidget {
  const PokidokiWarningCard({
    super.key,
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    return PokidokiCard(
      borderColor: colors.warning.withValues(alpha: 0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: typography.cardTitle.copyWith(color: colors.warning),
          ),
          const SizedBox(height: PokidokiSpacing.xs),
          Text(message, style: typography.supportingBody),
        ],
      ),
    );
  }
}

class PokidokiSecurityStatusCard extends StatelessWidget {
  const PokidokiSecurityStatusCard({
    super.key,
    required this.title,
    required this.message,
    this.isSecure = true,
  });

  final String title;
  final String message;
  final bool isSecure;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final accent = isSecure ? colors.secure : colors.warning;
    return PokidokiCard(
      borderColor: accent.withValues(alpha: 0.45),
      child: Row(
        children: [
          Icon(
            isSecure ? Icons.verified_user_rounded : Icons.shield_outlined,
            color: accent,
            size: 28,
          ),
          const SizedBox(width: PokidokiSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: typography.cardTitle),
                const SizedBox(height: PokidokiSpacing.xxs),
                Text(message, style: typography.supportingBody),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PokidokiSettingsGroupCard extends StatelessWidget {
  const PokidokiSettingsGroupCard({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return PokidokiCard(
      padding: EdgeInsets.zero,
      child: Column(children: children),
    );
  }
}

class PokidokiProfileIdentityCard extends StatelessWidget {
  const PokidokiProfileIdentityCard({
    super.key,
    required this.displayName,
    required this.username,
    this.subtitle,
    this.leading,
    this.isVerified = false,
  });

  final String displayName;
  final String username;
  final String? subtitle;
  final Widget? leading;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    final typography = context.pokidokiTypography;
    return PokidokiCard(
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: PokidokiSpacing.sm),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(displayName, style: typography.cardTitle),
                    ),
                    if (isVerified) ...[
                      const SizedBox(width: PokidokiSpacing.xxs),
                      Icon(
                        Icons.verified_rounded,
                        size: 18,
                        color: context.pokidokiColors.secure,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: PokidokiSpacing.xxs),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text('@$username', style: typography.supportingBody),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: PokidokiSpacing.xxs),
                  Text(subtitle!, style: typography.caption),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
