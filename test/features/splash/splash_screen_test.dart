import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/design_system/colors/pokidoki_colors.dart';
import 'package:pokidoki/features/onboarding/presentation/screens/onboarding_flow_screen.dart';
import 'package:pokidoki/features/splash/presentation/screens/splash_screen.dart';

import '../../helpers/test_app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('renders Pokidoki branding and loading state in English', (
    tester,
  ) async {
    final l10n = await pumpLoadingSplash(tester);

    expect(find.text(l10n.appName), findsOneWidget);
    expect(find.text(l10n.splashTagline), findsOneWidget);
    expect(find.text(l10n.splashPreparing.toUpperCase()), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
    expect(find.byType(BottomNavigationBar), findsNothing);

    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.backgroundColor, PokidokiColors.dark.background);

    expect(find.textContaining('password', findRichText: true), findsNothing);
    expect(find.textContaining('PIN', findRichText: true), findsNothing);
    expect(find.textContaining('PK-'), findsNothing);

    await settleSplashBootstrap(tester);
  });

  testWidgets('renders correctly under Arabic locale and RTL', (tester) async {
    final l10n = await pumpLoadingSplash(tester, locale: const Locale('ar'));

    expect(find.text(l10n.appName), findsOneWidget);
    expect(find.text(l10n.splashTagline), findsOneWidget);
    expect(find.text(l10n.splashPreparing), findsOneWidget);

    final context = tester.element(find.byType(SplashScreen));
    expect(Directionality.of(context), TextDirection.rtl);
    expect(Localizations.localeOf(context).languageCode, 'ar');

    await settleSplashBootstrap(tester);
  });

  testWidgets('announces application name for accessibility', (tester) async {
    final l10n = await pumpLoadingSplash(tester);

    expect(find.bySemanticsLabel(RegExp(l10n.appName)), findsWidgets);

    await settleSplashBootstrap(tester);
  });

  testWidgets('transitions to onboarding after bootstrap', (tester) async {
    await pumpPokidokiApp(tester);
    expect(find.byType(SplashScreen), findsOneWidget);

    await settleSplashBootstrap(tester);
    await tester.pumpAndSettle();

    expect(find.byType(OnboardingFlowScreen), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });
}
