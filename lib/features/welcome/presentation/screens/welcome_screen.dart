import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/providers/app_providers.dart';
import '../../../../app/routing/route_names.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../../../design_system/components/layout/pokidoki_safe_area.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/radii/pokidoki_radii.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../features/splash/presentation/widgets/pokidoki_brand_mark.dart';
import '../../../../l10n/app_localizations.dart';

/// Screen 5 — Welcome Screen.
class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  String _languageLabel(AppLocalizations l10n, Locale locale) {
    return switch (locale.languageCode) {
      'ar' => l10n.languageArabic,
      'fr' => l10n.languageFrench,
      _ => l10n.languageEnglish,
    };
  }

  Future<void> _showLanguagePicker(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    final selected = await showModalBottomSheet<Locale>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(l10n.languageEnglish),
                onTap: () => Navigator.pop(context, const Locale('en')),
              ),
              ListTile(
                title: Text(l10n.languageFrench),
                onTap: () => Navigator.pop(context, const Locale('fr')),
              ),
              ListTile(
                title: Text(l10n.languageArabic),
                onTap: () => Navigator.pop(context, const Locale('ar')),
              ),
            ],
          ),
        );
      },
    );

    if (selected != null) {
      ref.read(localeOverrideProvider.notifier).state = selected;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final locale = Localizations.localeOf(context);
    final languageLabel = _languageLabel(l10n, locale);

    return PokidokiScaffold(
      backgroundColor: colors.background,
      body: PokidokiSafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compactButtons =
                constraints.maxWidth < 400 || locale.languageCode == 'fr';
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth < 360
                    ? PokidokiSpacing.md
                    : PokidokiSpacing.lg,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth,
                        ),
                        child: Semantics(
                          button: true,
                          label: l10n.languageSelectorSemantic(languageLabel),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: AlignmentDirectional.centerEnd,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(999),
                              onTap: () =>
                                  _showLanguagePicker(context, ref, l10n),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minHeight: PokidokiSpacing.minTouchTarget,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: PokidokiSpacing.md,
                                    vertical: PokidokiSpacing.xs,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.language_rounded,
                                        size: 20,
                                        color: colors.textSecondary,
                                      ),
                                      const SizedBox(
                                        width: PokidokiSpacing.xxs,
                                      ),
                                      Text(
                                        languageLabel,
                                        style: typography.supportingBody
                                            .copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: colors.textSecondary,
                                            ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      Icon(
                                        Icons.expand_more_rounded,
                                        size: 20,
                                        color: colors.textSecondary,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: PokidokiSpacing.section),
                    PokidokiLogoTile(
                      size: constraints.maxWidth < 360 ? 80 : 96,
                    ),
                    const SizedBox(height: PokidokiSpacing.md),
                    Text(
                      l10n.appName,
                      style: typography.display.copyWith(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        height: 40 / 32,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: PokidokiSpacing.xl),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: Column(
                        children: [
                          Text(
                            l10n.welcomeTitle,
                            style: typography.screenTitle.copyWith(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              height: 36 / 28,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: PokidokiSpacing.xs),
                          Text(
                            l10n.welcomeBody,
                            style: typography.body.copyWith(
                              color: colors.textSecondary,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: PokidokiSpacing.xxl),
                    _WelcomeFeatureRow(
                      icon: Icons.lock_rounded,
                      label: l10n.welcomeFeaturePrivate,
                    ),
                    const SizedBox(height: PokidokiSpacing.xs),
                    _WelcomeFeatureRow(
                      icon: Icons.verified_user_rounded,
                      label: l10n.welcomeFeatureVerification,
                    ),
                    const SizedBox(height: PokidokiSpacing.xs),
                    _WelcomeFeatureRow(
                      icon: Icons.phonelink_lock_rounded,
                      label: l10n.welcomeFeatureAppLock,
                    ),
                    const SizedBox(height: PokidokiSpacing.section),
                    PokidokiButton.primary(
                      label: l10n.actionCreateAccount,
                      letterSpacing: compactButtons ? 0.15 : 0.6,
                      onPressed: () => context.push(AppRoutes.createAccount),
                    ),
                    const SizedBox(height: PokidokiSpacing.md),
                    PokidokiButton.secondary(
                      label: l10n.actionSignIn,
                      onPressed: () => context.push(AppRoutes.signIn),
                    ),
                    const SizedBox(height: PokidokiSpacing.md),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: PokidokiSpacing.md,
                      ),
                      child: Text.rich(
                        TextSpan(
                          style: typography.caption.copyWith(
                            color: colors.textSecondary,
                            height: 1.5,
                            fontSize: 12,
                          ),
                          children: [
                            TextSpan(text: l10n.welcomeTermsPrefix),
                            TextSpan(
                              text: l10n.welcomeTermsOfService,
                              style: TextStyle(color: colors.primary),
                            ),
                            TextSpan(text: l10n.welcomeTermsMiddle),
                            TextSpan(
                              text: l10n.welcomePrivacyPolicy,
                              style: TextStyle(color: colors.primary),
                            ),
                            TextSpan(text: l10n.welcomeTermsSuffix),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: PokidokiSpacing.xs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shield_rounded,
                          size: 14,
                          color: colors.secure.withValues(alpha: 0.8),
                        ),
                        const SizedBox(width: PokidokiSpacing.xxs),
                        Flexible(
                          child: Text(
                            l10n.welcomePrivacyNote,
                            style: typography.caption.copyWith(
                              color: colors.secure.withValues(alpha: 0.8),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: PokidokiSpacing.md),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _WelcomeFeatureRow extends StatelessWidget {
  const _WelcomeFeatureRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;

    return Semantics(
      label: label,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: PokidokiRadii.borderMd,
          border: Border.all(color: colors.border.withValues(alpha: 0.35)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(PokidokiSpacing.md),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: colors.surfaceElevated,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 18, color: colors.secure),
              ),
              const SizedBox(width: PokidokiSpacing.md),
              Expanded(
                child: Text(
                  label,
                  style: typography.supportingBody.copyWith(
                    fontWeight: FontWeight.w500,
                    color: colors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
