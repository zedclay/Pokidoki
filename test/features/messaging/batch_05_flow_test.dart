import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pokidoki/app/routing/route_names.dart';
import 'package:pokidoki/design_system/themes/pokidoki_theme.dart';
import 'package:pokidoki/features/app_shell/presentation/screens/main_shell_screen.dart';
import 'package:pokidoki/features/app_shell/presentation/widgets/main_bottom_nav.dart';
import 'package:pokidoki/features/chats/presentation/screens/conversations_home_screen.dart';
import 'package:pokidoki/features/messaging/data/messaging_providers.dart';
import 'package:pokidoki/features/messaging/presentation/screens/conversation_info_screen.dart';
import 'package:pokidoki/features/messaging/presentation/screens/conversation_search_screen.dart';
import 'package:pokidoki/features/messaging/presentation/screens/disappearing_messages_screen.dart';
import 'package:pokidoki/features/messaging/presentation/screens/one_to_one_chat_screen.dart';
import 'package:pokidoki/features/messaging/presentation/screens/shared_content_screen.dart';
import 'package:pokidoki/l10n/app_localizations.dart';

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
                builder: (context, state) => const SizedBox.shrink(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.appSettings,
                builder: (context, state) => const SizedBox.shrink(),
              ),
            ],
          ),
        ],
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
          GoRoute(
            path: 'search',
            builder: (context, state) => ConversationSearchScreen(
              conversationId: state.pathParameters['conversationId']!,
            ),
          ),
          GoRoute(
            path: 'shared',
            builder: (context, state) => SharedContentScreen(
              conversationId: state.pathParameters['conversationId']!,
            ),
          ),
          GoRoute(
            path: 'disappearing-messages',
            builder: (context, state) => DisappearingMessagesScreen(
              conversationId: state.pathParameters['conversationId']!,
            ),
          ),
        ],
      ),
    ],
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('chat sends message and updates preview', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final router = _router();
    await tester.pumpWidget(
      ProviderScope(
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

    await tester.tap(find.textContaining('Amira').first);
    await tester.pumpAndSettle();
    expect(find.byType(OneToOneChatScreen), findsOneWidget);
    expect(find.byType(MainBottomNav), findsNothing);

    final l10n = AppLocalizations.of(
      tester.element(find.byType(OneToOneChatScreen)),
    );
    await tester.enterText(find.byType(TextField), 'Hello Amira');
    await tester.pump();
    await tester.tap(find.byTooltip(l10n.chatSend));
    await tester.pumpAndSettle();
    expect(find.text('Hello Amira'), findsOneWidget);

    final container = ProviderScope.containerOf(
      tester.element(find.byType(MaterialApp)),
    );
    final conversation = container
        .read(messagingProvider.notifier)
        .conversation('conv-amira');
    expect(conversation?.lastMessagePreview, 'Hello Amira');
  });

  testWidgets('conversation info opens disappearing messages', (tester) async {
    final router = _router();
    await tester.pumpWidget(
      ProviderScope(
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
    router.go(AppRoutes.conversationInfoPath('conv-amira'));
    await tester.pumpAndSettle();
    expect(find.byType(ConversationInfoScreen), findsOneWidget);

    final l10n = AppLocalizations.of(
      tester.element(find.byType(ConversationInfoScreen)),
    );
    await tester.tap(find.text(l10n.chatDisappearingMessages));
    await tester.pumpAndSettle();
    expect(find.byType(DisappearingMessagesScreen), findsOneWidget);

    await tester.tap(find.text(l10n.chatDisappearingOff));
    await tester.pumpAndSettle();
    final container = ProviderScope.containerOf(
      tester.element(find.byType(MaterialApp)),
    );
    expect(
      container
          .read(messagingProvider.notifier)
          .conversation('conv-amira')
          ?.disappearingDurationHours,
      isNull,
    );
  });

  testWidgets('conversation search finds document messages', (tester) async {
    final router = _router();
    await tester.pumpWidget(
      ProviderScope(
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
    router.go(AppRoutes.conversationSearchPath('conv-amira'));
    await tester.pumpAndSettle();
    expect(find.byType(ConversationSearchScreen), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'document');
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();
    expect(find.textContaining('document'), findsWidgets);
  });
}
