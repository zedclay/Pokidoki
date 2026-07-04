import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/design_system/colors/pokidoki_colors.dart';
import 'package:pokidoki/design_system/radii/pokidoki_radii.dart';
import 'package:pokidoki/design_system/spacing/pokidoki_spacing.dart';
import 'package:pokidoki/design_system/themes/pokidoki_theme.dart';

void main() {
  group('Pokidoki design tokens', () {
    test('dark colors match approved palette', () {
      expect(PokidokiColors.dark.background, const Color(0xFF090B10));
      expect(PokidokiColors.dark.surface, const Color(0xFF12151C));
      expect(PokidokiColors.dark.surfaceElevated, const Color(0xFF191D26));
      expect(PokidokiColors.dark.surfaceSecondary, const Color(0xFF202530));
      expect(PokidokiColors.dark.primary, const Color(0xFF7C6CFF));
      expect(PokidokiColors.dark.primaryPressed, const Color(0xFF6858E8));
      expect(PokidokiColors.dark.secure, const Color(0xFF32D6A0));
      expect(PokidokiColors.dark.textPrimary, const Color(0xFFF7F7FA));
      expect(PokidokiColors.dark.textSecondary, const Color(0xFFA7ACB8));
      expect(PokidokiColors.dark.textTertiary, const Color(0xFF858B98));
      expect(PokidokiColors.dark.border, const Color(0xFF292E39));
      expect(PokidokiColors.dark.error, const Color(0xFFFF5D6C));
      expect(PokidokiColors.dark.warning, const Color(0xFFF5B942));
      expect(PokidokiColors.dark.information, const Color(0xFF62A8FF));
    });

    test('light colors match approved palette', () {
      expect(PokidokiColors.light.background, const Color(0xFFF7F7FA));
      expect(PokidokiColors.light.surface, const Color(0xFFFFFFFF));
      expect(PokidokiColors.light.surfaceElevated, const Color(0xFFF0F1F5));
      expect(PokidokiColors.light.primary, const Color(0xFF6554E8));
      expect(PokidokiColors.light.secure, const Color(0xFF148A69));
      expect(PokidokiColors.light.textPrimary, const Color(0xFF161820));
      expect(PokidokiColors.light.textSecondary, const Color(0xFF656A76));
      expect(PokidokiColors.light.border, const Color(0xFFDFE1E7));
    });

    test('spacing scale is complete', () {
      expect(PokidokiSpacing.xxs, 4);
      expect(PokidokiSpacing.xs, 8);
      expect(PokidokiSpacing.sm, 12);
      expect(PokidokiSpacing.md, 16);
      expect(PokidokiSpacing.lg, 20);
      expect(PokidokiSpacing.xl, 24);
      expect(PokidokiSpacing.xxl, 32);
      expect(PokidokiSpacing.xxxl, 40);
      expect(PokidokiSpacing.huge, 48);
      expect(PokidokiSpacing.massive, 64);
      expect(PokidokiSpacing.minTouchTarget, 48);
    });

    test('radius scale is complete', () {
      expect(PokidokiRadii.sm, 8);
      expect(PokidokiRadii.md, 12);
      expect(PokidokiRadii.lg, 14);
      expect(PokidokiRadii.xl, 18);
      expect(PokidokiRadii.chatBubble, 20);
      expect(PokidokiRadii.modal, 24);
    });

    test('themes expose Pokidoki extensions and default to dark scaffold', () {
      final dark = PokidokiTheme.dark();
      final light = PokidokiTheme.light();

      expect(dark.brightness, Brightness.dark);
      expect(light.brightness, Brightness.light);
      expect(dark.scaffoldBackgroundColor, PokidokiColors.dark.background);
      expect(light.scaffoldBackgroundColor, PokidokiColors.light.background);
      expect(dark.extension<PokidokiColors>(), isNotNull);
      expect(light.extension<PokidokiColors>(), isNotNull);
    });
  });
}
