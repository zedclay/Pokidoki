import 'package:flutter/material.dart';

import '../../colors/pokidoki_colors.dart';
import '../../spacing/pokidoki_spacing.dart';
import '../../typography/pokidoki_typography.dart';

class PokidokiAvatar extends StatelessWidget {
  const PokidokiAvatar({
    super.key,
    required this.displayName,
    this.imageUrl,
    this.size = 48,
  });

  final String displayName;
  final String? imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final initials = _initialsFor(displayName);

    return Semantics(
      label: displayName,
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: colors.surfaceSecondary,
          shape: BoxShape.circle,
          border: Border.all(color: colors.border),
        ),
        child: imageUrl == null
            ? Text(
                initials,
                style: typography.cardTitle.copyWith(
                  fontSize: size * 0.34,
                  color: colors.textPrimary,
                ),
              )
            : ClipOval(
                child: Image.network(
                  imageUrl!,
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Text(
                    initials,
                    style: typography.cardTitle.copyWith(fontSize: size * 0.34),
                  ),
                ),
              ),
      ),
    );
  }

  String _initialsFor(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) {
      return '?';
    }
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }
}

class PokidokiVerifiedBadge extends StatelessWidget {
  const PokidokiVerifiedBadge({super.key, this.semanticLabel});

  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    return Semantics(
      label: semanticLabel ?? 'Verified',
      child: Icon(Icons.verified_rounded, color: colors.secure, size: 18),
    );
  }
}

class PokidokiContactStatusBadge extends StatelessWidget {
  const PokidokiContactStatusBadge({
    super.key,
    required this.label,
    this.tone = PokidokiBadgeTone.neutral,
  });

  final String label;
  final PokidokiBadgeTone tone;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final color = switch (tone) {
      PokidokiBadgeTone.secure => colors.secure,
      PokidokiBadgeTone.warning => colors.warning,
      PokidokiBadgeTone.danger => colors.error,
      PokidokiBadgeTone.info => colors.information,
      PokidokiBadgeTone.neutral => colors.textTertiary,
    };

    return Semantics(
      label: label,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: PokidokiSpacing.xs,
          vertical: PokidokiSpacing.xxs,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(label, style: typography.badge.copyWith(color: color)),
      ),
    );
  }
}

enum PokidokiBadgeTone { neutral, secure, warning, danger, info }

class PokidokiUserIdentityRow extends StatelessWidget {
  const PokidokiUserIdentityRow({
    super.key,
    required this.displayName,
    required this.username,
    this.isVerified = false,
    this.trailing,
    this.onTap,
  });

  final String displayName;
  final String username;
  final bool isVerified;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final typography = context.pokidokiTypography;
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: PokidokiSpacing.minTouchTarget,
        ),
        child: Row(
          children: [
            PokidokiAvatar(displayName: displayName),
            const SizedBox(width: PokidokiSpacing.sm),
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
                        const PokidokiVerifiedBadge(),
                      ],
                    ],
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text('@$username', style: typography.supportingBody),
                  ),
                ],
              ),
            ),
            ?trailing,
          ],
        ),
      ),
    );
  }
}
