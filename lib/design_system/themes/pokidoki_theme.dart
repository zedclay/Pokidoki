import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors/pokidoki_colors.dart';
import '../radii/pokidoki_radii.dart';
import '../typography/pokidoki_typography.dart';

/// Builds Material [ThemeData] from Pokidoki design tokens.
abstract final class PokidokiTheme {
  static ThemeData dark({Locale locale = const Locale('en')}) {
    return _build(brightness: Brightness.dark, locale: locale);
  }

  static ThemeData light({Locale locale = const Locale('en')}) {
    return _build(brightness: Brightness.light, locale: locale);
  }

  static ThemeData _build({
    required Brightness brightness,
    required Locale locale,
  }) {
    final colors = brightness == Brightness.dark
        ? PokidokiColors.dark
        : PokidokiColors.light;
    final typography = PokidokiTypography.forLocale(
      locale: locale,
      colors: colors,
    );
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: colors.primary,
      onPrimary: colors.onPrimary,
      secondary: colors.secure,
      onSecondary: colors.onSecure,
      error: colors.error,
      onError: colors.onPrimary,
      surface: colors.surface,
      onSurface: colors.textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colors.background,
      canvasColor: colors.background,
      dividerColor: colors.border,
      textTheme: typography.toTextTheme(),
      primaryTextTheme: typography.toTextTheme(),
      iconTheme: IconThemeData(color: colors.textSecondary),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        systemOverlayStyle: brightness == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        titleTextStyle: typography.screenTitle,
      ),
      cardTheme: CardThemeData(
        color: colors.surface,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: PokidokiRadii.borderXl,
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surfaceElevated,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: PokidokiRadii.borderLg,
          borderSide: BorderSide(color: colors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: PokidokiRadii.borderLg,
          borderSide: BorderSide(color: colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: PokidokiRadii.borderLg,
          borderSide: BorderSide(color: colors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: PokidokiRadii.borderLg,
          borderSide: BorderSide(color: colors.error),
        ),
        labelStyle: typography.inputLabel,
        hintStyle: typography.supportingBody.copyWith(
          color: colors.textTertiary,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colors.surfaceElevated,
        contentTextStyle: typography.body,
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: PokidokiRadii.borderMd,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(PokidokiRadii.modal),
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colors.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: PokidokiRadii.borderModal,
        ),
        titleTextStyle: typography.sectionTitle,
        contentTextStyle: typography.body,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colors.primary,
        circularTrackColor: colors.border,
      ),
      extensions: <ThemeExtension<dynamic>>[colors, typography],
    );
  }
}
