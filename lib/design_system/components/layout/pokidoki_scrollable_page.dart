import 'package:flutter/material.dart';

import '../../spacing/pokidoki_spacing.dart';
import 'pokidoki_safe_area.dart';

/// Scrollable page body with standard horizontal padding.
class PokidokiScrollablePage extends StatelessWidget {
  const PokidokiScrollablePage({
    super.key,
    required this.children,
    this.padding = const EdgeInsets.all(PokidokiSpacing.md),
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
  });

  final List<Widget> children;
  final EdgeInsetsGeometry padding;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return PokidokiSafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: padding,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: crossAxisAlignment,
                children: children,
              ),
            ),
          );
        },
      ),
    );
  }
}
