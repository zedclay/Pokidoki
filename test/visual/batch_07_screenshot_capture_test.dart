import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/data/models/account_security.dart';
import 'package:pokidoki/design_system/themes/pokidoki_theme.dart';
import 'package:pokidoki/features/account_security/presentation/controllers/account_security_controller.dart';
import 'package:pokidoki/features/account_security/presentation/screens/account_recovery_screen.dart';
import 'package:pokidoki/features/account_security/presentation/screens/change_password_screen.dart';
import 'package:pokidoki/features/account_security/presentation/screens/email_management_screen.dart';
import 'package:pokidoki/features/safety/presentation/controllers/safety_reporting_controller.dart';
import 'package:pokidoki/features/safety/presentation/screens/report_user_screen.dart';
import 'package:pokidoki/l10n/app_localizations.dart';

const _viewport = Size(390, 844);
const _outputDir = 'artifacts/ui_comparisons/batch_07';

Future<void> _capture(WidgetTester tester, String filename) async {
  final boundary = tester.renderObject<RenderRepaintBoundary>(
    find.byKey(const ValueKey('visual-capture')),
  );
  await tester.runAsync(() async {
    final image = await boundary.toImage(pixelRatio: 1);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    final directory = Directory(_outputDir);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
    await File(
      '$_outputDir/$filename',
    ).writeAsBytes(bytes!.buffer.asUint8List());
  });
}

Future<ProviderContainer> _pumpScreen(WidgetTester tester, Widget child) async {
  tester.view.physicalSize = _viewport;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  final container = ProviderContainer();
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: PokidokiTheme.dark(),
        themeMode: ThemeMode.dark,
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MediaQuery(
          data: const MediaQueryData(size: _viewport),
          child: RepaintBoundary(
            key: const ValueKey('visual-capture'),
            child: SizedBox(
              width: _viewport.width,
              height: _viewport.height,
              child: child,
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
  return container;
}

Future<T> _awaitMock<T>(WidgetTester tester, Future<T> future) async {
  await tester.pump(const Duration(milliseconds: 500));
  return future;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('capture change_password_actual.png', (tester) async {
    await _pumpScreen(tester, const ChangePasswordScreen());
    await _capture(tester, 'change_password_actual.png');
  });

  testWidgets('capture email_management_actual.png', (tester) async {
    await _pumpScreen(tester, const EmailManagementScreen());
    await _capture(tester, 'email_management_actual.png');
  });

  testWidgets('capture email_change_actual.png', (tester) async {
    final container = await _pumpScreen(tester, const EmailManagementScreen());
    container.read(accountSecurityProvider.notifier).beginEmailChange();
    await tester.pump();
    await _capture(tester, 'email_change_actual.png');
  });

  testWidgets('capture email_verification_actual.png', (tester) async {
    final container = await _pumpScreen(tester, const EmailManagementScreen());
    final notifier = container.read(accountSecurityProvider.notifier);
    await _awaitMock(tester, notifier.reauthenticateForEmail('Pokidoki!2026'));
    await _awaitMock(tester, notifier.submitNewEmail('new.user@example.com'));
    await tester.pump();
    await _capture(tester, 'email_verification_actual.png');
  });

  testWidgets('capture account_recovery_actual.png', (tester) async {
    await _pumpScreen(tester, const AccountRecoveryScreen());
    await _capture(tester, 'account_recovery_actual.png');
  });

  testWidgets('capture account_recovery_code_actual.png', (tester) async {
    final container = await _pumpScreen(tester, const AccountRecoveryScreen());
    await _awaitMock(
      tester,
      container.read(accountSecurityProvider.notifier).startRecovery(),
    );
    await tester.pump();
    await _capture(tester, 'account_recovery_code_actual.png');
  });

  testWidgets('capture account_recovery_password_actual.png', (tester) async {
    final container = await _pumpScreen(tester, const AccountRecoveryScreen());
    final notifier = container.read(accountSecurityProvider.notifier);
    await _awaitMock(tester, notifier.startRecovery());
    await _awaitMock(tester, notifier.verifyRecoveryCode('654321'));
    await tester.pump();
    await _capture(tester, 'account_recovery_password_actual.png');
  });

  testWidgets('capture report_user_actual.png', (tester) async {
    await _pumpScreen(tester, const ReportUserScreen(userId: 'u-riad'));
    await _capture(tester, 'report_user_actual.png');
  });

  testWidgets('capture report_user_evidence_actual.png', (tester) async {
    final container = await _pumpScreen(
      tester,
      const ReportUserScreen(userId: 'c-amira'),
    );
    container
        .read(safetyReportingProvider('c-amira').notifier)
        .setSelectedEvidence(const ['m-ok']);
    await tester.pump();
    await _capture(tester, 'report_user_evidence_actual.png');
  });

  testWidgets('capture report_user_success_actual.png', (tester) async {
    final container = await _pumpScreen(
      tester,
      const ReportUserScreen(userId: 'u-riad'),
    );
    final notifier = container.read(safetyReportingProvider('u-riad').notifier);
    notifier.selectReason(ReportReason.harassment);
    await _awaitMock(tester, notifier.submit());
    await tester.pump();
    await _capture(tester, 'report_user_success_actual.png');
  });
}
