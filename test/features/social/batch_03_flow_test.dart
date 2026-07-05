import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pokidoki/app/routing/route_names.dart';
import 'package:pokidoki/design_system/themes/pokidoki_theme.dart';
import 'package:pokidoki/features/app_shell/presentation/screens/main_shell_screen.dart';
import 'package:pokidoki/features/app_shell/presentation/widgets/main_bottom_nav.dart';
import 'package:pokidoki/features/chats/presentation/screens/conversations_home_screen.dart';
import 'package:pokidoki/features/chats/presentation/screens/new_conversation_screen.dart';
import 'package:pokidoki/features/contacts/presentation/screens/contact_requests_screen.dart';
import 'package:pokidoki/features/contacts/presentation/screens/contacts_screen.dart';
import 'package:pokidoki/features/dev/presentation/screens/dev_placeholder_screen.dart';
import 'package:pokidoki/features/social/presentation/controllers/social_graph_controller.dart';
import 'package:pokidoki/features/users/presentation/screens/user_profile_preview_screen.dart';
import 'package:pokidoki/features/users/presentation/screens/user_search_screen.dart';
import 'package:pokidoki/l10n/app_localizations.dart';

import '../../helpers/test_overrides.dart';

GoRouter _router() {
  return GoRouter(
    initialLocation: AppRoutes.appChats,
    routes: [
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
                builder: (context, state) => DevPlaceholderScreen(
                  messageBuilder: (l10n) => l10n.devSettings,
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.newConversation,
        builder: (context, state) => const NewConversationScreen(),
      ),
      GoRoute(
        path: AppRoutes.userSearch,
        builder: (context, state) => const UserSearchScreen(),
      ),
      GoRoute(
        path: '/users/:userId',
        builder: (context, state) =>
            UserProfilePreviewScreen(userId: state.pathParameters['userId']!),
      ),
      GoRoute(
        path: AppRoutes.contactRequests,
        builder: (context, state) => const ContactRequestsScreen(),
      ),
      GoRoute(
        path: AppRoutes.oneToOneChatPlaceholder,
        builder: (context, state) => DevPlaceholderScreen(
          messageBuilder: (l10n) => l10n.devOneToOneChat,
        ),
      ),
    ],
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('conversations home renders rows and opens new conversation', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: pokidokiTestOverrides,
        child: MaterialApp.router(
          theme: PokidokiTheme.dark(),
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: _router(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ConversationsHomeScreen), findsOneWidget);
    expect(find.textContaining('Amira'), findsWidgets);
    expect(find.text('2'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.byType(NewConversationScreen), findsOneWidget);
    expect(find.byType(MainBottomNav), findsNothing);
  });

  testWidgets('user search opens profile and sends request', (tester) async {
    final router = _router();
    await tester.pumpWidget(
      ProviderScope(
        overrides: pokidokiTestOverrides,
        child: MaterialApp.router(
          theme: PokidokiTheme.dark(),
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    router.go(AppRoutes.userSearch);
    await tester.pumpAndSettle();
    expect(find.byType(UserSearchScreen), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'amira');
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pumpAndSettle();
    expect(find.text('Amira Rahal'), findsOneWidget);

    await tester.tap(find.text('Amira Rahal'));
    await tester.pumpAndSettle();
    expect(find.byType(UserProfilePreviewScreen), findsOneWidget);
    expect(find.textContaining('@'), findsWidgets);
    expect(find.textContaining('@example'), findsNothing);

    final l10n = AppLocalizations.of(
      tester.element(find.byType(UserProfilePreviewScreen)),
    );
    await tester.ensureVisible(find.text(l10n.usersSendRequest));
    await tester.tap(find.text(l10n.usersSendRequest));
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();
    expect(find.text(l10n.usersRequestSent), findsOneWidget);
  });

  testWidgets('contacts accept request updates list', (tester) async {
    final router = _router();
    await tester.pumpWidget(
      ProviderScope(
        overrides: pokidokiTestOverrides,
        child: MaterialApp.router(
          theme: PokidokiTheme.dark(),
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    router.go(AppRoutes.appContacts);
    await tester.pumpAndSettle();
    expect(find.byType(ContactsScreen), findsOneWidget);

    final container = ProviderScope.containerOf(
      tester.element(find.byType(MaterialApp)),
    );
    final before = container.read(socialGraphProvider).contacts.length;

    router.go(AppRoutes.contactRequests);
    await tester.pumpAndSettle();
    expect(find.byType(ContactRequestsScreen), findsOneWidget);
    expect(find.text('Yasmine A.'), findsOneWidget);

    final l10n = AppLocalizations.of(
      tester.element(find.byType(ContactRequestsScreen)),
    );
    await tester.tap(find.text(l10n.contactsAccept).first);
    await tester.pump(const Duration(milliseconds: 250));
    await tester.pumpAndSettle();

    final after = container.read(socialGraphProvider).contacts.length;
    expect(after, before + 1);
    expect(
      container
          .read(socialGraphProvider)
          .receivedRequests
          .any((r) => r.displayName == 'Yasmine A.'),
      isFalse,
    );
  });
}
