import 'package:flutter/material.dart';

import '../../../../design_system/components/cards/pokidoki_cards.dart';
import '../../../../design_system/components/layout/pokidoki_app_bar.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/components/layout/pokidoki_scrollable_page.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';

/// Temporary internal destination. Not a production screen.
class DevPlaceholderScreen extends StatelessWidget {
  const DevPlaceholderScreen({super.key, this.messageBuilder});

  final String Function(AppLocalizations l10n)? messageBuilder;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final typography = context.pokidokiTypography;
    final message = messageBuilder?.call(l10n) ?? l10n.devPlaceholderBody;

    return PokidokiScaffold(
      appBar: PokidokiAppBar(title: l10n.devPlaceholderBadge),
      body: PokidokiScrollablePage(
        children: [
          const SizedBox(height: PokidokiSpacing.xl),
          Text(l10n.devPlaceholderTitle, style: typography.screenTitle),
          const SizedBox(height: PokidokiSpacing.md),
          PokidokiInfoCard(title: l10n.devPlaceholderBadge, message: message),
        ],
      ),
    );
  }
}
