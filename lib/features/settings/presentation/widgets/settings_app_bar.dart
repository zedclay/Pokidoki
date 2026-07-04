import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../design_system/typography/pokidoki_typography.dart';

class SettingsAppBar extends StatelessWidget {
  const SettingsAppBar({super.key, required this.title, this.actions});

  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final typography = context.pokidokiTypography;
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          IconButton(
            tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          Expanded(child: Text(title, style: typography.cardTitle)),
          if (actions != null) ...actions!,
        ],
      ),
    );
  }
}
