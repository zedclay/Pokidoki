import '../../../data/mock/mock_development_credentials.dart';

/// Mock account-security boundary for UI development.
abstract interface class AccountSecurityRepository {
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<void> requestEmailChange(String newEmail);

  Future<void> verifyEmailChange(String code);

  Future<void> startRecovery();

  Future<void> verifyRecoveryCode(String code);

  Future<void> completeRecovery(String newPassword);

  Future<void> verifyCurrentPassword(String password);
}

class AccountSecurityFailure implements Exception {
  const AccountSecurityFailure();
}

class MockAccountSecurityRepository implements AccountSecurityRepository {
  const MockAccountSecurityRepository();

  /// In-memory account password for mock flows only.
  static String _accountPassword = MockDevelopmentCredentials.accountPassword;

  static String get accountPassword => _accountPassword;

  @override
  Future<void> verifyCurrentPassword(String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    if (password != _accountPassword) {
      throw const AccountSecurityFailure();
    }
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (currentPassword != _accountPassword) {
      throw const AccountSecurityFailure();
    }
    _accountPassword = newPassword;
  }

  @override
  Future<void> requestEmailChange(String newEmail) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final lower = newEmail.trim().toLowerCase();
    if (lower == 'taken@example.com' || lower == 'admin@pokidoki.app') {
      throw const AccountSecurityFailure();
    }
  }

  @override
  Future<void> verifyEmailChange(String code) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    if (code != MockDevelopmentCredentials.emailVerificationCode) {
      throw const AccountSecurityFailure();
    }
  }

  @override
  Future<void> startRecovery() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> verifyRecoveryCode(String code) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    if (code != MockDevelopmentCredentials.accountRecoveryCode) {
      throw const AccountSecurityFailure();
    }
  }

  @override
  Future<void> completeRecovery(String newPassword) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    _accountPassword = newPassword;
  }

  /// Test-only reset between widget tests.
  static void resetForTests() {
    _accountPassword = MockDevelopmentCredentials.accountPassword;
  }
}
