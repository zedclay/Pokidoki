import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// Progress indicator style taken from each Stitch reference.
enum OnboardingProgressStyle {
  /// Page 1: circular dots; active is slightly larger.
  circularDots,

  /// Pages 2–3: circular inactive dots with an elongated active indicator.
  activePill,
}

/// Configuration for a single onboarding page.
class OnboardingPageData {
  const OnboardingPageData({
    required this.titleBuilder,
    required this.bodyBuilder,
    required this.illustrationAsset,
    required this.illustrationSemanticBuilder,
    required this.primaryActionBuilder,
    required this.showBrandHeader,
    required this.showSkip,
    required this.showBack,
    required this.progressStyle,
    required this.activePillWidth,
    required this.titleFontSize,
    required this.titleFontWeight,
    required this.bodyMaxWidth,
    required this.illustrationSize,
    required this.backUsesPrimaryColor,
  });

  final String Function(AppLocalizations l10n) titleBuilder;
  final String Function(AppLocalizations l10n) bodyBuilder;
  final String illustrationAsset;
  final String Function(AppLocalizations l10n) illustrationSemanticBuilder;
  final String Function(AppLocalizations l10n) primaryActionBuilder;
  final bool showBrandHeader;
  final bool showSkip;
  final bool showBack;
  final OnboardingProgressStyle progressStyle;
  final double activePillWidth;
  final double titleFontSize;
  final FontWeight titleFontWeight;
  final double bodyMaxWidth;
  final double illustrationSize;
  final bool backUsesPrimaryColor;

  static List<OnboardingPageData> pages = [
    // Page 1 — circular dots, brand header, Skip.
    OnboardingPageData(
      titleBuilder: (l10n) => l10n.onboarding1Title,
      bodyBuilder: (l10n) => l10n.onboarding1Body,
      illustrationAsset: 'assets/illustrations/onboarding_privacy.jpg',
      illustrationSemanticBuilder: (l10n) =>
          l10n.onboarding1IllustrationSemantic,
      primaryActionBuilder: (l10n) => l10n.actionContinue,
      showBrandHeader: true,
      showSkip: true,
      showBack: false,
      progressStyle: OnboardingProgressStyle.circularDots,
      activePillWidth: 0,
      titleFontSize: 28,
      titleFontWeight: FontWeight.w700,
      bodyMaxWidth: 300,
      illustrationSize: 320,
      backUsesPrimaryColor: false,
    ),
    // Page 2 — inactive circles + active pill (24×8), Back + Skip.
    OnboardingPageData(
      titleBuilder: (l10n) => l10n.onboarding2Title,
      bodyBuilder: (l10n) => l10n.onboarding2Body,
      illustrationAsset: 'assets/illustrations/onboarding_verification.jpg',
      illustrationSemanticBuilder: (l10n) =>
          l10n.onboarding2IllustrationSemantic,
      primaryActionBuilder: (l10n) => l10n.actionContinueUpper,
      showBrandHeader: false,
      showSkip: true,
      showBack: true,
      progressStyle: OnboardingProgressStyle.activePill,
      activePillWidth: 24,
      titleFontSize: 28,
      titleFontWeight: FontWeight.w700,
      bodyMaxWidth: 320,
      illustrationSize: 320,
      backUsesPrimaryColor: false,
    ),
    // Page 3 — inactive circles + active pill (32×8), Back only.
    OnboardingPageData(
      titleBuilder: (l10n) => l10n.onboarding3Title,
      bodyBuilder: (l10n) => l10n.onboarding3Body,
      illustrationAsset: 'assets/illustrations/onboarding_app_lock.jpg',
      illustrationSemanticBuilder: (l10n) =>
          l10n.onboarding3IllustrationSemantic,
      primaryActionBuilder: (l10n) => l10n.actionGetStarted,
      showBrandHeader: false,
      showSkip: false,
      showBack: true,
      progressStyle: OnboardingProgressStyle.activePill,
      activePillWidth: 32,
      titleFontSize: 24,
      titleFontWeight: FontWeight.w600,
      bodyMaxWidth: 320,
      illustrationSize: 256,
      backUsesPrimaryColor: true,
    ),
  ];
}
