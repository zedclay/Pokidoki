import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pokidoki/app/routing/route_names.dart';
import 'package:pokidoki/data/models/account_security.dart';
import 'package:pokidoki/design_system/themes/pokidoki_theme.dart';
import 'package:pokidoki/features/account_security/data/account_security_repository.dart';
import 'package:pokidoki/features/account_security/presentation/controllers/account_security_controller.dart';
import 'package:pokidoki/features/account_security/presentation/screens/account_recovery_screen.dart';
import 'package:pokidoki/features/account_security/presentation/screens/change_password_screen.dart';
import 'package:pokidoki/features/account_security/presentation/screens/email_management_screen.dart';
import 'package:pokidoki/features/messaging/data/messaging_providers.dart';
import 'package:pokidoki/features/messaging/presentation/screens/conversation_info_screen.dart';
import 'package:pokidoki/features/safety/data/safety_reporting_repository.dart';
import 'package:pokidoki/features/safety/presentation/controllers/safety_reporting_controller.dart';
import 'package:pokidoki/features/safety/presentation/screens/report_user_screen.dart';
import 'package:pokidoki/features/settings/presentation/controllers/settings_controller.dart';
import 'package:pokidoki/features/social/presentation/controllers/social_graph_controller.dart';
import 'package:pokidoki/l10n/app_localizations.dart';

GoRouter _router({String initial = AppRoutes.settingsAccountChangePassword}) {
  return GoRouter(
    initialLocation: initial,
    routes: [
      GoRoute(
        path: AppRoutes.settingsAccountChangePassword,
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.settingsAccountEmail,
        builder: (context, state) => const EmailManagementScreen(),
      ),
      GoRoute(
        path: AppRoutes.settingsAccountRecovery,
        builder: (context, state) => const AccountRecoveryScreen(),
      ),
      GoRoute(
        path: '/report/:userId',
        builder: (context, state) =>
            ReportUserScreen(userId: state.pathParameters['userId']!),
      ),
      GoRoute(
        path: '/chats/:conversationId/info',
        builder: (context, state) => ConversationInfoScreen(
          conversationId: state.pathParameters['conversationId']!,
        ),
      ),
    ],
  );
}

Future<void> _pump(
  WidgetTester tester,
  GoRouter router, {
  required ProviderContainer container,
}) async {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

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
  await tester.pump();
}

