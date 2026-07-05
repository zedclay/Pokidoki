import 'dart:io' show Platform;

import 'package:dio/dio.dart';

import '../../../../core/network/api_error_mapper.dart';
import '../../../../core/network/auth_session_manager.dart';
import '../../../../core/network/auth_token_storage.dart';
import '../../domain/auth_models.dart';
import '../authentication_repository.dart';
import 'auth_api.dart';
import 'auth_api_models.dart';

class ApiAuthenticationRepository implements AuthenticationRepository {
  ApiAuthenticationRepository({
    required AuthApi authApi,
    required AuthTokenStorage tokenStorage,
    required AuthSessionManager sessionManager,
    required ApiErrorMapper errorMapper,
  }) : _authApi = authApi,
       _tokenStorage = tokenStorage,
       _sessionManager = sessionManager,
       _errorMapper = errorMapper;

  final AuthApi _authApi;
  final AuthTokenStorage _tokenStorage;
  final AuthSessionManager _sessionManager;
  final ApiErrorMapper _errorMapper;

  @override
  Future<void> createAccount({
    required String email,
    required String password,
  }) async {
    await register(email: email, password: password);
  }

  Future<RegistrationResult> register({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authApi.register(
        email: email,
        password: password,
      );
      return mapRegisterResponse(response);
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<void> sendVerificationCode({required String email}) async {
    try {
      await _authApi.sendVerificationCode(email: email);
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<void> verifyEmailCode({
    required String email,
    required String code,
  }) async {
    try {
      await _authApi.verifyEmail(email: email, code: code);
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<AuthSession> signIn({
    required String email,
    required String password,
    required String deviceLabel,
  }) async {
    try {
      final response = await _authApi.login(
        email: email,
        password: password,
        deviceLabel: deviceLabel,
      );
      final session = mapAuthSessionDto(response);
      await _tokenStorage.writeRefreshToken(session.refreshToken);
      _sessionManager.establishSession(session);
      return session;
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<AuthSession?> restoreSession() async {
    final refreshToken = await _tokenStorage.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      return null;
    }

    try {
      final response = await _authApi.refresh(refreshToken: refreshToken);
      final session = mapAuthSessionDto(response);
      await _tokenStorage.writeRefreshToken(session.refreshToken);
      _sessionManager.establishSession(session);
      final user = await getCurrentUser();
      _sessionManager.setCurrentUser(user);
      return session;
    } on DioException catch (error) {
      await _tokenStorage.deleteRefreshToken();
      _sessionManager.clearSession();
      if (error.response?.statusCode == 401) {
        return null;
      }
      throw _mapException(error);
    }
  }

  @override
  Future<AuthenticatedUser> getCurrentUser() async {
    try {
      final response = await _authApi.me();
      final user = mapAuthUserDto(response);
      _sessionManager.setCurrentUser(user);
      return user;
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<void> logout() async {
    try {
      if (_sessionManager.hasAccessToken) {
        await _authApi.logout();
      }
    } on DioException {
      // Best-effort server logout.
    } finally {
      await _tokenStorage.deleteRefreshToken();
      _sessionManager.clearSession();
    }
  }

  @override
  Future<void> logoutAll() async {
    try {
      if (_sessionManager.hasAccessToken) {
        await _authApi.logoutAll();
      }
    } on DioException {
      // Best-effort server logout.
    } finally {
      await _tokenStorage.deleteRefreshToken();
      _sessionManager.clearSession();
    }
  }

  AuthFailure _mapException(DioException error) {
    if (error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      final network = _errorMapper.mapDioException(error);
      return AuthFailure(messageKey: network.messageKey);
    }

    if (error.response != null) {
      final apiError = _errorMapper.mapResponse(error);
      return AuthFailure(
        messageKey: _errorMapper.messageKeyForBackendCode(apiError.code),
        backendCode: apiError.code,
      );
    }

    return const AuthFailure(messageKey: 'authUnexpectedError');
  }
}

String defaultDeviceLabel() {
  if (Platform.isAndroid) {
    return 'Pokidoki Android device';
  }
  if (Platform.isIOS) {
    return 'Pokidoki iOS device';
  }
  return 'Pokidoki device';
}
