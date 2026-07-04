import 'package:flutter/material.dart';

/// Semantic color tokens for Pokidoki light and dark themes.
@immutable
class PokidokiColors extends ThemeExtension<PokidokiColors> {
  const PokidokiColors({
    required this.background,
    required this.surface,
    required this.surfaceElevated,
    required this.surfaceSecondary,
    required this.primary,
    required this.primaryPressed,
    required this.secure,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.border,
    required this.error,
    required this.warning,
    required this.information,
    required this.onPrimary,
    required this.onSecure,
    required this.overlay,
  });

  final Color background;
  final Color surface;
  final Color surfaceElevated;
  final Color surfaceSecondary;
  final Color primary;
  final Color primaryPressed;
  final Color secure;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color border;
  final Color error;
  final Color warning;
  final Color information;
  final Color onPrimary;
  final Color onSecure;
  final Color overlay;

  static const PokidokiColors dark = PokidokiColors(
    background: Color(0xFF090B10),
    surface: Color(0xFF12151C),
    surfaceElevated: Color(0xFF191D26),
    surfaceSecondary: Color(0xFF202530),
    primary: Color(0xFF7C6CFF),
    primaryPressed: Color(0xFF6858E8),
    secure: Color(0xFF32D6A0),
    textPrimary: Color(0xFFF7F7FA),
    textSecondary: Color(0xFFA7ACB8),
    textTertiary: Color(0xFF858B98),
    border: Color(0xFF292E39),
    error: Color(0xFFFF5D6C),
    warning: Color(0xFFF5B942),
    information: Color(0xFF62A8FF),
    onPrimary: Color(0xFFF7F7FA),
    onSecure: Color(0xFF090B10),
    overlay: Color(0x99090B10),
  );

  static const PokidokiColors light = PokidokiColors(
    background: Color(0xFFF7F7FA),
    surface: Color(0xFFFFFFFF),
    surfaceElevated: Color(0xFFF0F1F5),
    surfaceSecondary: Color(0xFFE8EAF0),
    primary: Color(0xFF6554E8),
    primaryPressed: Color(0xFF5444D0),
    secure: Color(0xFF148A69),
    textPrimary: Color(0xFF161820),
    textSecondary: Color(0xFF656A76),
    textTertiary: Color(0xFF858B98),
    border: Color(0xFFDFE1E7),
    error: Color(0xFFD64555),
    warning: Color(0xFFB8860B),
    information: Color(0xFF2F7FD1),
    onPrimary: Color(0xFFFFFFFF),
    onSecure: Color(0xFFFFFFFF),
    overlay: Color(0x66161820),
  );

  @override
  PokidokiColors copyWith({
    Color? background,
    Color? surface,
    Color? surfaceElevated,
    Color? surfaceSecondary,
    Color? primary,
    Color? primaryPressed,
    Color? secure,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? border,
    Color? error,
    Color? warning,
    Color? information,
    Color? onPrimary,
    Color? onSecure,
    Color? overlay,
  }) {
    return PokidokiColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      surfaceSecondary: surfaceSecondary ?? this.surfaceSecondary,
      primary: primary ?? this.primary,
      primaryPressed: primaryPressed ?? this.primaryPressed,
      secure: secure ?? this.secure,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      border: border ?? this.border,
      error: error ?? this.error,
      warning: warning ?? this.warning,
      information: information ?? this.information,
      onPrimary: onPrimary ?? this.onPrimary,
      onSecure: onSecure ?? this.onSecure,
      overlay: overlay ?? this.overlay,
    );
  }

  @override
  PokidokiColors lerp(ThemeExtension<PokidokiColors>? other, double t) {
    if (other is! PokidokiColors) {
      return this;
    }
    return PokidokiColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      surfaceSecondary: Color.lerp(
        surfaceSecondary,
        other.surfaceSecondary,
        t,
      )!,
      primary: Color.lerp(primary, other.primary, t)!,
      primaryPressed: Color.lerp(primaryPressed, other.primaryPressed, t)!,
      secure: Color.lerp(secure, other.secure, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      border: Color.lerp(border, other.border, t)!,
      error: Color.lerp(error, other.error, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      information: Color.lerp(information, other.information, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      onSecure: Color.lerp(onSecure, other.onSecure, t)!,
      overlay: Color.lerp(overlay, other.overlay, t)!,
    );
  }
}

extension PokidokiColorsX on BuildContext {
  PokidokiColors get pokidokiColors =>
      Theme.of(this).extension<PokidokiColors>() ?? PokidokiColors.dark;
}
