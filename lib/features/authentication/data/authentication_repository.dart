import '../../../data/mock/mock_development_credentials.dart';

/// Presentation-layer authentication boundary for UI development.
///
/// Mock implementations must not claim production security.
abstract interface class AuthenticationRepository {
  Future<void> createAccount({required String email, required String password});

  Future<void> signIn({required String email, required String password});

  Future<void> verifyEmailCode(String code);

  Future<bool> isUsernameAvailable(String username);
}

/// Development-only authentication stand-in.
class MockAuthenticationRepository implements AuthenticationRepository {
  const MockAuthenticationRepository();

  static const _reservedUsernames = {'admin', 'pokidoki', 'support'};

  @override
  Future<void> createAccount({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (password == 'wrong') {
      throw const AuthFailure();
    }
  }

  @override
  Future<void> verifyEmailCode(String code) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    if (code != MockDevelopmentCredentials.emailVerificationCode) {
      throw const AuthFailure();
    }
  }

  @override
  Future<bool> isUsernameAvailable(String username) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return !_reservedUsernames.contains(username.toLowerCase());
  }
}

class AuthFailure implements Exception {
  const AuthFailure();
}
