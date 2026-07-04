import 'package:flutter/material.dart';

import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';

class MainBottomNav extends StatelessWidget {
  const MainBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;

    final items = [
      (
        Icons.chat_bubble_rounded,
        Icons.chat_bubble_outline_rounded,
        l10n.navChats,
      ),
      (Icons.contacts_rounded, Icons.contacts_outlined, l10n.navContacts),
      (Icons.settings_rounded, Icons.settings_outlined, l10n.navSettings),
    ];

    final compactLabels = MediaQuery.sizeOf(context).width < 360;

    return Material(
      color: colors.surface,
      child: SafeArea(
        top: false,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: colors.border)),
          ),
          child: SizedBox(
            height: 64,
            child: Row(
              children: List<Widget>.generate(items.length, (index) {
                final selected = index == currentIndex;
                final item = items[index];
                final color = selected ? colors.primary : colors.textTertiary;
                return Expanded(
                  child: LayoutBuilder(
                    builder: (context, tabConstraints) {
                      return Semantics(
                        button: true,
                        selected: selected,
                        label: item.$3,
                        child: InkWell(
                          onTap: () => onTap(index),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                selected ? item.$1 : item.$2,
                                color: color,
                                size: 24,
                              ),
                              if (!compactLabels) ...[
                                const SizedBox(height: PokidokiSpacing.xxs),
                                SizedBox(
                                  width: tabConstraints.maxWidth,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: PokidokiSpacing.xxs,
                                      ),
                                      child: Text(
                                        item.$3,
                                        style: typography.caption.copyWith(
                                          color: color,
                                          fontWeight: selected
                                              ? FontWeight.w600
                                              : FontWeight.w500,
                                          fontSize: 11,
                                        ),
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
