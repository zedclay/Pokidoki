import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/design_system/themes/pokidoki_theme.dart';
import 'package:pokidoki/features/authentication/presentation/screens/create_account_screen.dart';
import 'package:pokidoki/features/authentication/presentation/screens/email_verification_screen.dart';
import 'package:pokidoki/features/authentication/presentation/screens/profile_setup_screen.dart';
import 'package:pokidoki/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:pokidoki/features/authentication/presentation/screens/username_setup_screen.dart';
import 'package:pokidoki/features/security_setup/presentation/screens/app_lock_screen.dart';
import 'package:pokidoki/features/security_setup/presentation/screens/confirm_pin_screen.dart';
import 'package:pokidoki/features/security_setup/presentation/screens/create_pin_screen.dart';
import 'package:pokidoki/features/security_setup/presentation/screens/enable_biometrics_screen.dart';
import 'package:pokidoki/l10n/app_localizations.dart';

import '../../helpers/test_overrides.dart';

const _viewport = Size(390, 844);
const _outputDir = 'artifacts/ui_comparisons/batch_02';

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

Future<void> _pumpScreen(WidgetTester tester, Widget child) async {
  tester.view.physicalSize = _viewport;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    ProviderScope(
      overrides: pokidokiTestOverrides,
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
  await tester.pump(const Duration(milliseconds: 50));
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final screens = <String, Widget>{
    'create_account_actual.png': const CreateAccountScreen(),
    'sign_in_actual.png': const SignInScreen(),
    'email_verification_actual.png': const EmailVerificationScreen(),
    'username_setup_actual.png': const UsernameSetupScreen(),
    'profile_setup_actual.png': const ProfileSetupScreen(),
    'create_pin_actual.png': const CreatePinScreen(),
    'confirm_pin_actual.png': const ConfirmPinScreen(),
    'enable_biometrics_actual.png': const EnableBiometricsScreen(),
    'app_lock_actual.png': const AppLockScreen(),
  };

  for (final entry in screens.entries) {
    testWidgets('capture ${entry.key}', (tester) async {
      await _pumpScreen(tester, entry.value);
      await _capture(tester, entry.key);
      // Advance timers from countdown/debounce without hanging.
      await tester.pump(const Duration(seconds: 1));
    });
  }
}
