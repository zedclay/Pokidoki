import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/core/network/api_error_mapper.dart';
import 'package:pokidoki/core/network/auth_session_manager.dart';
import 'package:pokidoki/core/network/in_memory_auth_token_storage.dart';
import 'package:pokidoki/features/authentication/data/api/api_authentication_repository.dart';
import 'package:pokidoki/features/authentication/data/api/auth_api.dart';
import 'package:pokidoki/features/authentication/data/authentication_repository.dart';

void main() {
  group('ApiAuthenticationRepository', () {
    late Dio dio;
    late AuthApi authApi;
    late ApiAuthenticationRepository repository;
    late AuthSessionManager sessionManager;
    late InMemoryAuthTokenStorage tokenStorage;

    setUp(() {
      dio = Dio(
        BaseOptions(
          baseUrl: 'http://example.test',
          validateStatus: (status) =>
              status != null && status >= 200 && status < 300,
        ),
      );
      authApi = AuthApi(dio);
      sessionManager = AuthSessionManager();
      tokenStorage = InMemoryAuthTokenStorage();
      repository = ApiAuthenticationRepository(
        authApi: authApi,
        tokenStorage: tokenStorage,
        sessionManager: sessionManager,
        errorMapper: const ApiErrorMapper(),
      );
    });

    test('maps register validation error code', () async {
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            handler.reject(
              DioException(
                requestOptions: options,
                response: Response(
                  requestOptions: options,
                  statusCode: 409,
                  data: {
                    'code': 'AUTH_EMAIL_UNAVAILABLE',
                    'message': 'Email unavailable',
                  },
                ),
                type: DioExceptionType.badResponse,
              ),
            );
          },
        ),
      );

      await expectLater(
        repository.createAccount(email: 'a@b.com', password: 'Password1234!'),
        throwsA(
          isA<AuthFailure>().having(
            (e) => e.messageKey,
            'messageKey',
            'authEmailUnavailable',
          ),
        ),
      );
    });

    test('login stores refresh token and access token in memory', () async {
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            handler.resolve(
              Response(
                requestOptions: options,
                statusCode: 200,
                data: {
                  'accessToken': 'access-token',
                  'refreshToken': 'session.secret',
                  'accessTokenExpiresIn': 900,
                  'user': {
                    'id': 'user-1',
                    'emailMasked': 'u•••@example.com',
                    'emailVerified': true,
                    'status': 'ACTIVE',
                  },
                },
              ),
            );
          },
        ),
      );

      final session = await repository.signIn(
        email: 'a@b.com',
        password: 'Password1234!',
        deviceLabel: 'Pokidoki test device',
      );

      expect(session.accessToken, 'access-token');
      expect(await tokenStorage.readRefreshToken(), 'session.secret');
      expect(sessionManager.accessToken, 'access-token');
    });

    test('logout clears local session even when server fails', () async {
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            handler.resolve(
              Response(
                requestOptions: options,
                statusCode: 200,
                data: {
                  'accessToken': 'access-token',
                  'refreshToken': 'session.secret',
                  'accessTokenExpiresIn': 900,
                  'user': {
                    'id': 'user-1',
                    'emailMasked': 'u•••@example.com',
                    'emailVerified': true,
                    'status': 'ACTIVE',
                  },
                },
              ),
            );
          },
        ),
      );

      await repository.signIn(
        email: 'a@b.com',
        password: 'Password1234!',
        deviceLabel: 'Pokidoki test device',
      );

      dio.interceptors.clear();
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            handler.reject(
              DioException(
                requestOptions: options,
                type: DioExceptionType.connectionError,
              ),
            );
          },
        ),
      );

      await repository.logout();

      expect(sessionManager.hasAccessToken, isFalse);
      expect(await tokenStorage.readRefreshToken(), isNull);
    });
  });
}
