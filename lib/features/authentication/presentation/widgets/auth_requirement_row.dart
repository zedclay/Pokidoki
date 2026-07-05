import 'package:flutter/material.dart';

import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';

class AuthRequirementRow extends StatelessWidget {
  const AuthRequirementRow({
    super.key,
    required this.label,
    required this.met,
    this.failed = false,
  });

  final String label;
  final bool met;
  final bool failed;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final color = met
        ? colors.secure
        : failed
        ? colors.error
        : colors.textSecondary;

    return Semantics(
      label:
          '$label${met
              ? ', met'
              : failed
              ? ', not met'
              : ''}',
      child: Row(
        children: [
          Icon(
            met
                ? Icons.check_circle_rounded
                : failed
                ? Icons.cancel_rounded
                : Icons.circle_outlined,
            size: 20,
            color: color,
          ),
          const SizedBox(width: PokidokiSpacing.xs),
          Expanded(
            child: Text(
              label,
              style: typography.supportingBody.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
