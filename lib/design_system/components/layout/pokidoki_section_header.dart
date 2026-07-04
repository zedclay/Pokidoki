import 'package:flutter/material.dart';

import '../../spacing/pokidoki_spacing.dart';
import '../../typography/pokidoki_typography.dart';

class PokidokiSectionHeader extends StatelessWidget {
  const PokidokiSectionHeader({super.key, required this.title, this.trailing});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final typography = context.pokidokiTypography;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: PokidokiSpacing.md,
        vertical: PokidokiSpacing.sm,
      ),
      child: Row(
        children: [
          Expanded(child: Text(title, style: typography.sectionTitle)),
          ?trailing,
        ],
      ),
    );
  }
}
