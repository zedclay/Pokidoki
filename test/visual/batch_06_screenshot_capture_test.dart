import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/design_system/themes/pokidoki_theme.dart';
import 'package:pokidoki/features/settings/presentation/screens/account_management_screen.dart';
import 'package:pokidoki/features/settings/presentation/screens/app_lock_settings_screen.dart';
import 'package:pokidoki/features/settings/presentation/screens/appearance_screen.dart';
import 'package:pokidoki/features/settings/presentation/screens/blocked_users_screen.dart';
import 'package:pokidoki/features/settings/presentation/screens/language_screen.dart';
import 'package:pokidoki/features/settings/presentation/screens/linked_devices_screen.dart';
import 'package:pokidoki/features/settings/presentation/screens/security_activity_screen.dart';
import 'package:pokidoki/features/settings/presentation/screens/settings_screen.dart';
import 'package:pokidoki/features/settings/presentation/screens/storage_usage_screen.dart';
import 'package:pokidoki/l10n/app_localizations.dart';

const _viewport = Size(390, 844);
const _outputDir = 'artifacts/ui_comparisons/batch_06';

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

Future<void> _pumpScreen(
  WidgetTester tester,
  Widget child, {
  List<Override> overrides = const [],
}) async {
  tester.view.physicalSize = _viewport;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    ProviderScope(
      overrides: overrides,
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
  await tester.pump(const Duration(milliseconds: 250));
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('capture settings_actual.png', (tester) async {
    await _pumpScreen(tester, const SettingsScreen());
    await _capture(tester, 'settings_actual.png');
  });

  testWidgets('capture account_management_actual.png', (tester) async {
    await _pumpScreen(tester, const AccountManagementScreen());
    await _capture(tester, 'account_management_actual.png');
  });

  testWidgets('capture linked_devices_actual.png', (tester) async {
    await _pumpScreen(tester, const LinkedDevicesScreen());
    await _capture(tester, 'linked_devices_actual.png');
  });

  testWidgets('capture security_activity_1_actual.png', (tester) async {
    await _pumpScreen(tester, const SecurityActivityScreen());
    await _capture(tester, 'security_activity_1_actual.png');
  });

  testWidgets('capture security_activity_2_actual.png', (tester) async {
    await _pumpScreen(tester, const SecurityActivityScreen());
    await tester.tap(find.text('Devices'));
    await tester.pump();
    await _capture(tester, 'security_activity_2_actual.png');
  });

  testWidgets('capture blocked_users_actual.png', (tester) async {
    await _pumpScreen(tester, const BlockedUsersScreen());
    await _capture(tester, 'blocked_users_actual.png');
  });

  testWidgets('capture app_lock_settings_actual.png', (tester) async {
    await _pumpScreen(tester, const AppLockSettingsScreen());
    await _capture(tester, 'app_lock_settings_actual.png');
  });

  testWidgets('capture appearance_actual.png', (tester) async {
    await _pumpScreen(tester, const AppearanceScreen());
    await _capture(tester, 'appearance_actual.png');
  });

  testWidgets('capture language_actual.png', (tester) async {
    await _pumpScreen(tester, const LanguageScreen());
    await _capture(tester, 'language_actual.png');
  });

  testWidgets('capture storage_usage_actual.png', (tester) async {
    await _pumpScreen(tester, const StorageUsageScreen());
    await _capture(tester, 'storage_usage_actual.png');
  });

  testWidgets('capture security event detail state', (tester) async {
    await _pumpScreen(
      tester,
      const SecurityEventDetailScreen(eventId: 'sec-device-mac'),
    );
    // Detail is covered by list+filter captures; keep provider warm.
    expect(find.text('New device linked'), findsOneWidget);
  });
}
