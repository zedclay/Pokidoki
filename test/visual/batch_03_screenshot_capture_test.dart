import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/design_system/themes/pokidoki_theme.dart';
import 'package:pokidoki/features/chats/presentation/screens/conversations_home_screen.dart';
import 'package:pokidoki/features/chats/presentation/screens/new_conversation_screen.dart';
import 'package:pokidoki/features/contacts/presentation/screens/contact_requests_screen.dart';
import 'package:pokidoki/features/contacts/presentation/screens/contacts_screen.dart';
import 'package:pokidoki/features/users/presentation/screens/user_profile_preview_screen.dart';
import 'package:pokidoki/features/users/presentation/screens/user_search_screen.dart';
import 'package:pokidoki/l10n/app_localizations.dart';

const _viewport = Size(390, 844);
const _outputDir = 'artifacts/ui_comparisons/batch_03';

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

  final screens = <String, Widget>{
    'conversations_home_actual.png': const ConversationsHomeScreen(),
    'new_conversation_actual.png': const NewConversationScreen(),
    'user_search_actual.png': const UserSearchScreen(),
    'user_profile_preview_actual.png': const UserProfilePreviewScreen(
      userId: 'u-amira-r',
    ),
    'contacts_actual.png': const ContactsScreen(),
    'contact_requests_actual.png': const ContactRequestsScreen(),
  };

  for (final entry in screens.entries) {
    testWidgets('capture ${entry.key}', (tester) async {
      await _pumpScreen(tester, entry.value);
      await _capture(tester, entry.key);
      await tester.pump(const Duration(milliseconds: 400));
    });
  }
}
