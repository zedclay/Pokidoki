import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/account_security.dart';
import '../../../../data/models/security_event.dart';
import '../../../settings/presentation/controllers/settings_controller.dart';
import '../../data/account_security_repository.dart';

class AccountSecurityState {
  const AccountSecurityState({
    required this.email,
    this.passwordStatus = PasswordChangeStatus.idle,
    this.emailStep = EmailManagementStep.overview,
    this.recoveryStep = RecoveryStep.introduction,
    this.signOutOtherDevices = true,
    this.recoverySignOutOtherDevices = true,
    this.isSubmitting = false,
    this.errorKey,
    this.successKey,
    this.pendingNewEmail = '',
  });

  final AccountEmailState email;
  final PasswordChangeStatus passwordStatus;
  final EmailManagementStep emailStep;
  final RecoveryStep recoveryStep;
  final bool signOutOtherDevices;
  final bool recoverySignOutOtherDevices;
  final bool isSubmitting;
  final String? errorKey;
  final String? successKey;
  final String pendingNewEmail;

  AccountSecurityState copyWith({
    AccountEmailState? email,
    PasswordChangeStatus? passwordStatus,
    EmailManagementStep? emailStep,
    RecoveryStep? recoveryStep,
    bool? signOutOtherDevices,
    bool? recoverySignOutOtherDevices,
    bool? isSubmitting,
    String? errorKey,
    String? successKey,
    String? pendingNewEmail,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return AccountSecurityState(
      email: email ?? this.email,
      passwordStatus: passwordStatus ?? this.passwordStatus,
      emailStep: emailStep ?? this.emailStep,
      recoveryStep: recoveryStep ?? this.recoveryStep,
      signOutOtherDevices: signOutOtherDevices ?? this.signOutOtherDevices,
      recoverySignOutOtherDevices:
          recoverySignOutOtherDevices ?? this.recoverySignOutOtherDevices,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorKey: clearError ? null : (errorKey ?? this.errorKey),
      successKey: clearSuccess ? null : (successKey ?? this.successKey),
      pendingNewEmail: pendingNewEmail ?? this.pendingNewEmail,
    );
  }
}

class AccountSecurityController extends StateNotifier<AccountSecurityState> {
  AccountSecurityController(this._ref, this._repository)
    : super(
        AccountSecurityState(
          email: AccountEmailState(
            maskedEmail: 'z••••••@example.com',
            status: EmailVerificationStatus.verified,
            verifiedAt: DateTime.utc(2026, 6, 18),
          ),
        ),
      );

  final Ref _ref;
  final AccountSecurityRepository _repository;
  int _eventCounter = 0;

  void setSignOutOtherDevices(bool value) {
    state = state.copyWith(signOutOtherDevices: value);
  }

  void setRecoverySignOutOtherDevices(bool value) {
    state = state.copyWith(recoverySignOutOtherDevices: value);
  }

  void setNewDeviceAlerts(bool value) {
    state = state.copyWith(
      email: state.email.copyWith(newDeviceAlertsEnabled: value),
    );
  }

  void setProductUpdates(bool value) {
    state = state.copyWith(
      email: state.email.copyWith(productUpdatesEnabled: value),
    );
  }

  void setResearchInvitations(bool value) {
    state = state.copyWith(
      email: state.email.copyWith(researchInvitationsEnabled: value),
    );
  }

  void clearMessages() {
    state = state.copyWith(clearError: true, clearSuccess: true);
  }

  void resetPasswordStatus() {
    state = state.copyWith(
      passwordStatus: PasswordChangeStatus.idle,
      clearError: true,
      clearSuccess: true,
    );
  }

  void beginEmailChange() {
    state = state.copyWith(
      emailStep: EmailManagementStep.reauthenticate,
      clearError: true,
      clearSuccess: true,
    );
  }

  void cancelEmailChange() {
    state = state.copyWith(
      emailStep: EmailManagementStep.overview,
      pendingNewEmail: '',
      email: state.email.copyWith(clearPending: true),
      clearError: true,
    );
  }

  Future<bool> reauthenticateForEmail(String password) async {
    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      await _repository.verifyCurrentPassword(password);
      state = state.copyWith(
        isSubmitting: false,
        emailStep: EmailManagementStep.enterEmail,
      );
      return true;
    } on AccountSecurityFailure {
      state = state.copyWith(
        isSubmitting: false,
        errorKey: 'accountSecurityGenericError',
      );
      return false;
    }
  }

