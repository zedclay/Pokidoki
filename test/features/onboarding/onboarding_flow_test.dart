import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pokidoki/design_system/themes/pokidoki_theme.dart';
import 'package:pokidoki/features/onboarding/presentation/screens/onboarding_flow_screen.dart';
import 'package:pokidoki/features/onboarding/presentation/widgets/onboarding_progress_indicator.dart';
import 'package:pokidoki/features/welcome/presentation/screens/welcome_screen.dart';
import 'package:pokidoki/l10n/app_localizations.dart';

Future<AppLocalizations> _pumpOnboarding(
  WidgetTester tester, {
  Locale locale = const Locale('en'),
}) async {
  late AppLocalizations l10n;
  final router = GoRouter(
    initialLocation: '/onboarding',
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingFlowScreen(),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
    ],
  );

  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp.router(
        locale: locale,
        theme: PokidokiTheme.light(locale: locale),
        darkTheme: PokidokiTheme.dark(locale: locale),
        themeMode: ThemeMode.dark,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
        builder: (context, child) {
          l10n = AppLocalizations.of(context);
          return child!;
        },
      ),
    ),
  );
  await tester.pumpAndSettle();
  return l10n;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('shows three pages and advances with Continue', (tester) async {
    final l10n = await _pumpOnboarding(tester);

    expect(find.text(l10n.onboarding1Title), findsOneWidget);
    expect(find.byType(OnboardingProgressIndicator), findsOneWidget);

    await tester.tap(find.text(l10n.actionContinue));
    await tester.pumpAndSettle();
    expect(find.text(l10n.onboarding2Title), findsOneWidget);

    await tester.tap(find.text(l10n.actionContinueUpper));
    await tester.pumpAndSettle();
    expect(find.text(l10n.onboarding3Title), findsOneWidget);

    await tester.tap(find.text(l10n.actionGetStarted));
    await tester.pumpAndSettle();
    expect(find.byType(WelcomeScreen), findsOneWidget);
  });

  testWidgets('back returns to the previous page', (tester) async {
    final l10n = await _pumpOnboarding(tester);

    await tester.tap(find.text(l10n.actionContinue));
    await tester.pumpAndSettle();
    expect(find.text(l10n.onboarding2Title), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back_rounded));
    await tester.pumpAndSettle();
    expect(find.text(l10n.onboarding1Title), findsOneWidget);
  });

  testWidgets('skip moves to welcome', (tester) async {
    final l10n = await _pumpOnboarding(tester);

    await tester.tap(find.text(l10n.actionSkip));
    await tester.pumpAndSettle();
    expect(find.byType(WelcomeScreen), findsOneWidget);
  });

  testWidgets('renders Arabic RTL without exceptions', (tester) async {
    final l10n = await _pumpOnboarding(tester, locale: const Locale('ar'));

    expect(find.text(l10n.onboarding1Title), findsOneWidget);
    final context = tester.element(find.byType(OnboardingFlowScreen));
    expect(Directionality.of(context), TextDirection.rtl);
  });

  testWidgets('French labels render without overflow at normal scale', (
    tester,
  ) async {
    final l10n = await _pumpOnboarding(tester, locale: const Locale('fr'));

    expect(find.text(l10n.onboarding1Title), findsOneWidget);
    expect(find.text(l10n.actionContinue), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
