import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'auth_token_storage.dart';

class SecureAuthTokenStorage implements AuthTokenStorage {
  SecureAuthTokenStorage({FlutterSecureStorage? storage})
    : _storage =
          storage ??
          const FlutterSecureStorage(
            aOptions: AndroidOptions(encryptedSharedPreferences: true),
            iOptions: IOSOptions(
              accessibility: KeychainAccessibility.first_unlock,
            ),
          );

  static const _refreshTokenKey = 'pokidoki_refresh_token';

  final FlutterSecureStorage _storage;

  @override
  Future<String?> readRefreshToken() {
    return _storage.read(key: _refreshTokenKey);
  }

  @override
  Future<void> writeRefreshToken(String token) {
    return _storage.write(key: _refreshTokenKey, value: token);
  }

  @override
  Future<void> deleteRefreshToken() {
    return _storage.delete(key: _refreshTokenKey);
  }
}