  Future<bool> submitNewEmail(String email) async {
    final trimmed = email.trim();
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(trimmed)) {
      state = state.copyWith(errorKey: 'accountEmailInvalid');
      return false;
    }
    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      await _repository.requestEmailChange(trimmed);
      final masked = AccountPasswordPolicy.maskEmail(trimmed);
      _addEvent(
        type: SecurityEventType.emailChangeRequested,
        title: 'Email change requested',
        summary: 'A verification code was sent for an email change.',
      );
      state = state.copyWith(
        isSubmitting: false,
        pendingNewEmail: trimmed,
        emailStep: EmailManagementStep.verifyCode,
        email: state.email.copyWith(
          status: EmailVerificationStatus.changePending,
          pendingMaskedEmail: masked,
        ),
      );
      return true;
    } on AccountSecurityFailure {
      state = state.copyWith(
        isSubmitting: false,
        errorKey: 'accountEmailConflict',
      );
      return false;
    }
  }

  Future<bool> verifyEmailCode(String code) async {
    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      await _repository.verifyEmailChange(code);
      final masked = AccountPasswordPolicy.maskEmail(state.pendingNewEmail);
      _addEvent(
        type: SecurityEventType.emailChanged,
        title: 'Email changed',
        summary: 'Your account email address was updated.',
      );
      state = state.copyWith(
        isSubmitting: false,
        emailStep: EmailManagementStep.overview,
        pendingNewEmail: '',
        successKey: 'accountEmailUpdated',
        email: state.email.copyWith(
          maskedEmail: masked,
          status: EmailVerificationStatus.verified,
          verifiedAt: DateTime.now().toUtc(),
          clearPending: true,
        ),
      );
      return true;
    } on AccountSecurityFailure {
      state = state.copyWith(
        isSubmitting: false,
        errorKey: 'accountCodeInvalid',
      );
      return false;
    }
  }

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    if (!AccountPasswordPolicy.isStrong(newPassword) ||
        newPassword == currentPassword) {
      state = state.copyWith(
        passwordStatus: PasswordChangeStatus.failure,
        errorKey: 'accountPasswordUpdateFailed',
      );
      return false;
    }
    state = state.copyWith(
      passwordStatus: PasswordChangeStatus.submitting,
      isSubmitting: true,
      clearError: true,
      clearSuccess: true,
    );
    try {
      await _repository.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      _addEvent(
        type: SecurityEventType.passwordChanged,
        title: 'Password changed',
        summary: 'Your Pokidoki account password was updated.',
      );
      if (state.signOutOtherDevices) {
        _ref
            .read(settingsProvider.notifier)
            .signOutOtherDevices(
              summary: 'Other devices were signed out after a password change.',
            );
      }
      state = state.copyWith(
        passwordStatus: PasswordChangeStatus.success,
        isSubmitting: false,
        successKey: 'accountPasswordUpdated',
      );
      return true;
    } on AccountSecurityFailure {
      state = state.copyWith(
        passwordStatus: PasswordChangeStatus.failure,
        isSubmitting: false,
        errorKey: 'accountPasswordUpdateFailed',
      );
      return false;
    }
  }

  void resetRecovery() {
    state = state.copyWith(
      recoveryStep: RecoveryStep.introduction,
      clearError: true,
      clearSuccess: true,
    );
  }

  Future<bool> startRecovery() async {
    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      await _repository.startRecovery();
      _addEvent(
        type: SecurityEventType.recoveryStarted,
        title: 'Account recovery started',
        summary: 'Account recovery was started for this account.',
      );
      state = state.copyWith(
        isSubmitting: false,
        recoveryStep: RecoveryStep.codeVerification,
      );
      return true;
    } on AccountSecurityFailure {
      state = state.copyWith(
        isSubmitting: false,
        errorKey: 'accountSecurityGenericError',
      );
      return false;
    }
  }

  Future<bool> verifyRecoveryCode(String code) async {
    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      await _repository.verifyRecoveryCode(code);
      state = state.copyWith(
        isSubmitting: false,
        recoveryStep: RecoveryStep.newPassword,
      );
      return true;
    } on AccountSecurityFailure {
      state = state.copyWith(
        isSubmitting: false,
        errorKey: 'accountRecoveryCodeInvalid',
      );
      return false;
    }
  }

  Future<bool> completeRecovery(String newPassword) async {
    if (!AccountPasswordPolicy.isStrong(newPassword)) {
      state = state.copyWith(errorKey: 'accountPasswordUpdateFailed');
      return false;
    }
    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      await _repository.completeRecovery(newPassword);
      _addEvent(
        type: SecurityEventType.passwordReset,
        title: 'Password reset',
        summary: 'Your account password was reset through recovery.',
      );
      _addEvent(
        type: SecurityEventType.recoveryCompleted,
        title: 'Account recovery completed',
        summary: 'Account access was restored.',
      );
      if (state.recoverySignOutOtherDevices) {
        _ref
            .read(settingsProvider.notifier)
            .signOutOtherDevices(
              summary: 'Other devices were signed out after account recovery.',
            );
      }
      state = state.copyWith(
        isSubmitting: false,
        recoveryStep: RecoveryStep.completed,
        successKey: 'accountRecoveryCompleted',
      );
      return true;
    } on AccountSecurityFailure {
      state = state.copyWith(
        isSubmitting: false,
        errorKey: 'accountSecurityGenericError',
      );
      return false;
    }
  }

  void cancelRecovery() {
    state = state.copyWith(
      recoveryStep: RecoveryStep.introduction,
      clearError: true,
    );
  }

  void _addEvent({
    required SecurityEventType type,
    required String title,
    required String summary,
  }) {
    _ref
        .read(settingsProvider.notifier)
        .addSecurityEvent(
          SecurityEvent(
            id: 'sec-account-${_eventCounter++}',
            type: type,
            occurredAt: DateTime.now().toUtc(),
            title: title,
            summary: summary,
          ),
        );
  }
}

final accountSecurityRepositoryProvider = Provider<AccountSecurityRepository>((
  ref,
) {
  return const MockAccountSecurityRepository();
});

final accountSecurityProvider =
    StateNotifierProvider<AccountSecurityController, AccountSecurityState>((
      ref,
    ) {
      return AccountSecurityController(
        ref,
        ref.watch(accountSecurityRepositoryProvider),
      );
    });
