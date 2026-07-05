import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pokidoki/app/providers/app_providers.dart';
import 'package:pokidoki/app/routing/app_router.dart';
import 'package:pokidoki/app/routing/route_names.dart';
import 'package:pokidoki/app/routing/auth_route_guard.dart';
import 'package:pokidoki/app/routing/route_not_found_screen.dart';
import 'package:pokidoki/data/mock/mock_development_credentials.dart';
import 'package:pokidoki/design_system/themes/pokidoki_theme.dart';
import 'package:pokidoki/features/account_security/data/account_security_repository.dart';
import 'package:pokidoki/features/account_security/presentation/controllers/account_security_controller.dart';
import 'package:pokidoki/features/app_shell/presentation/widgets/main_bottom_nav.dart';
import 'package:pokidoki/features/authentication/presentation/controllers/auth_flow_controller.dart';
import 'package:pokidoki/features/chats/presentation/screens/conversations_home_screen.dart';
import 'package:pokidoki/features/dev/presentation/screens/dev_placeholder_screen.dart';
import 'package:pokidoki/features/settings/presentation/controllers/settings_controller.dart';
import 'package:pokidoki/features/settings/presentation/screens/account_management_screen.dart';
import 'package:pokidoki/features/settings/presentation/screens/appearance_screen.dart';
import 'package:pokidoki/features/settings/presentation/screens/language_screen.dart';
import 'package:pokidoki/features/settings/presentation/screens/settings_screen.dart';
import 'package:pokidoki/features/social/presentation/controllers/social_graph_controller.dart';
import 'package:pokidoki/features/verification/presentation/screens/qr_scanner_screen.dart';
import 'package:pokidoki/features/welcome/presentation/screens/welcome_screen.dart';
import 'package:pokidoki/l10n/app_localizations.dart';

import '../helpers/test_overrides.dart';

Future<void> _pumpRouter(
  WidgetTester tester,
  GoRouter router, {
  ProviderContainer? container,
  Locale locale = const Locale('en'),
  ThemeMode themeMode = ThemeMode.dark,
  Size viewport = const Size(390, 844),
  List<Override> overrides = const [],
}) async {
  tester.view.physicalSize = viewport;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  final app = MaterialApp.router(
    theme: PokidokiTheme.light(locale: locale),
    darkTheme: PokidokiTheme.dark(locale: locale),
    themeMode: themeMode,
    locale: locale,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    routerConfig: router,
  );

  await tester.pumpWidget(
    container != null
        ? UncontrolledProviderScope(container: container, child: app)
        : ProviderScope(overrides: overrides, child: app),
  );
  await tester.pumpAndSettle();
}

Future<void> _flushAsyncTimers(WidgetTester tester) async {
  await tester.pump(const Duration(milliseconds: 500));
}

