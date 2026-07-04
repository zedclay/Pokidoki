import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/app/app.dart';
import 'package:pokidoki/app/providers/app_providers.dart';
import 'package:pokidoki/core/constants/app_constants.dart';
import 'package:pokidoki/design_system/themes/pokidoki_theme.dart';
import 'package:pokidoki/features/splash/presentation/screens/splash_screen.dart';
import 'package:pokidoki/l10n/app_localizations.dart';

Future<void> pumpPokidokiApp(
  WidgetTester tester, {
  Locale? localeOverride,
  List<Override> overrides = const [],
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        if (localeOverride != null)
          localeOverrideProvider.overrideWith((ref) => localeOverride),
        ...overrides,
      ],
      child: const PokidokiApp(),
    ),
  );
  await tester.pump();
}

/// Advances fake async time far enough to finish splash bootstrap timers.
Future<void> settleSplashBootstrap(WidgetTester tester) async {
  await tester.pump(AppConstants.splashMinDuration);
  await tester.pump(const Duration(milliseconds: 300));
}

/// Pumps splash and keeps it in the loading phase for assertions.
Future<AppLocalizations> pumpLoadingSplash(
  WidgetTester tester, {
  Locale locale = const Locale('en'),
}) async {
  late AppLocalizations l10n;

  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        locale: locale,
        theme: PokidokiTheme.light(locale: locale),
        darkTheme: PokidokiTheme.dark(locale: locale),
        themeMode: ThemeMode.dark,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) {
          l10n = AppLocalizations.of(context);
          return child!;
        },
        home: const SplashScreen(),
      ),
    ),
  );

  // Allow post-frame bootstrap start, but stay within min duration.
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
  expect(
    AppConstants.splashMinDuration,
    greaterThan(const Duration(milliseconds: 100)),
  );
  return l10n;
}
