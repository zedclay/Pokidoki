abstract interface class AuthTokenStorage {
  Future<String?> readRefreshToken();

  Future<void> writeRefreshToken(String token);

  Future<void> deleteRefreshToken();
}
