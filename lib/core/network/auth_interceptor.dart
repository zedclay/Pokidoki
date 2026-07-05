import 'package:dio/dio.dart';

import '../../features/authentication/domain/auth_models.dart';
import 'api_error_mapper.dart';
import 'auth_session_manager.dart';
import 'auth_token_storage.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required Dio dio,
    required AuthSessionManager sessionManager,
    required AuthTokenStorage tokenStorage,
    required Future<AuthSession> Function(String refreshToken) refreshSession,
    required ApiErrorMapper errorMapper,
    required void Function() onSessionTerminated,
  }) : _dio = dio,
       _sessionManager = sessionManager,
       _tokenStorage = tokenStorage,
       _refreshSession = refreshSession,
       _onSessionTerminated = onSessionTerminated;

  final Dio _dio;
  final AuthSessionManager _sessionManager;
  final AuthTokenStorage _tokenStorage;
  final Future<AuthSession> Function(String refreshToken) _refreshSession;
  final void Function() _onSessionTerminated;

  static const _unauthenticatedPaths = {
    '/auth/register',
    '/auth/email-verification/send',
    '/auth/email-verification/verify',
    '/auth/login',
    '/auth/refresh',
  };

  bool _isAuthPath(String path) {
    return _unauthenticatedPaths.any((segment) => path.contains(segment));
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _sessionManager.accessToken;
    if (token != null && token.isNotEmpty && !_isAuthPath(options.path)) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final response = err.response;
    final path = err.requestOptions.path;

    if (response?.statusCode != 401 ||
        _isAuthPath(path) ||
        err.requestOptions.extra['retried'] == true) {
      handler.next(err);
      return;
    }

    final refreshToken = await _tokenStorage.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      _onSessionTerminated();
      handler.next(err);
      return;
    }

    try {
      final session = await _sessionManager.runSingleFlightRefresh(() async {
        final refreshed = await _refreshSession(refreshToken);
        await _tokenStorage.writeRefreshToken(refreshed.refreshToken);
        _sessionManager.updateAccessToken(
          accessToken: refreshed.accessToken,
          accessTokenExpiresIn: refreshed.accessTokenExpiresIn,
        );
        return refreshed;
      });

      final retryOptions = err.requestOptions;
      retryOptions.headers['Authorization'] = 'Bearer ${session.accessToken}';
      retryOptions.extra['retried'] = true;

      final retryResponse = await _dio.fetch<dynamic>(retryOptions);
      handler.resolve(retryResponse);
    } on Object {
      _onSessionTerminated();
      await _tokenStorage.deleteRefreshToken();
      handler.next(err);
    }
  }
}
