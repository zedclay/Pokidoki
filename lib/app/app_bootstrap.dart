import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/app_constants.dart';
import '../core/services/secure_messaging_service.dart';
import '../data/models/account_settings.dart';
import '../data/repositories/user_repository.dart';
import 'providers/app_providers.dart';

enum BootstrapPhase { idle, loading, ready, failed }

class BootstrapState {
  const BootstrapState({required this.phase, this.errorMessageKey});

  const BootstrapState.idle() : this(phase: BootstrapPhase.idle);
  const BootstrapState.loading() : this(phase: BootstrapPhase.loading);
  const BootstrapState.ready() : this(phase: BootstrapPhase.ready);
  const BootstrapState.failed({String messageKey = 'stateError'})
    : this(phase: BootstrapPhase.failed, errorMessageKey: messageKey);

  final BootstrapPhase phase;
  final String? errorMessageKey;

  bool get isReady => phase == BootstrapPhase.ready;
  bool get isLoading => phase == BootstrapPhase.loading;
}

class AppBootstrap extends StateNotifier<BootstrapState> {
  AppBootstrap(this._ref) : super(const BootstrapState.idle());

  final Ref _ref;
  bool _started = false;

  Future<void> start({
    Duration minDuration = AppConstants.splashMinDuration,
  }) async {
    if (_started) {
      return;
    }
    _started = true;
    state = const BootstrapState.loading();

    final startedAt = DateTime.now();

    try {
      await Future.wait<void>([
        _loadPreferences(),
        _initializeDependencies(),
      ]).timeout(AppConstants.splashTimeout);

      final elapsed = DateTime.now().difference(startedAt);
      if (elapsed < minDuration) {
        await Future<void>.delayed(minDuration - elapsed);
      }

      state = const BootstrapState.ready();
    } on Object {
      state = const BootstrapState.failed();
    }
  }

  Future<void> retry({
    Duration minDuration = AppConstants.splashMinDuration,
  }) async {
    _started = false;
    await start(minDuration: minDuration);
  }

  Future<void> _loadPreferences() async {
    final UserRepository userRepository = _ref.read(userRepositoryProvider);
    final AccountSettings settings = await userRepository.getAccountSettings();

    final themeMode = switch (settings.themeModeName) {
      'light' => ThemeMode.light,
      'system' => ThemeMode.system,
      _ => ThemeMode.dark,
    };
    _ref.read(themeModeProvider.notifier).state = themeMode;

    // Locale remains device-local until Screen 34 persists a preference.
    // Account settings locale is available for future wiring.
    if (settings.localeCode.isNotEmpty) {
      // Intentionally not applying mock locale override on first launch.
    }
  }

  Future<void> _initializeDependencies() async {
    final SecureMessagingService messaging = _ref.read(
      secureMessagingServiceProvider,
    );
    await messaging.initialize();

    // Warm mock repositories so later screens can resolve quickly.
    await Future.wait<void>([
      _ref.read(userRepositoryProvider).getCurrentUser(),
      _ref.read(contactsRepositoryProvider).getContacts(),
      _ref.read(conversationsRepositoryProvider).getConversations(),
    ]);
  }
}

final appBootstrapProvider =
    StateNotifierProvider<AppBootstrap, BootstrapState>((ref) {
      return AppBootstrap(ref);
    });