/// Primary routes that must render without throwing (splash excluded — auto-navigates).
final _primaryRoutes = <String>[
  AppRoutes.onboarding,
  AppRoutes.welcome,
  AppRoutes.createAccount,
  AppRoutes.signIn,
  AppRoutes.emailVerification,
  AppRoutes.usernameSetup,
  AppRoutes.profileSetup,
  AppRoutes.createPin,
  AppRoutes.confirmPin,
  AppRoutes.enableBiometrics,
  AppRoutes.appLock,
  AppRoutes.appChats,
  AppRoutes.appContacts,
  AppRoutes.appSettings,
  AppRoutes.settingsAccount,
  AppRoutes.settingsLinkedDevices,
  AppRoutes.settingsSecurityActivity,
  AppRoutes.settingsBlockedUsers,
  AppRoutes.settingsAppLock,
  AppRoutes.settingsAppearance,
  AppRoutes.settingsLanguage,
  AppRoutes.settingsStorage,
  AppRoutes.settingsAccountChangePassword,
  AppRoutes.settingsAccountEmail,
  AppRoutes.settingsAccountRecovery,
  AppRoutes.newConversation,
  AppRoutes.userSearch,
  AppRoutes.contactRequests,
  AppRoutes.qrScanner,
  AppRoutes.myQrCode,
  AppRoutes.userProfilePath('c-amira'),
  AppRoutes.chatPath('conv-amira'),
  AppRoutes.conversationInfoPath('conv-amira'),
  AppRoutes.conversationSearchPath('conv-amira'),
  AppRoutes.sharedContentPath('conv-amira'),
  AppRoutes.disappearingMessagesPath('conv-amira'),
  AppRoutes.contactVerificationPath('c-amira'),
  AppRoutes.safetyNumberPath('c-amira'),
  AppRoutes.reportUserPath('u-riad'),
  AppRoutes.settingsSecurityEventPath('evt-signin-1'),
];

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('navigation audit', () {
    testWidgets('primary routes render without overflow', (tester) async {
      final container = ProviderContainer(
        overrides: pokidokiAuthenticatedAppOverrides,
      );
      addTearDown(container.dispose);
      final router = container.read(appRouterProvider);

      await _pumpRouter(tester, router, container: container);

      for (final route in _primaryRoutes) {
        container
            .read(authPresentationProvider.notifier)
            .state = isProtectedRoute(route)
            ? AuthPresentationStatus.authenticated
            : AuthPresentationStatus.unauthenticated;
        router.go(route);
        await tester.pumpAndSettle();
        await _flushAsyncTimers(tester);
        expect(tester.takeException(), isNull, reason: 'Route failed: $route');
      }
    });

    testWidgets('bottom navigation appears only on root tabs', (tester) async {
      final container = ProviderContainer(
        overrides: pokidokiAuthenticatedAppOverrides,
      );
      addTearDown(container.dispose);
      final router = container.read(appRouterProvider);

      for (final route in [
        AppRoutes.appChats,
        AppRoutes.appContacts,
        AppRoutes.appSettings,
      ]) {
        await _pumpRouter(tester, router, container: container);
        router.go(route);
        await tester.pumpAndSettle();
        expect(find.byType(MainBottomNav), findsOneWidget, reason: route);
      }

      for (final route in [
        AppRoutes.settingsAccount,
        AppRoutes.chatPath('conv-amira'),
        AppRoutes.newConversation,
      ]) {
        await _pumpRouter(tester, router, container: container);
        router.go(route);
        await tester.pumpAndSettle();
        expect(find.byType(MainBottomNav), findsNothing, reason: route);
      }
    });

    testWidgets('legacy placeholder routes redirect to real screens', (
      tester,
    ) async {
      final container = ProviderContainer(
        overrides: pokidokiAuthenticatedAppOverrides,
      );
      addTearDown(container.dispose);
      final router = container.read(appRouterProvider);

      await _pumpRouter(tester, router, container: container);
      router.go(AppRoutes.conversationsHomePlaceholder);
      await tester.pumpAndSettle();
      expect(find.byType(ConversationsHomeScreen), findsOneWidget);

      router.go(AppRoutes.accountRecovery);
      await tester.pumpAndSettle();
      expect(find.byType(DevPlaceholderScreen), findsNothing);

      router.go(AppRoutes.reportUserPlaceholder);
      await tester.pumpAndSettle();
      expect(find.byType(DevPlaceholderScreen), findsNothing);
    });

    testWidgets('unknown route shows safe not-found screen', (tester) async {
      final container = ProviderContainer(
        overrides: pokidokiAuthenticatedAppOverrides,
      );
      addTearDown(container.dispose);
      final router = container.read(appRouterProvider);

      await _pumpRouter(tester, router, container: container);
      router.go('/this-route-does-not-exist');
      await tester.pumpAndSettle();
      expect(find.byType(RouteNotFoundScreen), findsOneWidget);
    });

    testWidgets('pin recovery remains intentional dev placeholder', (
      tester,
    ) async {
      final container = ProviderContainer(
        overrides: pokidokiAuthenticatedAppOverrides,
      );
      addTearDown(container.dispose);
      final router = container.read(appRouterProvider);

      await _pumpRouter(tester, router, container: container);
      router.go(AppRoutes.pinRecovery);
      await tester.pumpAndSettle();
      expect(find.byType(DevPlaceholderScreen), findsOneWidget);
    });
  });

  group('localization matrix', () {
    for (final locale in AppLocalizations.supportedLocales) {
      testWidgets('critical screens render in ${locale.languageCode}', (
        tester,
      ) async {
        final container = ProviderContainer(
          overrides: pokidokiAuthenticatedAppOverrides,
        );
        addTearDown(container.dispose);
        final router = container.read(appRouterProvider);

        final routes = <String, Type>{
          AppRoutes.welcome: WelcomeScreen,
          AppRoutes.appChats: ConversationsHomeScreen,
          AppRoutes.appSettings: SettingsScreen,
          AppRoutes.settingsAppearance: AppearanceScreen,
          AppRoutes.settingsLanguage: LanguageScreen,
        };

        await _pumpRouter(tester, router, locale: locale, container: container);

        for (final entry in routes.entries) {
          container
              .read(authPresentationProvider.notifier)
              .state = isProtectedRoute(entry.key)
              ? AuthPresentationStatus.authenticated
              : AuthPresentationStatus.unauthenticated;
          router.go(entry.key);
          await tester.pumpAndSettle();
          await _flushAsyncTimers(tester);
          expect(find.byType(entry.value), findsOneWidget, reason: entry.key);
        }
      });
    }
  });

  group('theme matrix', () {
    for (final mode in [ThemeMode.dark, ThemeMode.light]) {
      testWidgets('welcome and settings render in $mode', (tester) async {
        final container = ProviderContainer(
          overrides: pokidokiAuthenticatedAppOverrides,
        );
        addTearDown(container.dispose);
        final router = container.read(appRouterProvider);

        await _pumpRouter(
          tester,
          router,
          themeMode: mode,
          container: container,
        );
        container.read(authPresentationProvider.notifier).state =
            AuthPresentationStatus.unauthenticated;
        router.go(AppRoutes.welcome);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);

        container.read(authPresentationProvider.notifier).state =
            AuthPresentationStatus.authenticated;
        router.go(AppRoutes.appSettings);
        await tester.pumpAndSettle();
        await _flushAsyncTimers(tester);
        expect(find.byType(SettingsScreen), findsOneWidget);
      });
    }
  });

  group('responsive layout', () {
    const viewports = [
      Size(320, 568),
      Size(360, 800),
      Size(390, 844),
      Size(430, 932),
    ];

    for (final viewport in viewports) {
      testWidgets(
        'welcome fits at ${viewport.width.toInt()}×${viewport.height.toInt()}',
        (tester) async {
          tester.view.physicalSize = viewport;
          tester.view.devicePixelRatio = 1;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);

          await tester.pumpWidget(
            ProviderScope(
              child: MaterialApp(
                theme: PokidokiTheme.dark(),
                themeMode: ThemeMode.dark,
                locale: const Locale('en'),
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                home: MediaQuery(
                  data: MediaQueryData(size: viewport),
                  child: const WelcomeScreen(),
                ),
              ),
            ),
          );
          await tester.pumpAndSettle();
          expect(find.byType(WelcomeScreen), findsOneWidget);
        },
      );
    }

    testWidgets('large text scale on settings avoids overflow', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: PokidokiTheme.dark(),
            themeMode: ThemeMode.dark,
            locale: const Locale('en'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: MediaQuery(
              data: const MediaQueryData(
                size: Size(390, 844),
              ).copyWith(textScaler: const TextScaler.linear(1.4)),
              child: const SettingsScreen(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(SettingsScreen), findsOneWidget);
    });
  });

  group('shared state integration', () {
    test('verify contact updates contacts and conversations', () async {
      final container = ProviderContainer(
        overrides: pokidokiAuthenticatedAppOverrides,
      );
      addTearDown(container.dispose);

      await container.read(socialGraphProvider.notifier).refresh();
      await container.read(conversationsProvider.notifier).loadInitial();
      await container
          .read(socialGraphProvider.notifier)
          .markVerified('c-amira');

      final graph = container.read(socialGraphProvider);
      expect(
        graph.contacts.firstWhere((c) => c.id == 'c-amira').isVerified,
        isTrue,
      );
      expect(
        container
            .read(conversationsProvider)
            .conversations
            .firstWhere((c) => c.peerId == 'c-amira')
            .isPeerVerified,
        isTrue,
      );
    });

    test('block and unblock syncs blocked users list', () {
      final container = ProviderContainer(
        overrides: pokidokiAuthenticatedAppOverrides,
      );
      addTearDown(container.dispose);
      final graph = container.read(socialGraphProvider.notifier);

      graph.blockUser(
        userId: 'c-amira',
        displayName: 'Amira Mansouri',
        username: 'amira',
        pokidokiId: 'PKD-AM84-2LX7',
      );
      expect(
        container
            .read(socialGraphProvider)
            .blockedUsers
            .any((u) => u.id == 'c-amira'),
        isTrue,
      );

      graph.unblockUser('c-amira');
      expect(
        container
            .read(socialGraphProvider)
            .blockedUsers
            .any((u) => u.id == 'c-amira'),
        isFalse,
      );
    });

    test('send message updates conversation preview', () async {
      final container = ProviderContainer(
        overrides: pokidokiAuthenticatedAppOverrides,
      );
      addTearDown(container.dispose);
      final messaging = container.read(messagingProvider.notifier);

      await messaging.sendTextMessage('conv-amira', 'Final QA ping');

      final conversation = container
          .read(conversationsProvider.notifier)
          .conversationById('conv-amira');
      expect(conversation?.lastMessagePreview, contains('Final QA ping'));
    });

    test('remove linked device adds security event', () async {
      final container = ProviderContainer(
        overrides: pokidokiAuthenticatedAppOverrides,
      );
      addTearDown(container.dispose);
      final settings = container.read(settingsProvider.notifier);
      await settings.loadDevices();
      final before = container.read(settingsProvider).devices.length;

      final removable = container
          .read(settingsProvider)
          .devices
          .firstWhere((d) => !d.isCurrentDevice);
      await settings.removeDevice(removable.id);

      expect(container.read(settingsProvider).devices.length, before - 1);
      expect(
        container
            .read(settingsProvider)
            .events
            .any((e) => e.type.name == 'deviceRemoved'),
        isTrue,
      );
    });

    test(
      'email change updates masked email in account security state',
      () async {
        MockAccountSecurityRepository.resetForTests();
        final container = ProviderContainer(
          overrides: pokidokiAuthenticatedAppOverrides,
        );
        addTearDown(container.dispose);
        final notifier = container.read(accountSecurityProvider.notifier);

        await notifier.reauthenticateForEmail(
          MockDevelopmentCredentials.accountPassword,
        );
        await notifier.submitNewEmail('new.user@example.invalid');
        await notifier.verifyEmailCode(
          MockDevelopmentCredentials.emailVerificationCode,
        );

        expect(
          container.read(accountSecurityProvider).email.maskedEmail,
          endsWith('@example.invalid'),
        );
      },
    );
  });

  group('sign out', () {
    test('sign out clears auth flow and keeps theme and locale', () async {
      final container = ProviderContainer(
        overrides: [
          ...pokidokiTestOverrides,
          localeOverrideProvider.overrideWith((ref) => const Locale('fr')),
          themeModeProvider.overrideWith((ref) => ThemeMode.light),
        ],
      );
      addTearDown(container.dispose);

      container.read(authFlowProvider.notifier)
        ..setEmail('test@example.invalid')
        ..setPendingPin('999999');
      await container.read(authFlowProvider.notifier).signOut();

      final auth = container.read(authFlowProvider);
      expect(auth.email, isEmpty);
      expect(auth.pendingPin, isEmpty);
      expect(container.read(themeModeProvider), ThemeMode.light);
      expect(container.read(localeOverrideProvider)?.languageCode, 'fr');
    });
  });

  group('debug controls', () {
    testWidgets('QR simulate scan button follows debug mode', (tester) async {
      final container = ProviderContainer(
        overrides: pokidokiAuthenticatedAppOverrides,
      );
      addTearDown(container.dispose);
      final router = container.read(appRouterProvider);

      await _pumpRouter(tester, router, container: container);
      router.go(AppRoutes.qrScanner);
      await tester.pumpAndSettle();

      final l10n = AppLocalizations.of(
        tester.element(find.byType(QrScannerScreen)),
      );
      final simulateFinder = find.text(l10n.qrSimulateScan);

      if (kDebugMode) {
        expect(simulateFinder, findsOneWidget);
      } else {
        expect(simulateFinder, findsNothing);
      }
    });
  });

  group('RTL identifiers', () {
    testWidgets('Arabic settings preserves LTR Pokidoki ID', (tester) async {
      final container = ProviderContainer(
        overrides: pokidokiAuthenticatedAppOverrides,
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            theme: PokidokiTheme.dark(locale: const Locale('ar')),
            darkTheme: PokidokiTheme.dark(locale: const Locale('ar')),
            themeMode: ThemeMode.dark,
            locale: const Locale('ar'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const AccountManagementScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('PKD-'), findsWidgets);
      expect(tester.takeException(), isNull);
    });
  });
}
