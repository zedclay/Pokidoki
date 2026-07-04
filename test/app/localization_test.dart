import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/l10n/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  for (final locale in AppLocalizations.supportedLocales) {
    testWidgets('loads localizations for ${locale.languageCode}', (
      tester,
    ) async {
      late AppLocalizations l10n;

      await tester.pumpWidget(
        MaterialApp(
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) {
              l10n = AppLocalizations.of(context);
              return Text(l10n.appName);
            },
          ),
        ),
      );

      expect(l10n.appName, 'Pokidoki');
      expect(l10n.splashTagline, isNotEmpty);
      expect(l10n.splashPreparing, isNotEmpty);
    });
  }
}
