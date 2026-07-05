import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/core/network/in_memory_auth_token_storage.dart';

void main() {
  group('InMemoryAuthTokenStorage', () {
    test('stores, reads, and deletes refresh token', () async {
      final storage = InMemoryAuthTokenStorage();

      expect(await storage.readRefreshToken(), isNull);

      await storage.writeRefreshToken('session.secret');
      expect(await storage.readRefreshToken(), 'session.secret');

      await storage.deleteRefreshToken();
      expect(await storage.readRefreshToken(), isNull);
    });
  });
}
