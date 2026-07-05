import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/core/network/api_error_mapper.dart';
import 'package:pokidoki/core/network/auth_interceptor.dart';
import 'package:pokidoki/core/network/auth_session_manager.dart';
import 'package:pokidoki/core/network/in_memory_auth_token_storage.dart';
import 'package:pokidoki/features/authentication/domain/auth_models.dart';

AuthSession _session({String access = 'access-new'}) {
  return AuthSession(
    accessToken: access,
    refreshToken: 'refresh-new.secret',
    accessTokenExpiresIn: 900,
    user: const AuthenticatedUser(
      id: 'user-1',
      emailMasked: 'u•••@example.com',
      emailVerified: true,
      status: 'ACTIVE',
    ),
  );
}

void main() {
  group('AuthInterceptor', () {
    test('adds bearer token to protected requests', () async {
      final sessionManager = AuthSessionManager();
      sessionManager.establishSession(_session(access: 'access-old'));

      final dio = Dio(
        BaseOptions(
          baseUrl: 'http://example.test',
          validateStatus: (status) =>
              status != null && status >= 200 && status < 300,
        ),
      );

      dio.interceptors.add(
        AuthInterceptor(
          dio: dio,
          sessionManager: sessionManager,
          tokenStorage: InMemoryAuthTokenStorage(),
          refreshSession: (_) async => _session(),
          errorMapper: const ApiErrorMapper(),
          onSessionTerminated: sessionManager.clearSession,
        ),
      );

      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            expect(options.headers['Authorization'], 'Bearer access-old');
            handler.resolve(
              Response(requestOptions: options, statusCode: 200, data: {}),
            );
          },
        ),
      );

      await dio.get<void>('/auth/me');
    });

    test('does not refresh login endpoint on 401', () async {
      var refreshCount = 0;
      final sessionManager = AuthSessionManager();
      final dio = Dio(
        BaseOptions(
          baseUrl: 'http://example.test',
          validateStatus: (status) =>
              status != null && status >= 200 && status < 300,
        ),
      );

      dio.interceptors.add(
        AuthInterceptor(
          dio: dio,
          sessionManager: sessionManager,
          tokenStorage: InMemoryAuthTokenStorage(),
          refreshSession: (_) async {
            refreshCount++;
            return _session();
          },
          errorMapper: const ApiErrorMapper(),
          onSessionTerminated: sessionManager.clearSession,
        ),
      );

      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            handler.reject(
              DioException(
                requestOptions: options,
                response: Response(requestOptions: options, statusCode: 401),
                type: DioExceptionType.badResponse,
              ),
            );
          },
        ),
      );

      await expectLater(
        dio.post<void>('/auth/login', data: {}),
        throwsA(isA<DioException>()),
      );
      expect(refreshCount, 0);
    });
  });
}
