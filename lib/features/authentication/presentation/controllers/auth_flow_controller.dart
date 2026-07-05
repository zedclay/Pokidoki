import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/app_providers.dart';
import '../../../../data/mock/mock_development_credentials.dart';
import '../../data/api/api_authentication_repository.dart';
import '../../data/auth_providers.dart';
import '../../data/authentication_repository.dart';
import '../../domain/auth_models.dart';

/// In-memory account-setup and unlock state for authentication flows.
///
/// Passwords, PINs, and verification codes are never persisted.
class AuthFlowState {
  const AuthFlowState({
    this.email = '',
    this.username = '',
    this.displayName = '',
    this.bio = '',
    this.pendingPin = '',
    this.confirmedPin = '',
    this.biometricsEnabled = false,
    this.isLoading = false,
    this.errorMessageKey,
    this.emailVerified = false,
  });

  final String email;
  final String username;
  final String displayName;
  final String bio;
  final String pendingPin;
  final String confirmedPin;
  final bool biometricsEnabled;
  final bool isLoading;
  final String? errorMessageKey;
  final bool emailVerified;

  String get unlockPin => confirmedPin.isNotEmpty
      ? confirmedPin
      : MockDevelopmentCredentials.appPinFallback;

  String get maskedEmail {
    if (email.isEmpty) {
      return 'h••••@example.com';
    }
    final parts = email.split('@');
    if (parts.length != 2 || parts[0].isEmpty) {
      return 'h••••@example.com';
    }
    final local = parts[0];
    final visible = local.substring(0, 1);
    return '$visible••••@${parts[1]}';
  }

  String get initials {
    final source = displayName.isNotEmpty
        ? displayName
        : (username.isNotEmpty ? username : 'ZC');
    final parts = source.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    }
    return source.substring(0, source.length >= 2 ? 2 : 1).toUpperCase();
  }

  AuthFlowState copyWith({
    String? email,
    String? username,
    String? displayName,
    String? bio,
    String? pendingPin,
    String? confirmedPin,
    bool? biometricsEnabled,
    bool? isLoading,
    String? errorMessageKey,
    bool? emailVerified,
    bool clearError = false,
    bool clearPins = false,
  }) {
    return AuthFlowState(
      email: email ?? this.email,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      bio: bio ?? this.bio,
      pendingPin: clearPins ? '' : (pendingPin ?? this.pendingPin),
      confirmedPin: clearPins ? '' : (confirmedPin ?? this.confirmedPin),
      biometricsEnabled: biometricsEnabled ?? this.biometricsEnabled,
      isLoading: isLoading ?? this.isLoading,
      errorMessageKey: clearError
          ? null
          : (errorMessageKey ?? this.errorMessageKey),
      emailVerified: emailVerified ?? this.emailVerified,
    );
  }
}

class AuthFlowController extends StateNotifier<AuthFlowState> {
  AuthFlowController(this._ref, this._repository)
    : super(const AuthFlowState());

  final Ref _ref;
  final AuthenticationRepository _repository;

  void setEmail(String value) {
    state = state.copyWith(email: value.trim(), clearError: true);
  }

  void setUsername(String value) {
    state = state.copyWith(
      username: value.trim().toLowerCase(),
      clearError: true,
    );
  }

  void setDisplayName(String value) {
    state = state.copyWith(displayName: value.trim(), clearError: true);
  }

  void setBio(String value) {
    state = state.copyWith(bio: value, clearError: true);
  }

  void setPendingPin(String value) {
    state = state.copyWith(pendingPin: value, clearError: true);
  }

  void setConfirmedPin(String value) {
    state = state.copyWith(confirmedPin: value, clearError: true);
  }

  void setBiometricsEnabled(bool value) {
    state = state.copyWith(biometricsEnabled: value, clearError: true);
  }

  void clearPins() {
    state = state.copyWith(clearPins: true, clearError: true);
  }

  void clearSensitiveFlow() {
    state = state.copyWith(clearPins: true, clearError: true);
  }

  Future<void> signOut() async {
    await _repository.logout();
    _ref.read(authPresentationProvider.notifier).state =
        AuthPresentationStatus.unauthenticated;
    state = const AuthFlowState();
  }

  Future<void> signOutAll() async {
    await _repository.logoutAll();
    _ref.read(authPresentationProvider.notifier).state =
        AuthPresentationStatus.unauthenticated;
    state = const AuthFlowState();
  }

  Future<bool> createAccount({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await _repository.createAccount(email: email, password: password);
      state = state.copyWith(
        email: email.trim(),
        isLoading: false,
        emailVerified: false,
      );
      return true;
    } on AuthFailure catch (failure) {
      state = state.copyWith(
        isLoading: false,
        errorMessageKey: failure.messageKey,
      );
      return false;
    }
  }

  Future<bool> sendVerificationCode() async {
    if (state.email.isEmpty) {
      return false;
    }
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await _repository.sendVerificationCode(email: state.email);
      state = state.copyWith(isLoading: false);
      return true;
    } on AuthFailure catch (failure) {
      state = state.copyWith(
        isLoading: false,
        errorMessageKey: failure.messageKey,
      );
      return false;
    }
  }

  Future<bool> signIn({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final session = await _repository.signIn(
        email: email,
        password: password,
        deviceLabel: defaultDeviceLabel(),
      );
      _applyAuthenticatedSession(session);
      state = state.copyWith(
        email: email.trim(),
        emailVerified: session.user.emailVerified,
        displayName: state.displayName.isEmpty
            ? 'Pokidoki User'
            : state.displayName,
        username: state.username.isEmpty ? 'pokidoki_user' : state.username,
        isLoading: false,
      );
      return true;
    } on AuthFailure catch (failure) {
      state = state.copyWith(
        isLoading: false,
        errorMessageKey: failure.messageKey,
        email: failure.backendCode == 'AUTH_EMAIL_NOT_VERIFIED'
            ? email.trim()
            : state.email,
      );
      return false;
    }
  }

  Future<bool> verifyEmailCode(String code) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await _repository.verifyEmailCode(email: state.email, code: code);
      state = state.copyWith(isLoading: false, emailVerified: true);
      return true;
    } on AuthFailure catch (failure) {
      state = state.copyWith(
        isLoading: false,
        errorMessageKey: failure.messageKey,
      );
      return false;
    }
  }

  Future<bool> checkUsernameAvailable(String username) {
    return _repository.isUsernameAvailable(username);
  }

  bool confirmPinMatches(String confirmation) {
    if (confirmation != state.pendingPin) {
      state = state.copyWith(errorMessageKey: 'authPinMismatch');
      return false;
    }
    state = state.copyWith(confirmedPin: confirmation, clearError: true);
    return true;
  }

  bool unlockWithPin(String pin) {
    if (pin == state.unlockPin) {
      state = state.copyWith(clearError: true);
      return true;
    }
    state = state.copyWith(errorMessageKey: 'authAppLockError');
    return false;
  }

  bool unlockWithBiometrics() {
    if (!state.biometricsEnabled) {
      state = state.copyWith(errorMessageKey: 'authBiometricsUnavailable');
      return false;
    }
    state = state.copyWith(clearError: true);
    return true;
  }

  void _applyAuthenticatedSession(AuthSession session) {
    _ref.read(authSessionManagerProvider).establishSession(session);
    _ref.read(authPresentationProvider.notifier).state =
        AuthPresentationStatus.authenticated;
  }
}

final authFlowProvider =
    StateNotifierProvider<AuthFlowController, AuthFlowState>((ref) {
      return AuthFlowController(
        ref,
        ref.watch(authenticationRepositoryProvider),
      );
    });
