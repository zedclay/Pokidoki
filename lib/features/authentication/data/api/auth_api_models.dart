import '../../domain/auth_models.dart';

class AuthUserDto {
  const AuthUserDto({
    required this.id,
    required this.emailMasked,
    required this.emailVerified,
    required this.status,
    this.createdAt,
  });

  factory AuthUserDto.fromJson(Map<String, dynamic> json) {
    return AuthUserDto(
      id: json['id'] as String,
      emailMasked: json['emailMasked'] as String,
      emailVerified: json['emailVerified'] as bool? ?? false,
      status: json['status'] as String,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
    );
  }

  final String id;
  final String emailMasked;
  final bool emailVerified;
  final String status;
  final DateTime? createdAt;
}

class AuthSessionDto {
  const AuthSessionDto({
    required this.accessToken,
    required this.refreshToken,
    required this.accessTokenExpiresIn,
    required this.user,
  });

  factory AuthSessionDto.fromJson(Map<String, dynamic> json) {
    return AuthSessionDto(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      accessTokenExpiresIn: json['accessTokenExpiresIn'] as int,
      user: AuthUserDto.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  final String accessToken;
  final String refreshToken;
  final int accessTokenExpiresIn;
  final AuthUserDto user;
}

class RegisterResponseDto {
  const RegisterResponseDto({
    required this.user,
    required this.verificationRequired,
  });

  factory RegisterResponseDto.fromJson(Map<String, dynamic> json) {
    return RegisterResponseDto(
      user: AuthUserDto.fromJson(json['user'] as Map<String, dynamic>),
      verificationRequired: json['verificationRequired'] as bool? ?? true,
    );
  }

  final AuthUserDto user;
  final bool verificationRequired;
}

class VerifyEmailResponseDto {
  const VerifyEmailResponseDto({required this.user});

  factory VerifyEmailResponseDto.fromJson(Map<String, dynamic> json) {
    return VerifyEmailResponseDto(
      user: AuthUserDto.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  final AuthUserDto user;
}

AuthenticatedUser mapAuthUserDto(AuthUserDto dto) {
  return AuthenticatedUser(
    id: dto.id,
    emailMasked: dto.emailMasked,
    emailVerified: dto.emailVerified,
    status: dto.status,
    createdAt: dto.createdAt,
  );
}

AuthSession mapAuthSessionDto(AuthSessionDto dto) {
  return AuthSession(
    accessToken: dto.accessToken,
    refreshToken: dto.refreshToken,
    accessTokenExpiresIn: dto.accessTokenExpiresIn,
    user: mapAuthUserDto(dto.user),
  );
}

RegistrationResult mapRegisterResponse(RegisterResponseDto dto) {
  return RegistrationResult(
    user: mapAuthUserDto(dto.user),
    verificationRequired: dto.verificationRequired,
  );
}

VerificationResult mapVerifyResponse(VerifyEmailResponseDto dto) {
  return VerificationResult(user: mapAuthUserDto(dto.user));
}
