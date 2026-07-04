import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/pokidoki_colors.dart';

/// Typography tokens for Latin (Inter) and Arabic (Noto Sans Arabic) scripts.
@immutable
class PokidokiTypography extends ThemeExtension<PokidokiTypography> {
  const PokidokiTypography({
    required this.display,
    required this.screenTitle,
    required this.sectionTitle,
    required this.cardTitle,
    required this.body,
    required this.supportingBody,
    required this.caption,
    required this.button,
    required this.inputLabel,
    required this.metadata,
    required this.badge,
    required this.chatMessage,
  });

  /// When `false`, uses system font fallbacks (widget tests without network).
  /// Production keeps this `true` so Inter and Noto Sans Arabic load via
  /// `google_fonts`.
  static bool useNetworkFonts = true;

  final TextStyle display;
  final TextStyle screenTitle;
  final TextStyle sectionTitle;
  final TextStyle cardTitle;
  final TextStyle body;
  final TextStyle supportingBody;
  final TextStyle caption;
  final TextStyle button;
  final TextStyle inputLabel;
  final TextStyle metadata;
  final TextStyle badge;
  final TextStyle chatMessage;

  static PokidokiTypography forLocale({
    required Locale locale,
    required PokidokiColors colors,
  }) {
    final isArabic = locale.languageCode == 'ar';
    TextStyle base({
      required double size,
      required FontWeight weight,
      required Color color,
      double height = 1.4,
      double letterSpacing = 0,
    }) {
      if (!useNetworkFonts) {
        return TextStyle(
          fontSize: size,
          fontWeight: weight,
          color: color,
          height: height,
          letterSpacing: letterSpacing,
          fontFamily: isArabic ? 'Noto Sans Arabic' : 'Inter',
          fontFamilyFallback: const <String>['Roboto', 'Arial', 'sans-serif'],
        );
      }
      if (isArabic) {
        return GoogleFonts.notoSansArabic(
          fontSize: size,
          fontWeight: weight,
          color: color,
          height: height,
          letterSpacing: letterSpacing,
        );
      }
      return GoogleFonts.inter(
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      );
    }

    return PokidokiTypography(
      display: base(
        size: 32,
        weight: FontWeight.w700,
        color: colors.textPrimary,
        height: 1.2,
      ),
      screenTitle: base(
        size: 24,
        weight: FontWeight.w600,
        color: colors.textPrimary,
        height: 1.25,
      ),
      sectionTitle: base(
        size: 18,
        weight: FontWeight.w600,
        color: colors.textPrimary,
        height: 1.3,
      ),
      cardTitle: base(
        size: 16,
        weight: FontWeight.w600,
        color: colors.textPrimary,
        height: 1.35,
      ),
      body: base(
        size: 16,
        weight: FontWeight.w400,
        color: colors.textPrimary,
        height: 1.5,
      ),
      supportingBody: base(
        size: 14,
        weight: FontWeight.w400,
        color: colors.textSecondary,
        height: 1.45,
      ),
      caption: base(
        size: 12,
        weight: FontWeight.w400,
        color: colors.textTertiary,
        height: 1.4,
      ),
      button: base(
        size: 16,
        weight: FontWeight.w600,
        color: colors.textPrimary,
        height: 1.25,
      ),
      inputLabel: base(
        size: 13,
        weight: FontWeight.w500,
        color: colors.textSecondary,
        height: 1.3,
      ),
      metadata: base(
        size: 12,
        weight: FontWeight.w500,
        color: colors.textTertiary,
        height: 1.3,
      ),
      badge: base(
        size: 11,
        weight: FontWeight.w600,
        color: colors.textPrimary,
        height: 1.2,
        letterSpacing: 0.2,
      ),
      chatMessage: base(
        size: 16,
        weight: FontWeight.w400,
        color: colors.textPrimary,
        height: 1.45,
      ),
    );
  }

  TextTheme toTextTheme() {
    return TextTheme(
      displayLarge: display,
      headlineMedium: screenTitle,
      titleLarge: sectionTitle,
      titleMedium: cardTitle,
      bodyLarge: body,
      bodyMedium: supportingBody,
      bodySmall: caption,
      labelLarge: button,
      labelMedium: inputLabel,
      labelSmall: metadata,
    );
  }

  @override
  PokidokiTypography copyWith({
    TextStyle? display,
    TextStyle? screenTitle,
    TextStyle? sectionTitle,
    TextStyle? cardTitle,
    TextStyle? body,
    TextStyle? supportingBody,
    TextStyle? caption,
    TextStyle? button,
    TextStyle? inputLabel,
    TextStyle? metadata,
    TextStyle? badge,
    TextStyle? chatMessage,
  }) {
    return PokidokiTypography(
      display: display ?? this.display,
      screenTitle: screenTitle ?? this.screenTitle,
      sectionTitle: sectionTitle ?? this.sectionTitle,
      cardTitle: cardTitle ?? this.cardTitle,
      body: body ?? this.body,
      supportingBody: supportingBody ?? this.supportingBody,
      caption: caption ?? this.caption,
      button: button ?? this.button,
      inputLabel: inputLabel ?? this.inputLabel,
      metadata: metadata ?? this.metadata,
      badge: badge ?? this.badge,
      chatMessage: chatMessage ?? this.chatMessage,
    );
  }

  @override
  PokidokiTypography lerp(ThemeExtension<PokidokiTypography>? other, double t) {
    if (other is! PokidokiTypography) {
      return this;
    }
    return PokidokiTypography(
      display: TextStyle.lerp(display, other.display, t)!,
      screenTitle: TextStyle.lerp(screenTitle, other.screenTitle, t)!,
      sectionTitle: TextStyle.lerp(sectionTitle, other.sectionTitle, t)!,
      cardTitle: TextStyle.lerp(cardTitle, other.cardTitle, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
      supportingBody: TextStyle.lerp(supportingBody, other.supportingBody, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
      button: TextStyle.lerp(button, other.button, t)!,
      inputLabel: TextStyle.lerp(inputLabel, other.inputLabel, t)!,
      metadata: TextStyle.lerp(metadata, other.metadata, t)!,
      badge: TextStyle.lerp(badge, other.badge, t)!,
      chatMessage: TextStyle.lerp(chatMessage, other.chatMessage, t)!,
    );
  }
}

extension PokidokiTypographyX on BuildContext {
  PokidokiTypography get pokidokiTypography =>
      Theme.of(this).extension<PokidokiTypography>() ??
      PokidokiTypography.forLocale(
        locale: Localizations.localeOf(this),
        colors: pokidokiColors,
      );
}
