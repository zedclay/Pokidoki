import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pokidoki/app/providers/app_providers.dart';
import 'package:pokidoki/app/routing/route_names.dart';
import 'package:pokidoki/design_system/themes/pokidoki_theme.dart';
import 'package:pokidoki/features/account_security/presentation/screens/change_password_screen.dart';
import 'package:pokidoki/features/authentication/presentation/screens/create_account_screen.dart';
import 'package:pokidoki/features/chats/presentation/screens/conversations_home_screen.dart';
import 'package:pokidoki/features/contacts/presentation/screens/contacts_screen.dart';
import 'package:pokidoki/features/messaging/presentation/screens/one_to_one_chat_screen.dart';
import 'package:pokidoki/features/safety/presentation/screens/report_user_screen.dart';
import 'package:pokidoki/features/settings/presentation/screens/app_lock_settings_screen.dart';
import 'package:pokidoki/features/settings/presentation/screens/appearance_screen.dart';
import 'package:pokidoki/features/settings/presentation/screens/language_screen.dart';
import 'package:pokidoki/features/settings/presentation/screens/settings_screen.dart';
import 'package:pokidoki/features/welcome/presentation/screens/welcome_screen.dart';
import 'package:pokidoki/l10n/app_localizations.dart';

const _viewport = Size(390, 844);
const _outputRoot = 'artifacts/ui_comparisons/final';

Future<void> _capture(WidgetTester tester, String relativePath) async {
  final boundary = tester.renderObject<RenderRepaintBoundary>(
    find.byKey(const ValueKey('visual-capture')),
  );

  await tester.runAsync(() async {
    final image = await boundary.toImage(pixelRatio: 1);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    expect(bytes, isNotNull);

    final file = File('$_outputRoot/$relativePath');
    file.parent.createSync(recursive: true);
    await file.writeAsBytes(bytes!.buffer.asUint8List());
    expect(file.existsSync(), isTrue);
  });
}

Future<void> _pumpScreen(
  WidgetTester tester,
  Widget child, {
  Locale locale = const Locale('en'),
  ThemeMode themeMode = ThemeMode.dark,
  Size viewport = _viewport,
}) async {
  tester.view.physicalSize = viewport;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        if (themeMode != ThemeMode.dark)
          themeModeProvider.overrideWith((ref) => themeMode),
        if (locale.languageCode != 'en')
          localeOverrideProvider.overrideWith((ref) => locale),
      ],
      child: MaterialApp(
        theme: PokidokiTheme.light(locale: locale),
        darkTheme: PokidokiTheme.dark(locale: locale),
        themeMode: themeMode,
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MediaQuery(
          data: MediaQueryData(size: viewport),
          child: RepaintBoundary(
            key: const ValueKey('visual-capture'),
            child: SizedBox(
              width: viewport.width,
              height: viewport.height,
              child: child,
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final primaryScreens = <String, Widget>{
    'entry/welcome_dark_en.png': const WelcomeScreen(),
    'authentication/create_account_dark_en.png': const CreateAccountScreen(),
    'messaging/conversations_home_dark_en.png': const ConversationsHomeScreen(),
    'contacts/contacts_dark_en.png': const ContactsScreen(),
    'messaging/one_to_one_chat_dark_en.png': const OneToOneChatScreen(
      conversationId: 'conv-amira',
    ),
    'settings/settings_dark_en.png': const SettingsScreen(),
    'settings/appearance_dark_en.png': const AppearanceScreen(),
    'settings/language_dark_en.png': const LanguageScreen(),
    'settings/app_lock_dark_en.png': const AppLockSettingsScreen(),
    'account_security/change_password_dark_en.png':
        const ChangePasswordScreen(),
    'safety/report_user_dark_en.png': const ReportUserScreen(userId: 'u-riad'),
  };

  for (final entry in primaryScreens.entries) {
    testWidgets('capture ${entry.key}', (tester) async {
      await _pumpScreen(tester, entry.value);
      await _capture(tester, entry.key);
    });
  }

  testWidgets('capture entry/welcome_light_en.png', (tester) async {
    await _pumpScreen(
      tester,
      const WelcomeScreen(),
      themeMode: ThemeMode.light,
    );
    await _capture(tester, 'entry/welcome_light_en.png');
  });

  testWidgets('capture settings/settings_light_en.png', (tester) async {
    await _pumpScreen(
      tester,
      const SettingsScreen(),
      themeMode: ThemeMode.light,
    );
    await _capture(tester, 'settings/settings_light_en.png');
  });

  for (final locale in [const Locale('ar'), const Locale('fr')]) {
    testWidgets('capture entry/welcome_dark_${locale.languageCode}.png', (
      tester,
    ) async {
      await _pumpScreen(tester, const WelcomeScreen(), locale: locale);
      await _capture(tester, 'entry/welcome_dark_${locale.languageCode}.png');
    });

    testWidgets('capture settings/settings_dark_${locale.languageCode}.png', (
      tester,
    ) async {
      await _pumpScreen(tester, const SettingsScreen(), locale: locale);
      await _capture(
        tester,
        'settings/settings_dark_${locale.languageCode}.png',
      );
    });
  }

  testWidgets('capture entry/welcome_small_dark_en.png', (tester) async {
    await _pumpScreen(
      tester,
      const WelcomeScreen(),
      viewport: const Size(320, 568),
    );
    await _capture(tester, 'entry/welcome_small_dark_en.png');
  });

  testWidgets('capture messaging/conversations_home_router_dark_en.png', (
    tester,
  ) async {
    tester.view.physicalSize = _viewport;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final router = GoRouter(
      initialLocation: AppRoutes.appChats,
      routes: [
        GoRoute(
          path: AppRoutes.appChats,
          builder: (context, state) => const ConversationsHomeScreen(),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          theme: PokidokiTheme.dark(),
          themeMode: ThemeMode.dark,
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
          builder: (context, child) {
            return MediaQuery(
              data: const MediaQueryData(size: _viewport),
              child: RepaintBoundary(
                key: const ValueKey('visual-capture'),
                child: SizedBox(
                  width: _viewport.width,
                  height: _viewport.height,
                  child: child,
                ),
              ),
            );
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
    await _capture(tester, 'messaging/conversations_home_router_dark_en.png');
  });
}
