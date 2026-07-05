import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pokidoki/core/constants/app_constants.dart';
import 'package:pokidoki/design_system/themes/pokidoki_theme.dart';
import 'package:pokidoki/features/onboarding/presentation/screens/onboarding_flow_screen.dart';
import 'package:pokidoki/features/splash/presentation/screens/splash_screen.dart';
import 'package:pokidoki/features/welcome/presentation/screens/welcome_screen.dart';
import 'package:pokidoki/l10n/app_localizations.dart';

import '../helpers/test_overrides.dart';

const _viewport = Size(390, 844);
const _outputDir = 'artifacts/ui_comparisons/batch_01';

Future<void> _capture(WidgetTester tester, String filename) async {
  final boundary = tester.renderObject<RenderRepaintBoundary>(
    find.byKey(const ValueKey('visual-capture')),
  );

  // toImage uses real async and must run outside fake-async.
  await tester.runAsync(() async {
    final image = await boundary.toImage(pixelRatio: 1);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    expect(bytes, isNotNull);

    final directory = Directory(_outputDir);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
    final file = File('$_outputDir/$filename');
    await file.writeAsBytes(bytes!.buffer.asUint8List());
    expect(file.existsSync(), isTrue);
  });
}

Future<void> _pumpScreen(
  WidgetTester tester,
  Widget child, {
  List<String> precacheAssets = const [],
}) async {
  tester.view.physicalSize = _viewport;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    ProviderScope(
      overrides: pokidokiBootstrapTestOverrides,
      child: MaterialApp(
        theme: PokidokiTheme.dark(),
        darkTheme: PokidokiTheme.dark(),
        themeMode: ThemeMode.dark,
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MediaQuery(
          data: const MediaQueryData(size: _viewport),
          child: RepaintBoundary(
            key: const ValueKey('visual-capture'),
            child: SizedBox(
              width: _viewport.width,
              height: _viewport.height,
              child: child,
            ),
          ),
        ),
      ),
    ),
  );

  if (precacheAssets.isNotEmpty) {
    final context = tester.element(find.byType(MaterialApp));
    await tester.runAsync(() async {
      for (final asset in precacheAssets) {
        await precacheImage(AssetImage(asset), context);
      }
    });
    await tester.pumpAndSettle();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('capture splash_actual.png', (tester) async {
    await _pumpScreen(tester, const SplashScreen());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await _capture(tester, 'splash_actual.png');
    await tester.pump(AppConstants.splashMinDuration);
    await tester.pump(const Duration(milliseconds: 300));
  });

  testWidgets('capture onboarding_1_actual.png', (tester) async {
    await _pumpScreen(
      tester,
      const OnboardingFlowScreen(),
      precacheAssets: const ['assets/illustrations/onboarding_privacy.jpg'],
    );
    await tester.pumpAndSettle();
    await _capture(tester, 'onboarding_1_actual.png');
  });

  testWidgets('capture onboarding_2_actual.png', (tester) async {
    await _pumpScreen(
      tester,
      const OnboardingFlowScreen(initialPage: 1),
      precacheAssets: const [
        'assets/illustrations/onboarding_verification.jpg',
      ],
    );
    await tester.pumpAndSettle();
    await _capture(tester, 'onboarding_2_actual.png');
  });

  testWidgets('capture onboarding_3_actual.png', (tester) async {
    await _pumpScreen(
      tester,
      const OnboardingFlowScreen(initialPage: 2),
      precacheAssets: const ['assets/illustrations/onboarding_app_lock.jpg'],
    );
    await tester.pumpAndSettle();
    await _capture(tester, 'onboarding_3_actual.png');
  });

  testWidgets('capture welcome_actual.png', (tester) async {
    tester.view.physicalSize = _viewport;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final router = GoRouter(
      initialLocation: '/welcome',
      routes: [
        GoRoute(
          path: '/welcome',
          builder: (context, state) => const WelcomeScreen(),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          theme: PokidokiTheme.dark(),
          themeMode: ThemeMode.dark,
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
          builder: (context, child) {
            return MediaQuery(
              data: const MediaQueryData(size: _viewport),
              child: RepaintBoundary(
                key: const ValueKey('visual-capture'),
                child: SizedBox(
                  width: _viewport.width,
                  height: _viewport.height,
                  child: child,
                ),
              ),
            );
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
    await _capture(tester, 'welcome_actual.png');
  });
}
