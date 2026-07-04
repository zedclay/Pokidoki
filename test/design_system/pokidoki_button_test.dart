import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/design_system/components/buttons/pokidoki_buttons.dart';
import 'package:pokidoki/design_system/themes/pokidoki_theme.dart';
import 'package:pokidoki/l10n/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('primary button exposes semantics and minimum touch target', (
    tester,
  ) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        theme: PokidokiTheme.dark(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: PokidokiButton.primary(
            label: 'Continue',
            onPressed: () => tapped = true,
          ),
        ),
      ),
    );

    final size = tester.getSize(find.byType(PokidokiButton));
    expect(size.height, greaterThanOrEqualTo(48));

    await tester.tap(find.text('Continue'));
    expect(tapped, isTrue);
  });
}
