import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/app/app_bootstrap.dart';
import 'package:pokidoki/app/providers/app_providers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('bootstrap moves from loading to ready', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(appBootstrapProvider).phase, BootstrapPhase.idle);

    final future = container
        .read(appBootstrapProvider.notifier)
        .start(minDuration: const Duration(milliseconds: 50));

    expect(container.read(appBootstrapProvider).isLoading, isTrue);
    await future;

    expect(container.read(appBootstrapProvider).isReady, isTrue);
    expect(container.read(themeModeProvider), ThemeMode.dark);
  });
}
