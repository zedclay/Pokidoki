import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pokidoki/app/routing/route_names.dart';
import 'package:pokidoki/design_system/themes/pokidoki_theme.dart';
import 'package:pokidoki/data/mock/mock_development_credentials.dart';
import 'package:pokidoki/features/authentication/presentation/controllers/auth_flow_controller.dart';
import 'package:pokidoki/features/authentication/data/auth_providers.dart';
import 'package:pokidoki/features/users/data/user_providers.dart';
import 'package:pokidoki/features/authentication/presentation/screens/create_account_screen.dart';
import 'package:pokidoki/features/authentication/presentation/screens/email_verification_screen.dart';
import 'package:pokidoki/features/authentication/presentation/screens/profile_setup_screen.dart';
import 'package:pokidoki/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:pokidoki/features/authentication/presentation/screens/username_setup_screen.dart';
import 'package:pokidoki/features/chats/presentation/screens/conversations_home_screen.dart';
import 'package:pokidoki/features/dev/presentation/screens/dev_placeholder_screen.dart';
import 'package:pokidoki/features/security_setup/presentation/screens/app_lock_screen.dart';
import 'package:pokidoki/features/security_setup/presentation/screens/confirm_pin_screen.dart';
import 'package:pokidoki/features/security_setup/presentation/screens/create_pin_screen.dart';
import 'package:pokidoki/features/security_setup/presentation/screens/enable_biometrics_screen.dart';
import 'package:pokidoki/features/welcome/presentation/screens/welcome_screen.dart';
import 'package:pokidoki/l10n/app_localizations.dart';

import '../../helpers/test_overrides.dart';

GoRouter _batch2Router() {
  return GoRouter(
    initialLocation: AppRoutes.welcome,
    routes: [
      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.createAccount,
        builder: (context, state) => const CreateAccountScreen(),
      ),
      GoRoute(
        path: AppRoutes.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: AppRoutes.emailVerification,
        builder: (context, state) => const EmailVerificationScreen(),
      ),
      GoRoute(
        path: AppRoutes.usernameSetup,
        builder: (context, state) => const UsernameSetupScreen(),
      ),
      GoRoute(
        path: AppRoutes.profileSetup,
        builder: (context, state) => const ProfileSetupScreen(),
      ),
      GoRoute(
        path: AppRoutes.createPin,
        builder: (context, state) => const CreatePinScreen(),
      ),
      GoRoute(
        path: AppRoutes.confirmPin,
        builder: (context, state) => const ConfirmPinScreen(),
      ),
      GoRoute(
        path: AppRoutes.enableBiometrics,
        builder: (context, state) => const EnableBiometricsScreen(),
      ),
      GoRoute(
        path: AppRoutes.appLock,
        builder: (context, state) => const AppLockScreen(),
      ),
      GoRoute(
        path: AppRoutes.appChats,
        builder: (context, state) => const ConversationsHomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.accountRecovery,
        builder: (context, state) => DevPlaceholderScreen(
          messageBuilder: (l10n) => l10n.devAccountRecovery,
        ),
      ),
    ],
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('create account renders required fields', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: pokidokiTestOverrides,
        child: MaterialApp(
          theme: PokidokiTheme.dark(),
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const CreateAccountScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final l10n = AppLocalizations.of(
      tester.element(find.byType(CreateAccountScreen)),
    );

    expect(find.text(l10n.authEmailLabel), findsOneWidget);
    expect(find.text(l10n.authPasswordLabel), findsOneWidget);
    expect(find.text(l10n.authConfirmPasswordLabel), findsOneWidget);
    expect(find.text(l10n.authPasswordMinLength), findsOneWidget);
  });

  testWidgets('sign in with wrong password shows safe error', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: pokidokiTestOverrides,
        child: MaterialApp(
          theme: PokidokiTheme.dark(),
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SignInScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final l10n = AppLocalizations.of(tester.element(find.byType(SignInScreen)));

    await tester.enterText(find.byType(TextFormField).at(0), 'you@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'wrong');
    await tester.pump();
    await tester.ensureVisible(find.text(l10n.authSignInAction));
    await tester.tap(find.text(l10n.authSignInAction));
    await tester.pumpAndSettle();
    expect(find.text(l10n.authSignInError), findsOneWidget);
  });

  test('mock verification accepts development code only', () async {
    final container = ProviderContainer(overrides: pokidokiTestOverrides);
    addTearDown(container.dispose);
    final auth = container.read(authFlowProvider.notifier);
    expect(await auth.verifyEmailCode('000000'), isFalse);
    expect(
      await auth.verifyEmailCode(
        MockDevelopmentCredentials.emailVerificationCode,
      ),
      isTrue,
    );
  });

  test('verify after signup establishes session without profile', () async {
    final container = ProviderContainer(overrides: pokidokiTestOverrides);
    addTearDown(container.dispose);
    final auth = container.read(authFlowProvider.notifier);
    await auth.createAccount(
      email: 'you@example.com',
      password: 'Password1234!',
    );
    expect(
      await auth.verifyEmailCode(
        MockDevelopmentCredentials.emailVerificationCode,
      ),
      isTrue,
    );
    expect(container.read(authSessionManagerProvider).hasAccessToken, isTrue);
    expect(
      container.read(currentProfileProvider).status,
      ProfileCompletionStatus.missing,
    );
  });

  test('app lock accepts configured PIN and rejects others', () async {
    final container = ProviderContainer(overrides: pokidokiTestOverrides);
    addTearDown(container.dispose);
    final auth = container.read(authFlowProvider.notifier);
    auth.setPendingPin('654321');
    expect(await auth.confirmPinMatches('654321'), isTrue);
    expect(auth.unlockWithPin('654321'), isTrue);
    auth.clearSensitiveFlow();
    expect(auth.unlockWithPin('654321'), isTrue);
    expect(auth.unlockWithPin('000000'), isFalse);
    expect(
      auth.unlockWithPin(MockDevelopmentCredentials.appPinFallback),
      isFalse,
    );
  });

  testWidgets('full setup flow reaches conversations placeholder', (
    tester,
  ) async {
    final router = _batch2Router();
    await tester.pumpWidget(
      ProviderScope(
        overrides: pokidokiTestOverrides,
        child: MaterialApp.router(
          theme: PokidokiTheme.dark(),
          themeMode: ThemeMode.dark,
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(WelcomeScreen), findsOneWidget);

    final container = ProviderScope.containerOf(
      tester.element(find.byType(MaterialApp)),
    );
    final auth = container.read(authFlowProvider.notifier);

    final createFuture = auth.createAccount(
      email: 'you@example.com',
      password: 'Password1234!',
    );
    await tester.pump(const Duration(milliseconds: 600));
    expect(await createFuture, isTrue);

    final verifyFuture = auth.verifyEmailCode('123456');
    await tester.pump(const Duration(milliseconds: 1200));
    expect(await verifyFuture, isTrue);

    auth
      ..setUsername('zedclay')
      ..setDisplayName('Zed Clay')
      ..setPendingPin('654321');
    expect(await auth.confirmPinMatches('654321'), isTrue);
    auth.setBiometricsEnabled(true);

    router.go(AppRoutes.appLock);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(AppLockScreen), findsOneWidget);
    expect(auth.unlockWithPin('654321'), isTrue);

    router.go(AppRoutes.appChats);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(ConversationsHomeScreen), findsOneWidget);
    expect(find.textContaining('Amira'), findsWidgets);
  });
}
