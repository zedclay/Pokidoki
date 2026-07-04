import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/app_providers.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/radii/pokidoki_radii.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/settings_app_bar.dart';
import '../widgets/settings_section_card.dart';

class AppearanceScreen extends ConsumerWidget {
  const AppearanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final themeMode = ref.watch(themeModeProvider);

    return PokidokiScaffold(
      body: SafeArea(
        child: Column(
          children: [
            SettingsAppBar(title: l10n.settingsAppearance),
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
                              icon: Icons.dark_mode_rounded,
                              color: colors.primary,
                            ),
                            const SizedBox(width: PokidokiSpacing.sm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _statusTitle(l10n, themeMode),
                                    style: typography.cardTitle,
                                  ),
                                  Text(
                                    _statusBody(l10n, themeMode),
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
                    l10n.settingsTheme,
                    style: typography.caption.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: PokidokiSpacing.sm),
                  ThemePreviewCard(
                    title: l10n.settingsThemeDark,
                    selected: themeMode == ThemeMode.dark,
                    previewDark: true,
                    onTap: () => ref.read(themeModeProvider.notifier).state =
                        ThemeMode.dark,
                  ),
                  const SizedBox(height: PokidokiSpacing.sm),
                  ThemePreviewCard(
                    title: l10n.settingsThemeLight,
                    selected: themeMode == ThemeMode.light,
                    previewDark: false,
                    onTap: () => ref.read(themeModeProvider.notifier).state =
                        ThemeMode.light,
                  ),
                  const SizedBox(height: PokidokiSpacing.sm),
                  ThemePreviewCard(
                    title: l10n.settingsThemeSystem,
                    subtitle: l10n.settingsThemeSystemBody,
                    selected: themeMode == ThemeMode.system,
                    previewDark:
                        MediaQuery.platformBrightnessOf(context) ==
                        Brightness.dark,
                    onTap: () => ref.read(themeModeProvider.notifier).state =
                        ThemeMode.system,
                  ),
                  const SizedBox(height: PokidokiSpacing.lg),
                  SettingsSectionCard(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(PokidokiSpacing.md),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.lock_rounded,
                              color: colors.textSecondary,
                            ),
                            const SizedBox(width: PokidokiSpacing.sm),
                            Expanded(
                              child: Text(
                                l10n.settingsAppearanceSecurityNote,
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

  String _statusTitle(AppLocalizations l10n, ThemeMode mode) {
    return switch (mode) {
      ThemeMode.dark => l10n.settingsDarkActive,
      ThemeMode.light => l10n.settingsLightActive,
      ThemeMode.system => l10n.settingsSystemActive,
    };
  }

  String _statusBody(AppLocalizations l10n, ThemeMode mode) {
    return switch (mode) {
      ThemeMode.dark => l10n.settingsDarkActiveBody,
      ThemeMode.light => l10n.settingsLightActiveBody,
      ThemeMode.system => l10n.settingsThemeSystemBody,
    };
  }
}

class ThemePreviewCard extends StatelessWidget {
  const ThemePreviewCard({
    super.key,
    required this.title,
    required this.selected,
    required this.previewDark,
    required this.onTap,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final bool selected;
  final bool previewDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final previewBg = previewDark
        ? const Color(0xFF12151C)
        : const Color(0xFFFFFFFF);
    final previewText = previewDark
        ? const Color(0xFFF7F7FA)
        : const Color(0xFF161820);

    return Semantics(
      selected: selected,
      button: true,
      label: title,
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
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 40,
                  decoration: BoxDecoration(
                    color: previewBg,
                    borderRadius: PokidokiRadii.borderSm,
                    border: Border.all(color: colors.border),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Aa',
                    style: typography.caption.copyWith(color: previewText),
                  ),
                ),
                const SizedBox(width: PokidokiSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: typography.cardTitle),
                      if (subtitle != null)
                        Text(subtitle!, style: typography.supportingBody),
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
          ),
        ),
      ),
    );
  }
}
