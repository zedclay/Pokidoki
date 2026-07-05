import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pokidoki/app/providers/app_providers.dart';
import 'package:pokidoki/app/routing/route_names.dart';
import 'package:pokidoki/design_system/themes/pokidoki_theme.dart';
import 'package:pokidoki/features/app_shell/presentation/screens/main_shell_screen.dart';
import 'package:pokidoki/features/app_shell/presentation/widgets/main_bottom_nav.dart';
import 'package:pokidoki/features/chats/presentation/screens/conversations_home_screen.dart';
import 'package:pokidoki/features/contacts/presentation/screens/contacts_screen.dart';
import 'package:pokidoki/features/account_security/presentation/screens/account_recovery_screen.dart';
import 'package:pokidoki/features/account_security/presentation/screens/change_password_screen.dart';
import 'package:pokidoki/features/account_security/presentation/screens/email_management_screen.dart';
import 'package:pokidoki/features/messaging/presentation/screens/conversation_info_screen.dart';
import 'package:pokidoki/features/messaging/presentation/screens/one_to_one_chat_screen.dart';
import 'package:pokidoki/data/models/storage_usage.dart';
import 'package:pokidoki/features/settings/presentation/controllers/settings_controller.dart';
import 'package:pokidoki/features/settings/presentation/screens/account_management_screen.dart';
import 'package:pokidoki/features/settings/presentation/screens/app_lock_settings_screen.dart';
import 'package:pokidoki/features/settings/presentation/screens/appearance_screen.dart';
import 'package:pokidoki/features/settings/presentation/screens/blocked_users_screen.dart';
import 'package:pokidoki/features/settings/presentation/screens/language_screen.dart';
import 'package:pokidoki/features/settings/presentation/screens/linked_devices_screen.dart';
import 'package:pokidoki/features/settings/presentation/screens/security_activity_screen.dart';
import 'package:pokidoki/features/settings/presentation/screens/settings_screen.dart';
import 'package:pokidoki/features/settings/presentation/screens/storage_usage_screen.dart';
import 'package:pokidoki/features/messaging/data/messaging_providers.dart';
import 'package:pokidoki/features/social/presentation/controllers/social_graph_controller.dart';
import 'package:pokidoki/features/welcome/presentation/screens/welcome_screen.dart';
import 'package:pokidoki/l10n/app_localizations.dart';

import '../../helpers/test_overrides.dart';

