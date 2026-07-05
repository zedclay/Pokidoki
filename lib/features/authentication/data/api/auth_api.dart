import 'package:dio/dio.dart';

import 'auth_api_models.dart';

class AuthApi {
  AuthApi(this._dio);

  final Dio _dio;

  Dio get dio => _dio;

  Future<RegisterResponseDto> register({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/auth/register',
      data: {'email': email, 'password': password},
    );
    return RegisterResponseDto.fromJson(response.data!);
  }

  Future<void> sendVerificationCode({required String email}) async {
    await _dio.post<void>(
      '/auth/email-verification/send',
      data: {'email': email},
    );
  }

  Future<VerifyEmailResponseDto> verifyEmail({
    required String email,
    required String code,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/auth/email-verification/verify',
      data: {'email': email, 'code': code},
    );
    return VerifyEmailResponseDto.fromJson(response.data!);
  }

  Future<AuthSessionDto> login({
    required String email,
    required String password,
    required String deviceLabel,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/auth/login',
      data: {'email': email, 'password': password, 'deviceLabel': deviceLabel},
    );
    return AuthSessionDto.fromJson(response.data!);
  }

  Future<AuthSessionDto> refresh({required String refreshToken}) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/auth/refresh',
      data: {'refreshToken': refreshToken},
    );
    return AuthSessionDto.fromJson(response.data!);
  }

  Future<AuthUserDto> me() async {
    final response = await _dio.get<Map<String, dynamic>>('/auth/me');
    return AuthUserDto.fromJson(response.data!);
  }

  Future<void> logout() async {
    await _dio.post<void>('/auth/logout');
  }

  Future<void> logoutAll() async {
    await _dio.post<void>('/auth/logout-all');
  }
}
