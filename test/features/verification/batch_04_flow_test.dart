import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pokidoki/app/routing/route_names.dart';
import 'package:pokidoki/data/mock/mock_sample_data.dart';
import 'package:pokidoki/design_system/themes/pokidoki_theme.dart';
import 'package:pokidoki/features/app_shell/presentation/screens/main_shell_screen.dart';
import 'package:pokidoki/features/app_shell/presentation/widgets/main_bottom_nav.dart';
import 'package:pokidoki/features/chats/presentation/screens/conversations_home_screen.dart';
import 'package:pokidoki/features/chats/presentation/screens/new_conversation_screen.dart';
import 'package:pokidoki/features/contacts/presentation/screens/contacts_screen.dart';
import 'package:pokidoki/features/messaging/data/messaging_providers.dart';
import 'package:pokidoki/features/social/presentation/controllers/social_graph_controller.dart';
import 'package:pokidoki/features/verification/presentation/screens/contact_verification_screen.dart';
import 'package:pokidoki/features/verification/presentation/screens/my_qr_code_screen.dart';
import 'package:pokidoki/features/verification/presentation/screens/qr_scanner_screen.dart';
import 'package:pokidoki/features/verification/presentation/screens/safety_number_screen.dart';
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
                builder: (context, state) => const ContactsScreen(),
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
        path: AppRoutes.newConversation,
        builder: (context, state) => const NewConversationScreen(),
      ),
      GoRoute(
        path: AppRoutes.qrScanner,
        builder: (context, state) => const QrScannerScreen(),
      ),
      GoRoute(
        path: AppRoutes.myQrCode,
        builder: (context, state) => const MyQrCodeScreen(),
      ),
      GoRoute(
        path: '/security/contact-verification/:userId',
        builder: (context, state) =>
            ContactVerificationScreen(userId: state.pathParameters['userId']!),
      ),
      GoRoute(
        path: '/security/safety-number/:userId',
        builder: (context, state) =>
            SafetyNumberScreen(userId: state.pathParameters['userId']!),
      ),
    ],
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('QR scanner mock scan opens contact verification', (
    tester,
  ) async {
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

    router.go(AppRoutes.newConversation);
    await tester.pumpAndSettle();
    final l10n = AppLocalizations.of(
      tester.element(find.byType(NewConversationScreen)),
    );
    await tester.tap(find.text(l10n.usersScanQr));
    await tester.pumpAndSettle();
    expect(find.byType(QrScannerScreen), findsOneWidget);
    expect(find.byType(MainBottomNav), findsNothing);
    expect(find.textContaining('pokidoki://'), findsNothing);
    expect(find.text(l10n.qrSimulateScan), findsOneWidget);

    await tester.tap(find.bySemanticsLabel(l10n.qrFrameSemantic));
    await tester.pump(const Duration(milliseconds: 250));
    await tester.pumpAndSettle();
    expect(find.byType(ContactVerificationScreen), findsOneWidget);
  });

  testWidgets('my QR code renders identity without email', (tester) async {
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
    router.go(AppRoutes.appContacts);
    await tester.pumpAndSettle();
    router.go(AppRoutes.myQrCode);
    await tester.pumpAndSettle();

    expect(find.byType(MyQrCodeScreen), findsOneWidget);
    expect(find.text('Zed Clay'), findsOneWidget);
    expect(find.textContaining('@zedclay'), findsOneWidget);
    expect(find.textContaining('@example'), findsNothing);
    expect(find.byType(MainBottomNav), findsNothing);
  });

  testWidgets('safety number mark verified updates contacts', (tester) async {
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
    await tester.pump();
    final container = ProviderScope.containerOf(
      tester.element(find.byType(MaterialApp)),
    );
    await container.read(conversationsProvider.notifier).loadInitial();
    await tester.runAsync(
      () => container.read(socialGraphProvider.notifier).refresh(),
    );
    await tester.pump(const Duration(milliseconds: 100));
    expect(
      container
          .read(socialGraphProvider.notifier)
          .isContactVerified(MockSampleData.amiraUserId),
      isFalse,
    );

    router.go(AppRoutes.safetyNumberPath(MockSampleData.amiraUserId));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.byType(SafetyNumberScreen), findsOneWidget);
    expect(find.text('28491'), findsOneWidget);

    final l10n = AppLocalizations.of(
      tester.element(find.byType(SafetyNumberScreen)),
    );
    await tester.ensureVisible(find.text(l10n.verifyMarkAction));
    await tester.tap(find.text(l10n.verifyMarkAction));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text(l10n.verifyMarkAction).last);
    await tester.pump(const Duration(milliseconds: 350));

    expect(
      container
          .read(socialGraphProvider.notifier)
          .isContactVerified(MockSampleData.amiraUserId),
      isTrue,
    );
  });

  testWidgets('safety number stays LTR in Arabic', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: PokidokiTheme.dark(),
          locale: const Locale('ar'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SafetyNumberScreen(userId: MockSampleData.amiraUserId),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 150));
    expect(find.text('28491'), findsOneWidget);
    expect(find.text('90217'), findsOneWidget);
  });
}
