class AuthenticatedUser {
  const AuthenticatedUser({
    required this.id,
    required this.emailMasked,
    required this.emailVerified,
    required this.status,
    this.createdAt,
  });

  final String id;
  final String emailMasked;
  final bool emailVerified;
  final String status;
  final DateTime? createdAt;
}

class AuthSession {
  const AuthSession({
    required this.accessToken,
    required this.refreshToken,
    required this.accessTokenExpiresIn,
    required this.user,
  });

  final String accessToken;
  final String refreshToken;
  final int accessTokenExpiresIn;
  final AuthenticatedUser user;
}

class RegistrationResult {
  const RegistrationResult({
    required this.user,
    required this.verificationRequired,
  });

  final AuthenticatedUser user;
  final bool verificationRequired;
}

class VerificationResult {
  const VerificationResult({required this.user});

  final AuthenticatedUser user;
}
