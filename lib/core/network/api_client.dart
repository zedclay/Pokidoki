import 'package:dio/dio.dart';

import '../../features/authentication/domain/auth_models.dart';
import 'api_error_mapper.dart';
import 'auth_interceptor.dart';
import 'auth_session_manager.dart';
import 'auth_token_storage.dart';

class ApiClient {
  ApiClient({
    required String baseUrl,
    required AuthSessionManager sessionManager,
    required AuthTokenStorage tokenStorage,
    required Future<AuthSession> Function(String refreshToken) refreshSession,
    Dio? dio,
    ApiErrorMapper? errorMapper,
  }) : _sessionManager = sessionManager,
       _errorMapper = errorMapper ?? const ApiErrorMapper(),
       _dio =
           dio ??
           Dio(
             BaseOptions(
               baseUrl: baseUrl,
               connectTimeout: const Duration(seconds: 15),
               receiveTimeout: const Duration(seconds: 15),
               sendTimeout: const Duration(seconds: 15),
               headers: const {
                 'Accept': 'application/json',
                 'Content-Type': 'application/json',
               },
               validateStatus: (status) =>
                   status != null && status >= 200 && status < 300,
             ),
           ) {
    _dio.interceptors.add(
      AuthInterceptor(
        dio: _dio,
        sessionManager: sessionManager,
        tokenStorage: tokenStorage,
        refreshSession: refreshSession,
        errorMapper: _errorMapper,
        onSessionTerminated: sessionManager.clearSession,
      ),
    );
  }

  final Dio _dio;
  final AuthSessionManager _sessionManager;
  final ApiErrorMapper _errorMapper;

  Dio get dio => _dio;

  ApiErrorMapper get errorMapper => _errorMapper;

  AuthSessionManager get sessionManager => _sessionManager;
}
