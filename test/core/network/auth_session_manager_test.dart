import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/core/network/auth_session_manager.dart';
import 'package:pokidoki/features/authentication/domain/auth_models.dart';

AuthSession _session({
  String access = 'access-1',
  String refresh = 'refresh-1',
}) {
  return AuthSession(
    accessToken: access,
    refreshToken: refresh,
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
  group('AuthSessionManager', () {
    test('keeps access token in memory only', () {
      final manager = AuthSessionManager();
      manager.establishSession(_session());

      expect(manager.accessToken, 'access-1');
      expect(manager.hasAccessToken, isTrue);
    });

    test('clearSession removes access token and user', () {
      final manager = AuthSessionManager();
      manager.establishSession(_session());
      manager.clearSession();

      expect(manager.accessToken, isNull);
      expect(manager.currentUser, isNull);
      expect(manager.hasAccessToken, isFalse);
    });

    test('runSingleFlightRefresh executes refresh once concurrently', () async {
      final manager = AuthSessionManager();
      var refreshCount = 0;

      Future<AuthSession> refresh() async {
        refreshCount++;
        await Future<void>.delayed(const Duration(milliseconds: 50));
        return _session(access: 'access-2', refresh: 'refresh-2');
      }

      final results = await Future.wait([
        manager.runSingleFlightRefresh(refresh),
        manager.runSingleFlightRefresh(refresh),
        manager.runSingleFlightRefresh(refresh),
      ]);

      expect(refreshCount, 1);
      expect(
        results.every((session) => session.accessToken == 'access-2'),
        isTrue,
      );
    });
  });
}