GoRouter _settingsRouter({String initial = AppRoutes.appSettings}) {
  return GoRouter(
    initialLocation: initial,
    routes: [
      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShellScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.appChats,
                builder: (context, state) => const ConversationsHomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.appContacts,
                builder: (context, state) => const ContactsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.appSettings,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.settingsAccount,
        builder: (context, state) => const AccountManagementScreen(),
        routes: [
          GoRoute(
            path: 'change-password',
            builder: (context, state) => const ChangePasswordScreen(),
          ),
          GoRoute(
            path: 'email',
            builder: (context, state) => const EmailManagementScreen(),
          ),
          GoRoute(
            path: 'recovery',
            builder: (context, state) => const AccountRecoveryScreen(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.settingsLinkedDevices,
        builder: (context, state) => const LinkedDevicesScreen(),
      ),
      GoRoute(
        path: AppRoutes.settingsSecurityActivity,
        builder: (context, state) => const SecurityActivityScreen(),
        routes: [
          GoRoute(
            path: ':eventId',
            builder: (context, state) => SecurityEventDetailScreen(
              eventId: state.pathParameters['eventId']!,
            ),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.settingsBlockedUsers,
        builder: (context, state) => const BlockedUsersScreen(),
      ),
      GoRoute(
        path: AppRoutes.settingsAppLock,
        builder: (context, state) => const AppLockSettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.settingsAppearance,
        builder: (context, state) => const AppearanceScreen(),
      ),
      GoRoute(
        path: AppRoutes.settingsLanguage,
        builder: (context, state) => const LanguageScreen(),
      ),
      GoRoute(
        path: AppRoutes.settingsStorage,
        builder: (context, state) => const StorageUsageScreen(),
      ),
      GoRoute(
        path: '/chats/:conversationId',
        builder: (context, state) => OneToOneChatScreen(
          conversationId: state.pathParameters['conversationId']!,
        ),
        routes: [
          GoRoute(
            path: 'info',
            builder: (context, state) => ConversationInfoScreen(
              conversationId: state.pathParameters['conversationId']!,
            ),
          ),
        ],
      ),
    ],
  );
}

Future<void> _pumpRouter(
  WidgetTester tester,
  GoRouter router, {
  List<Override> overrides = const [],
  ThemeMode themeMode = ThemeMode.dark,
  Locale? locale,
}) async {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        ...pokidokiTestOverrides,
        themeModeProvider.overrideWith((ref) => themeMode),
        if (locale != null)
          localeOverrideProvider.overrideWith((ref) => locale),
        ...overrides,
      ],
      child: MaterialApp.router(
        theme: PokidokiTheme.light(),
        darkTheme: PokidokiTheme.dark(),
        themeMode: themeMode,
        locale: locale ?? const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 250));
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('settings replaces placeholder and shows profile', (
    tester,
  ) async {
    final router = _settingsRouter();
    await _pumpRouter(tester, router);

    expect(
      find.text('Settings will be implemented in a later batch.'),
      findsNothing,
    );
    expect(find.text('Settings'), findsWidgets);
    expect(find.text('Zed Clay'), findsOneWidget);
    expect(find.text('@zedclay'), findsOneWidget);
    expect(find.text('PKD-84A7-19ZX'), findsOneWidget);
    expect(find.byType(MainBottomNav), findsOneWidget);
  });

  testWidgets('account management opens batch 7 screens', (tester) async {
    var router = _settingsRouter(initial: AppRoutes.settingsAccount);
    await _pumpRouter(tester, router);

    expect(find.byType(AccountManagementScreen), findsOneWidget);
    expect(find.byType(MainBottomNav), findsNothing);
    expect(find.textContaining('you@example'), findsNothing);
    expect(find.textContaining('z••••'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Account recovery'), findsOneWidget);

    router = _settingsRouter(initial: AppRoutes.settingsAccountChangePassword);
    await _pumpRouter(tester, router);
    expect(find.byType(ChangePasswordScreen), findsOneWidget);
    expect(find.byType(MainBottomNav), findsNothing);

    router = _settingsRouter(initial: AppRoutes.settingsAccountEmail);
    await _pumpRouter(tester, router);
    expect(find.byType(EmailManagementScreen), findsOneWidget);

    router = _settingsRouter(initial: AppRoutes.settingsAccountRecovery);
    await _pumpRouter(tester, router);
    expect(find.byType(AccountRecoveryScreen), findsOneWidget);
  });

  testWidgets('linked devices remove updates security activity', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final router = _settingsRouter(initial: AppRoutes.settingsLinkedDevices);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
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
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));

    expect(find.text("Hafid's iPhone"), findsOneWidget);
    expect(find.text('MacBook Pro'), findsOneWidget);
    expect(find.text('Remove device'), findsOneWidget);

    await tester.tap(find.text('Remove device'));
    await tester.pump();
    await tester.tap(find.text('Remove device').last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('MacBook Pro'), findsNothing);
    expect(find.text('Device removed.'), findsOneWidget);

    final events = container.read(settingsProvider).events;
    expect(events.first.type.name, 'deviceRemoved');
    expect(events.first.summary, contains('MacBook Pro'));
    expect(find.textContaining(RegExp(r'\d+\.\d+\.\d+\.\d+')), findsNothing);
  });

  testWidgets('security activity list filters and detail', (tester) async {
    final router = _settingsRouter(initial: AppRoutes.settingsSecurityActivity);
    await _pumpRouter(tester, router);

    expect(find.text('New device linked'), findsWidgets);
    await tester.tap(find.text('Devices'));
    await tester.pump();
    expect(find.text('New device linked'), findsWidgets);
    expect(find.text('Pokidoki unlocked'), findsNothing);

    await tester.tap(find.text('New device linked').first);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Review linked devices'), findsOneWidget);
  });

  testWidgets('blocked users unblock enables chat composer', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await container.read(conversationsProvider.notifier).loadInitial();
    container
        .read(socialGraphProvider.notifier)
        .blockUser(
          userId: 'c-amira',
          displayName: 'Amira Mansouri',
          username: 'amira',
          pokidokiId: 'PKD-AM84-2LX7',
        );
    await container.read(conversationsProvider.notifier).loadInitial();

    final router = _settingsRouter(initial: AppRoutes.settingsBlockedUsers);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
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
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));

    expect(find.text('Amira Mansouri'), findsOneWidget);
    await tester.tap(find.text('Unblock').first);
    await tester.pump();
    await tester.tap(find.text('Unblock').last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(
      container
          .read(socialGraphProvider)
          .blockedUsers
          .any((u) => u.id == 'c-amira'),
      isFalse,
    );
    expect(
      container
          .read(conversationsProvider)
          .conversations
          .firstWhere((c) => c.id == 'conv-amira')
          .isBlocked,
      isFalse,
    );
  });

  testWidgets('app lock settings update preferences', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final router = _settingsRouter(initial: AppRoutes.settingsAppLock);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
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
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pump();

    expect(find.text('123456'), findsNothing);
    await tester.tap(find.text('Biometric unlock'));
    await tester.pump();
    expect(
      container.read(settingsProvider).securityPreferences.biometricsEnabled,
      isTrue,
    );

    final prefs = container.read(settingsProvider).securityPreferences;
    container
        .read(settingsProvider.notifier)
        .updateSecurityPreferences(
          prefs.copyWith(lockDelay: AppLockDelay.fiveMinutes),
        );
    await tester.pump();
    expect(
      container.read(settingsProvider).securityPreferences.lockDelay.name,
      'fiveMinutes',
    );
    expect(find.text('After 5 minutes'), findsOneWidget);
  });

  testWidgets('appearance and language update app', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final router = _settingsRouter(initial: AppRoutes.settingsAppearance);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: Consumer(
          builder: (context, ref, _) {
            final themeMode = ref.watch(themeModeProvider);
            final locale = ref.watch(localeOverrideProvider);
            return MaterialApp.router(
              theme: PokidokiTheme.light(),
              darkTheme: PokidokiTheme.dark(),
              themeMode: themeMode,
              locale: locale ?? const Locale('en'),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              routerConfig: router,
            );
          },
        ),
      ),
    );
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pump();

    await tester.tap(find.text('Light'));
    await tester.pump();
    expect(container.read(themeModeProvider), ThemeMode.light);

    router.go(AppRoutes.settingsLanguage);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text('العربية'));
    await tester.pump();
    expect(container.read(localeOverrideProvider)?.languageCode, 'ar');
    expect(find.text('الإعدادات'), findsWidgets);
  });

  testWidgets('storage clear cache updates totals', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final router = _settingsRouter(initial: AppRoutes.settingsStorage);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
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
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));

    final before = container.read(settingsProvider).storage;
    expect(before.cacheBytes, greaterThan(0));
    expect(find.text('248 MB'), findsOneWidget);

    await tester.ensureVisible(find.text('Clear cache').last);
    await tester.tap(find.text('Clear cache').last);
    await tester.pump();
    await tester.tap(find.text('Clear cache').last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    final after = container.read(settingsProvider).storage;
    expect(after.cacheBytes, 0);
    expect(after.totalBytes, before.totalBytes - before.cacheBytes);
    expect(after.mediaBytes, before.mediaBytes);
    expect(find.text('Cache cleared.'), findsOneWidget);
  });

  testWidgets('sign out returns to welcome', (tester) async {
    final router = _settingsRouter();
    await _pumpRouter(tester, router);

    await tester.dragUntilVisible(
      find.text('Sign out'),
      find.byType(ListView),
      const Offset(0, -300),
    );
    await tester.tap(find.text('Sign out'));
    await tester.pump();
    expect(find.text('Sign out of Pokidoki?'), findsOneWidget);
    await tester.tap(find.text('Sign out').last);
    await tester.pumpAndSettle();
    expect(find.byType(WelcomeScreen), findsOneWidget);
  });

  testWidgets('block from conversation info appears in blocked users', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final router = _settingsRouter(
      initial: AppRoutes.conversationInfoPath('conv-amira'),
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
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
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pump();

    await tester.ensureVisible(find.textContaining('Block'));
    await tester.tap(find.textContaining('Block').first);
    await tester.pump();
    await tester.tap(find.textContaining('Block').last);
    await tester.pump();

    expect(
      container
          .read(socialGraphProvider)
          .blockedUsers
          .any((u) => u.id == 'c-amira'),
      isTrue,
    );
    expect(
      container.read(messagingProvider).messagesFor('conv-amira'),
      isNotEmpty,
    );

    router.go(AppRoutes.settingsBlockedUsers);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));
    expect(find.byType(BlockedUsersScreen), findsOneWidget);
    expect(find.text('Amira Mansouri'), findsWidgets);
    expect(
      container
          .read(socialGraphProvider)
          .blockedUsers
          .any((u) => u.id == 'c-amira'),
      isTrue,
    );
  });

  testWidgets('chats and contacts tabs still work from settings shell', (
    tester,
  ) async {
    final router = _settingsRouter();
    await _pumpRouter(tester, router);

    await tester.tap(find.text('Chats'));
    await tester.pump();
    expect(find.byType(ConversationsHomeScreen), findsOneWidget);

    await tester.tap(find.text('Contacts'));
    await tester.pump();
    await tester.pumpAndSettle();
    expect(find.byType(ContactsScreen), findsOneWidget);

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    expect(find.byType(SettingsScreen), findsOneWidget);
  });
}
