import 'dart:async';

import 'package:pokidoki/design_system/typography/pokidoki_typography.dart';

/// Global test configuration for the Pokidoki package.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  PokidokiTypography.useNetworkFonts = false;
  await testMain();
}
