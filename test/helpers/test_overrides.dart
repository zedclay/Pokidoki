import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokidoki/app/app_bootstrap.dart';
import 'package:pokidoki/app/providers/app_providers.dart';
import 'package:pokidoki/core/constants/app_constants.dart';
import 'package:pokidoki/features/authentication/data/auth_providers.dart';
import 'package:pokidoki/features/authentication/data/authentication_repository.dart';

/// Keeps widget tests offline with the mock authentication repository.
List<Override> get pokidokiTestOverrides => [
  authenticationRepositoryProvider.overrideWithValue(
    const MockAuthenticationRepository(),
  ),
];

/// App-shell and navigation tests that require authenticated routing.
List<Override> get pokidokiAuthenticatedAppOverrides => [
  ...pokidokiTestOverrides,
  authPresentationProvider.overrideWith(
    (ref) => AuthPresentationStatus.authenticated,
  ),
  appBootstrapProvider.overrideWith((ref) => _ReadyAppBootstrap(ref)),
];

class _ReadyAppBootstrap extends AppBootstrap {
  _ReadyAppBootstrap(this._testRef) : super(_testRef) {
    state = const BootstrapState.ready();
    _testRef.read(authPresentationProvider.notifier).state =
        AuthPresentationStatus.authenticated;
  }

  final Ref _testRef;

  @override
  Future<void> start({
    Duration minDuration = AppConstants.splashMinDuration,
  }) async {
    state = const BootstrapState.ready();
    _testRef.read(authPresentationProvider.notifier).state =
        AuthPresentationStatus.authenticated;
  }

  @override
  Future<void> retry({
    Duration minDuration = AppConstants.splashMinDuration,
  }) async {
    await start(minDuration: minDuration);
  }
}

/// Splash and onboarding tests that finish bootstrap without network calls.
List<Override> get pokidokiBootstrapTestOverrides => [
  ...pokidokiTestOverrides,
  appBootstrapProvider.overrideWith((ref) => _FastAppBootstrap(ref)),
];

class _FastAppBootstrap extends AppBootstrap {
  _FastAppBootstrap(this._testRef) : super(_testRef);

  final Ref _testRef;

  @override
  Future<void> start({
    Duration minDuration = AppConstants.splashMinDuration,
  }) async {
    state = const BootstrapState.loading();
    await Future<void>.delayed(minDuration);
    _testRef.read(authPresentationProvider.notifier).state =
        AuthPresentationStatus.unauthenticated;
    state = const BootstrapState.ready();
  }

  @override
  Future<void> retry({
    Duration minDuration = AppConstants.splashMinDuration,
  }) async {
    await start(minDuration: minDuration);
  }
}
