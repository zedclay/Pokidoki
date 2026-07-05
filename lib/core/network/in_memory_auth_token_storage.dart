import 'auth_token_storage.dart';

class InMemoryAuthTokenStorage implements AuthTokenStorage {
  String? _refreshToken;

  @override
  Future<void> deleteRefreshToken() async {
    _refreshToken = null;
  }

  @override
  Future<String?> readRefreshToken() async {
    return _refreshToken;
  }

  @override
  Future<void> writeRefreshToken(String token) async {
    _refreshToken = token;
  }
}
