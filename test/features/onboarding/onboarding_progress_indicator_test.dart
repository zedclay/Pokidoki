import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/design_system/themes/pokidoki_theme.dart';
import 'package:pokidoki/features/onboarding/presentation/models/onboarding_page_data.dart';
import 'package:pokidoki/features/onboarding/presentation/widgets/onboarding_progress_indicator.dart';
import 'package:pokidoki/l10n/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> pumpIndicator(
    WidgetTester tester, {
    required OnboardingProgressStyle style,
    required int currentIndex,
    double activePillWidth = 24,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: PokidokiTheme.dark(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Center(
            child: OnboardingProgressIndicator(
              pageCount: 3,
              currentIndex: currentIndex,
              semanticLabel: 'progress',
              style: style,
              activePillWidth: activePillWidth,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('page 1 uses circular dots with larger active state', (
    tester,
  ) async {
    await pumpIndicator(
      tester,
      style: OnboardingProgressStyle.circularDots,
      currentIndex: 0,
    );

    final dots = find.byType(AnimatedContainer);
    expect(dots, findsNWidgets(3));
    expect(tester.getSize(dots.at(0)), const Size(15, 15));
    expect(tester.getSize(dots.at(1)), const Size(12, 12));
    expect(tester.getSize(dots.at(2)), const Size(12, 12));
  });

  testWidgets('page 2 uses circular inactive dots and a 24px active pill', (
    tester,
  ) async {
    await pumpIndicator(
      tester,
      style: OnboardingProgressStyle.activePill,
      currentIndex: 1,
      activePillWidth: 24,
    );

    final dots = find.byType(AnimatedContainer);
    expect(tester.getSize(dots.at(0)), const Size(8, 8));
    expect(tester.getSize(dots.at(1)), const Size(24, 8));
    expect(tester.getSize(dots.at(2)), const Size(8, 8));
  });

  testWidgets('page 3 uses circular inactive dots and a 32px active pill', (
    tester,
  ) async {
    await pumpIndicator(
      tester,
      style: OnboardingProgressStyle.activePill,
      currentIndex: 2,
      activePillWidth: 32,
    );

    final dots = find.byType(AnimatedContainer);
    expect(tester.getSize(dots.at(0)), const Size(8, 8));
    expect(tester.getSize(dots.at(1)), const Size(8, 8));
    expect(tester.getSize(dots.at(2)), const Size(32, 8));
  });
}