Future<T> _awaitMock<T>(WidgetTester tester, Future<T> future) async {
  await tester.pump(const Duration(milliseconds: 500));
  return future;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    MockAccountSecurityRepository.resetForTests();
    MockSafetyReportingRepository.resetForTests();
  });

  testWidgets('change password screen renders and updates activity', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await _pump(tester, _router(), container: container);

    expect(find.text('Change Password'), findsWidgets);
    expect(find.text('Current password'), findsOneWidget);
    expect(find.text('Pokidoki!2026'), findsNothing);

    final notifier = container.read(accountSecurityProvider.notifier);
    expect(
      await _awaitMock(
        tester,
        notifier.changePassword(
          currentPassword: 'Pokidoki!2026',
          newPassword: 'weak',
        ),
      ),
      isFalse,
    );
    expect(
      await _awaitMock(
        tester,
        notifier.changePassword(
          currentPassword: 'wrong-password',
          newPassword: 'NewSecurePass!99',
        ),
      ),
      isFalse,
    );
    expect(
      await _awaitMock(
        tester,
        notifier.changePassword(
          currentPassword: 'Pokidoki!2026',
          newPassword: 'NewSecurePass!99',
        ),
      ),
      isTrue,
    );
    expect(
      container
          .read(settingsProvider)
          .events
          .any((e) => e.title == 'Password changed'),
      isTrue,
    );
    expect(container.read(settingsProvider).otherDevices, isEmpty);
  });

  testWidgets('forgot password opens account recovery', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await _pump(tester, _router(), container: container);
    await tester.tap(find.text('Forgot current password?'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(AccountRecoveryScreen), findsOneWidget);
  });

  testWidgets('email change flow updates masked email', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await _pump(
      tester,
      _router(initial: AppRoutes.settingsAccountEmail),
      container: container,
    );

    expect(find.textContaining('z••••'), findsWidgets);
    expect(find.textContaining('you@example'), findsNothing);

    final notifier = container.read(accountSecurityProvider.notifier);
    expect(
      await _awaitMock(
        tester,
        notifier.reauthenticateForEmail('Pokidoki!2026'),
      ),
      isTrue,
    );
    expect(
      await _awaitMock(tester, notifier.submitNewEmail('taken@example.com')),
      isFalse,
    );
    expect(
      await _awaitMock(tester, notifier.submitNewEmail('new.user@example.com')),
      isTrue,
    );
    expect(
      await _awaitMock(tester, notifier.verifyEmailCode('000000')),
      isFalse,
    );
    expect(
      await _awaitMock(tester, notifier.verifyEmailCode('123456')),
      isTrue,
    );

    expect(
      container.read(accountSecurityProvider).email.maskedEmail,
      'n••••••@example.com',
    );
    expect(
      container
          .read(settingsProvider)
          .events
          .any((e) => e.title == 'Email changed'),
      isTrue,
    );
  });

  testWidgets('account recovery completes with valid code', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await _pump(
      tester,
      _router(initial: AppRoutes.settingsAccountRecovery),
      container: container,
    );

    expect(find.text('Account Recovery'), findsWidgets);
    final notifier = container.read(accountSecurityProvider.notifier);
    expect(await _awaitMock(tester, notifier.startRecovery()), isTrue);
    expect(
      await _awaitMock(tester, notifier.verifyRecoveryCode('000000')),
      isFalse,
    );
    expect(
      await _awaitMock(tester, notifier.verifyRecoveryCode('654321')),
      isTrue,
    );
    expect(
      await _awaitMock(tester, notifier.completeRecovery('weak')),
      isFalse,
    );
    expect(
      await _awaitMock(tester, notifier.completeRecovery('RecoveredPass!26')),
      isTrue,
    );

    expect(
      container.read(accountSecurityProvider).recoveryStep,
      RecoveryStep.completed,
    );
    expect(
      container
          .read(settingsProvider)
          .events
          .any((e) => e.title == 'Account recovery completed'),
      isTrue,
    );
    expect(container.read(settingsProvider).otherDevices, isEmpty);
  });

  testWidgets('report user requires reason and preserves block state', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container
        .read(socialGraphProvider.notifier)
        .blockUser(
          userId: 'u-riad',
          displayName: 'Riad B.',
          username: 'riad.b',
          pokidokiId: 'PKD-R8D4-72LX',
        );

    await _pump(
      tester,
      _router(initial: AppRoutes.reportUserPath('u-riad')),
      container: container,
    );

    expect(find.text('Riad B.'), findsWidgets);
    expect(find.text('@riad.b'), findsOneWidget);
    expect(find.text('Harassment'), findsOneWidget);

    final notifier = container.read(safetyReportingProvider('u-riad').notifier);
    expect(await _awaitMock(tester, notifier.submit()), isFalse);
    notifier.selectReason(ReportReason.harassment);
    notifier.setDetails('Unwanted messages');
    notifier.setSelectedEvidence(const ['m-ok']);
    expect(await _awaitMock(tester, notifier.submit()), isTrue);

    expect(MockSafetyReportingRepository.submittedReports, hasLength(1));
    expect(
      container
          .read(socialGraphProvider)
          .blockedUsers
          .any((user) => user.id == 'u-riad'),
      isTrue,
    );
    expect(
      container.read(messagingProvider).messagesFor('conv-amira'),
      isNotEmpty,
    );
  });

  testWidgets('conversation info report opens report user for Amira', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await _pump(
      tester,
      _router(initial: AppRoutes.conversationInfoPath('conv-amira')),
      container: container,
    );

    await tester.dragUntilVisible(
      find.text('Report'),
      find.byType(ListView),
      const Offset(0, -200),
    );
    await tester.tap(find.text('Report'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(ReportUserScreen), findsOneWidget);
    expect(find.text('Amira Mansouri'), findsWidgets);
  });

  testWidgets('support sheet never asks for secrets', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await _pump(
      tester,
      _router(initial: AppRoutes.settingsAccountRecovery),
      container: container,
    );

    await tester.dragUntilVisible(
      find.text('I cannot access this email'),
      find.byType(ListView),
      const Offset(0, -200),
    );
    await tester.tap(find.text('I cannot access this email'));
    await tester.pump();
    expect(
      find.text(
        'Support will never ask for your password, app PIN, or verification code.',
      ),
      findsOneWidget,
    );
  });
}
