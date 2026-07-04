import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/localization/locale_controller.dart';
import '../../../../app/providers/app_providers.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/radii/pokidoki_radii.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/settings_app_bar.dart';
import '../widgets/settings_section_card.dart';

class LanguageScreen extends ConsumerWidget {
  const LanguageScreen({super.key});

  static const _options = <_LanguageOption>[
    _LanguageOption(
      code: 'en',
      nativeName: 'English',
      englishName: 'English',
      directionLabelKey: 'ltr',
      previewTitle: 'Settings',
      previewSubtitle: 'Privacy and security',
    ),
    _LanguageOption(
      code: 'ar',
      nativeName: 'العربية',
      englishName: 'Arabic',
      directionLabelKey: 'rtl',
      previewTitle: 'الإعدادات',
      previewSubtitle: 'الخصوصية والأمان',
    ),
    _LanguageOption(
      code: 'fr',
      nativeName: 'Français',
      englishName: 'French',
      directionLabelKey: 'ltr',
      previewTitle: 'Paramètres',
      previewSubtitle: 'Confidentialité et sécurité',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final override = ref.watch(localeOverrideProvider);
    final activeCode = (override ?? const Locale('en')).languageCode;
    final active = _options.firstWhere(
      (option) => option.code == activeCode,
      orElse: () => _options.first,
    );

    return PokidokiScaffold(
      body: SafeArea(
        child: Column(
          children: [
            SettingsAppBar(title: l10n.settingsLanguage),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  PokidokiSpacing.lg,
                  PokidokiSpacing.sm,
                  PokidokiSpacing.lg,
                  PokidokiSpacing.xl,
                ),
                children: [
                  SettingsSectionCard(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(PokidokiSpacing.md),
                        child: Row(
                          children: [
                            SettingsIconBadge(
                              icon: Icons.language_rounded,
                              color: colors.primary,
                            ),
                            const SizedBox(width: PokidokiSpacing.sm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n.settingsLanguageActive(
                                      active.nativeName,
                                    ),
                                    style: typography.cardTitle,
                                  ),
                                  Text(
                                    l10n.settingsLanguageActiveBody(
                                      active.englishName,
                                    ),
                                    style: typography.supportingBody,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: PokidokiSpacing.lg),
                  Text(
                    l10n.settingsAppLanguage,
                    style: typography.caption.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: PokidokiSpacing.sm),
                  for (final option in _options) ...[
                    LanguageOptionRow(
                      nativeName: option.nativeName,
                      englishName: option.englishName,
                      directionLabel: option.directionLabelKey == 'rtl'
                          ? l10n.settingsRightToLeft
                          : l10n.settingsLeftToRight,
                      previewTitle: option.previewTitle,
                      previewSubtitle: option.previewSubtitle,
                      selected: activeCode == option.code,
                      onTap: () => setAppLocale(ref, Locale(option.code)),
                    ),
                    const SizedBox(height: PokidokiSpacing.sm),
                  ],
                  SettingsSectionCard(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(PokidokiSpacing.md),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              color: colors.textSecondary,
                            ),
                            const SizedBox(width: PokidokiSpacing.sm),
                            Expanded(
                              child: Text(
                                l10n.settingsLanguageMessagesNote,
                                style: typography.supportingBody,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageOption {
  const _LanguageOption({
    required this.code,
    required this.nativeName,
    required this.englishName,
    required this.directionLabelKey,
    required this.previewTitle,
    required this.previewSubtitle,
  });

  final String code;
  final String nativeName;
  final String englishName;
  final String directionLabelKey;
  final String previewTitle;
  final String previewSubtitle;
}

class LanguageOptionRow extends StatelessWidget {
  const LanguageOptionRow({
    super.key,
    required this.nativeName,
    required this.englishName,
    required this.directionLabel,
    required this.previewTitle,
    required this.previewSubtitle,
    required this.selected,
    required this.onTap,
  });

  final String nativeName;
  final String englishName;
  final String directionLabel;
  final String previewTitle;
  final String previewSubtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;

    return Semantics(
      selected: selected,
      button: true,
      label: '$nativeName, $englishName',
      child: InkWell(
        onTap: onTap,
        borderRadius: PokidokiRadii.borderXl,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: PokidokiRadii.borderXl,
            border: Border.all(
              color: selected ? colors.primary : colors.border,
              width: selected ? 2 : 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(PokidokiSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(nativeName, style: typography.cardTitle),
                          Text(
                            '$englishName · $directionLabel',
                            style: typography.supportingBody,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      selected
                          ? Icons.radio_button_checked_rounded
                          : Icons.radio_button_off_rounded,
                      color: selected ? colors.primary : colors.textTertiary,
                    ),
                  ],
                ),
                const SizedBox(height: PokidokiSpacing.sm),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors.surfaceSecondary,
                    borderRadius: PokidokiRadii.borderMd,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(PokidokiSpacing.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(previewTitle, style: typography.body),
                        Text(previewSubtitle, style: typography.caption),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
