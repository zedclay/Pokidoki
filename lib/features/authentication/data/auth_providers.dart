import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers/app_providers.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_error_mapper.dart';
import '../../../core/network/auth_session_manager.dart';
import '../../../core/network/auth_token_storage.dart';
import '../../../core/network/in_memory_auth_token_storage.dart';
import '../../../core/network/secure_auth_token_storage.dart';
import 'api/api_authentication_repository.dart';
import 'api/auth_api.dart';
import 'api/auth_api_models.dart';
import 'authentication_repository.dart';

final authTokenStorageProvider = Provider<AuthTokenStorage>((ref) {
  return SecureAuthTokenStorage();
});

final authSessionManagerProvider = Provider<AuthSessionManager>((ref) {
  return AuthSessionManager();
});

final apiErrorMapperProvider = Provider<ApiErrorMapper>((ref) {
  return const ApiErrorMapper();
});

final apiClientProvider = Provider<ApiClient>((ref) {
  final config = ref.watch(appConfigProvider);
  final sessionManager = ref.watch(authSessionManagerProvider);
  final tokenStorage = ref.watch(authTokenStorageProvider);
  final authApi = AuthApi(_createBaseDio(config.apiBaseUrl));

  return ApiClient(
    baseUrl: config.apiBaseUrl,
    sessionManager: sessionManager,
    tokenStorage: tokenStorage,
    refreshSession: (refreshToken) async {
      final dto = await authApi.refresh(refreshToken: refreshToken);
      return mapAuthSessionDto(dto);
    },
    dio: authApi.dio,
  );
});

final authApiProvider = Provider<AuthApi>((ref) {
  return AuthApi(ref.watch(apiClientProvider).dio);
});

final authenticationRepositoryProvider = Provider<AuthenticationRepository>((
  ref,
) {
  return ApiAuthenticationRepository(
    authApi: ref.watch(authApiProvider),
    tokenStorage: ref.watch(authTokenStorageProvider),
    sessionManager: ref.watch(authSessionManagerProvider),
    errorMapper: ref.watch(apiErrorMapperProvider),
  );
});

final inMemoryAuthTokenStorageProvider = Provider<InMemoryAuthTokenStorage>((
  ref,
) {
  return InMemoryAuthTokenStorage();
});

Dio _createBaseDio(String baseUrl) {
  return Dio(
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
  );
}
