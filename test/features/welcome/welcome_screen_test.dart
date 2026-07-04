import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pokidoki/design_system/themes/pokidoki_theme.dart';
import 'package:pokidoki/features/authentication/presentation/screens/create_account_screen.dart';
import 'package:pokidoki/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:pokidoki/features/welcome/presentation/screens/welcome_screen.dart';
import 'package:pokidoki/l10n/app_localizations.dart';

Future<AppLocalizations> _pumpWelcome(WidgetTester tester) async {
  late AppLocalizations l10n;
  final router = GoRouter(
    initialLocation: '/welcome',
    routes: [
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/auth/create-account',
        builder: (context, state) => const CreateAccountScreen(),
      ),
      GoRoute(
        path: '/auth/sign-in',
        builder: (context, state) => const SignInScreen(),
      ),
    ],
  );

  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp.router(
        locale: const Locale('en'),
        theme: PokidokiTheme.dark(),
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

  testWidgets('renders main actions with localized labels', (tester) async {
    final l10n = await _pumpWelcome(tester);

    expect(find.text(l10n.appName), findsOneWidget);
    expect(find.text(l10n.welcomeTitle), findsOneWidget);
    expect(find.text(l10n.actionCreateAccount), findsOneWidget);
    expect(find.text(l10n.actionSignIn), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });

  testWidgets('primary action navigates to create account', (tester) async {
    final l10n = await _pumpWelcome(tester);
    final createAccount = find.bySemanticsLabel(l10n.actionCreateAccount);
    await tester.ensureVisible(createAccount);
    await tester.pumpAndSettle();
    await tester.tap(createAccount);
    await tester.pumpAndSettle();
    expect(find.byType(CreateAccountScreen), findsOneWidget);
  });

  testWidgets('sign in navigates to sign in screen', (tester) async {
    final l10n = await _pumpWelcome(tester);
    final signIn = find.text(l10n.actionSignIn);
    await tester.ensureVisible(signIn);
    await tester.pumpAndSettle();
    await tester.tap(signIn);
    await tester.pumpAndSettle();
    expect(find.byType(SignInScreen), findsOneWidget);
  });
}
