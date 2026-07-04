import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/design_system/themes/pokidoki_theme.dart';
import 'package:pokidoki/features/messaging/presentation/screens/conversation_info_screen.dart';
import 'package:pokidoki/features/messaging/presentation/screens/conversation_search_screen.dart';
import 'package:pokidoki/features/messaging/presentation/screens/disappearing_messages_screen.dart';
import 'package:pokidoki/features/messaging/presentation/screens/one_to_one_chat_screen.dart';
import 'package:pokidoki/features/messaging/presentation/screens/shared_content_screen.dart';
import 'package:pokidoki/l10n/app_localizations.dart';

const _viewport = Size(390, 844);
const _outputDir = 'artifacts/ui_comparisons/batch_05';

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
  await tester.pump(const Duration(milliseconds: 50));
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('capture one_to_one_chat_actual.png', (tester) async {
    await _pumpScreen(
      tester,
      const OneToOneChatScreen(conversationId: 'conv-amira'),
    );
    await _capture(tester, 'one_to_one_chat_actual.png');
  });

  testWidgets('capture conversation_information_actual.png', (tester) async {
    await _pumpScreen(
      tester,
      const ConversationInfoScreen(conversationId: 'conv-amira'),
    );
    await _capture(tester, 'conversation_information_actual.png');
  });

  testWidgets('capture conversation_search_actual.png', (tester) async {
    await _pumpScreen(
      tester,
      const ConversationSearchScreen(conversationId: 'conv-amira'),
    );
    await _capture(tester, 'conversation_search_actual.png');
  });

  testWidgets('capture shared_content_media_actual.png', (tester) async {
    await _pumpScreen(
      tester,
      const SharedContentScreen(conversationId: 'conv-amira'),
    );
    await _capture(tester, 'shared_content_media_actual.png');
  });

  testWidgets('capture disappearing_messages_actual.png', (tester) async {
    await _pumpScreen(
      tester,
      const DisappearingMessagesScreen(conversationId: 'conv-amira'),
    );
    await _capture(tester, 'disappearing_messages_actual.png');
  });
}
