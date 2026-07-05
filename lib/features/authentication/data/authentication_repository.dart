import '../../../data/mock/mock_development_credentials.dart';
import '../domain/auth_models.dart';

/// Presentation-layer authentication boundary.
abstract interface class AuthenticationRepository {
  Future<void> createAccount({required String email, required String password});

  Future<void> sendVerificationCode({required String email});

  Future<void> verifyEmailCode({required String email, required String code});

  Future<AuthSession> signIn({
    required String email,
    required String password,
    required String deviceLabel,
  });

  Future<AuthSession?> restoreSession();

  Future<AuthenticatedUser> getCurrentUser();

  Future<void> logout();

  Future<void> logoutAll();
}

/// Development-only authentication stand-in for tests and previews.
class MockAuthenticationRepository implements AuthenticationRepository {
  const MockAuthenticationRepository();

  @override
  Future<void> createAccount({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
  }

  @override
  Future<void> sendVerificationCode({required String email}) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<AuthSession> signIn({
    required String email,
    required String password,
    required String deviceLabel,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (password == 'wrong') {
      throw const AuthFailure(messageKey: 'authSignInError');
    }
    return const AuthSession(
      accessToken: 'mock-access-token',
      refreshToken: 'mock-session.mock-secret',
      accessTokenExpiresIn: 900,
      user: AuthenticatedUser(
        id: 'mock-user',
        emailMasked: 'u•••@example.com',
        emailVerified: true,
        status: 'ACTIVE',
      ),
    );
  }

  @override
  Future<void> verifyEmailCode({
    required String email,
    required String code,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    if (code != MockDevelopmentCredentials.emailVerificationCode) {
      throw const AuthFailure(messageKey: 'authVerificationError');
    }
  }

  @override
  Future<AuthSession?> restoreSession() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return null;
  }

  @override
  Future<AuthenticatedUser> getCurrentUser() async {
    return const AuthenticatedUser(
      id: 'mock-user',
      emailMasked: 'u•••@example.com',
      emailVerified: true,
      status: 'ACTIVE',
    );
  }

  @override
  Future<void> logout() async {}

  @override
  Future<void> logoutAll() async {}
}

class AuthFailure implements Exception {
  const AuthFailure({required this.messageKey, this.backendCode});

  final String messageKey;
  final String? backendCode;
}
