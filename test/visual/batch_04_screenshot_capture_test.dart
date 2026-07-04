import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/data/mock/mock_sample_data.dart';
import 'package:pokidoki/design_system/themes/pokidoki_theme.dart';
import 'package:pokidoki/features/verification/presentation/screens/contact_verification_screen.dart';
import 'package:pokidoki/features/verification/presentation/screens/my_qr_code_screen.dart';
import 'package:pokidoki/features/verification/presentation/screens/qr_scanner_screen.dart';
import 'package:pokidoki/features/verification/presentation/screens/safety_number_screen.dart';
import 'package:pokidoki/l10n/app_localizations.dart';

const _viewport = Size(390, 844);
const _outputDir = 'artifacts/ui_comparisons/batch_04';

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
  await tester.pump(const Duration(milliseconds: 200));
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('capture qr_scanner_actual.png', (tester) async {
    await _pumpScreen(tester, const QrScannerScreen());
    await _capture(tester, 'qr_scanner_actual.png');
  });

  testWidgets('capture my_qr_code_actual.png', (tester) async {
    await _pumpScreen(tester, const MyQrCodeScreen());
    await _capture(tester, 'my_qr_code_actual.png');
  });

  testWidgets('capture contact_verification_actual.png', (tester) async {
    await _pumpScreen(
      tester,
      const ContactVerificationScreen(userId: MockSampleData.amiraUserId),
    );
    await _capture(tester, 'contact_verification_actual.png');
  });

  testWidgets('capture safety_number_actual.png', (tester) async {
    await _pumpScreen(
      tester,
      const SafetyNumberScreen(userId: MockSampleData.amiraUserId),
    );
    await _capture(tester, 'safety_number_actual.png');
  });
}
