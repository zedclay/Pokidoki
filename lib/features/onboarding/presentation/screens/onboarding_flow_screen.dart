import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/providers/app_providers.dart';
import '../../../../app/routing/route_names.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../../../design_system/components/layout/pokidoki_safe_area.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../models/onboarding_page_data.dart';
import '../widgets/onboarding_page_content.dart';
import '../widgets/onboarding_progress_indicator.dart';

/// Screens 2–4 — Onboarding flow with three pages.
class OnboardingFlowScreen extends ConsumerStatefulWidget {
  const OnboardingFlowScreen({super.key, this.initialPage = 0});

  final int initialPage;

  @override
  ConsumerState<OnboardingFlowScreen> createState() =>
      _OnboardingFlowScreenState();
}

class _OnboardingFlowScreenState extends ConsumerState<OnboardingFlowScreen> {
  late final PageController _pageController;
  late int _currentPage;

  List<OnboardingPageData> get _pages => OnboardingPageData.pages;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage.clamp(0, _pages.length - 1);
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  void _onBack() {
    if (_currentPage > 0) {
      _goToPage(_currentPage - 1);
    }
  }

  void _onSkip() {
    _completeOnboarding();
  }

  void _onPrimaryAction() {
    if (_currentPage < _pages.length - 1) {
      _goToPage(_currentPage + 1);
      return;
    }
    _completeOnboarding();
  }

  void _completeOnboarding() {
    ref.read(onboardingCompletedProvider.notifier).state = true;
    context.go(AppRoutes.welcome);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final page = _pages[_currentPage];
    final progressLabel = l10n.onboardingPageSemantic(
      _currentPage + 1,
      _pages.length,
    );

    return PopScope(
      canPop: _currentPage == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _currentPage > 0) {
          _onBack();
        }
      },
      child: PokidokiScaffold(
        backgroundColor: colors.background,
        body: PokidokiSafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 64,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: PokidokiSpacing.lg,
                  ),
                  child: Row(
                    children: [
                      if (page.showBack)
                        PokidokiIconButton(
                          icon: Icons.arrow_back_rounded,
                          tooltip: l10n.semanticBack,
                          semanticLabel: l10n.semanticBack,
                          color: page.backUsesPrimaryColor
                              ? colors.primary
                              : colors.textPrimary,
                          onPressed: _onBack,
                        )
                      else if (page.showBrandHeader)
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: AlignmentDirectional.centerStart,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.shield_rounded,
                                  color: colors.primary,
                                  size: 24,
                                ),
                                const SizedBox(width: PokidokiSpacing.xs),
                                Text(
                                  l10n.appName,
                                  style: typography.sectionTitle.copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    height: 32 / 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        const SizedBox(width: PokidokiSpacing.minTouchTarget),
                      const Spacer(),
                      if (page.showSkip)
                        PokidokiButton.text(
                          label: l10n.actionSkip,
                          onPressed: _onSkip,
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (context, index) {
                    final data = _pages[index];
                    return OnboardingPageContent(
                      data: data,
                      title: data.titleBuilder(l10n),
                      body: data.bodyBuilder(l10n),
                      illustrationSemanticLabel: data
                          .illustrationSemanticBuilder(l10n),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  PokidokiSpacing.lg,
                  PokidokiSpacing.md,
                  PokidokiSpacing.lg,
                  page.progressStyle == OnboardingProgressStyle.circularDots
                      ? PokidokiSpacing.xl
                      : PokidokiSpacing.xxl,
                ),
                child: Column(
                  children: [
                    OnboardingProgressIndicator(
                      pageCount: _pages.length,
                      currentIndex: _currentPage,
                      semanticLabel: progressLabel,
                      style: page.progressStyle,
                      activePillWidth: page.activePillWidth,
                    ),
                    const SizedBox(height: PokidokiSpacing.xl),
                    PokidokiButton.primary(
                      label: page.primaryActionBuilder(l10n),
                      onPressed: _onPrimaryAction,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
