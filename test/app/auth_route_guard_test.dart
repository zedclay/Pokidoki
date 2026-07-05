import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/app/app_bootstrap.dart';
import 'package:pokidoki/app/providers/app_providers.dart';
import 'package:pokidoki/app/routing/auth_route_guard.dart';

void main() {
  group('authRedirect', () {
    test('keeps splash while bootstrap is loading', () {
      expect(
        authRedirect(
          authStatus: AuthPresentationStatus.unknown,
          bootstrapPhase: BootstrapPhase.loading,
          location: '/welcome',
        ),
        '/splash',
      );
    });

    test('redirects unauthenticated users away from protected routes', () {
      expect(
        authRedirect(
          authStatus: AuthPresentationStatus.unauthenticated,
          bootstrapPhase: BootstrapPhase.ready,
          location: '/app/chats',
        ),
        '/auth/sign-in',
      );
    });

    test('redirects authenticated users away from sign in', () {
      expect(
        authRedirect(
          authStatus: AuthPresentationStatus.authenticated,
          bootstrapPhase: BootstrapPhase.ready,
          location: '/auth/sign-in',
        ),
        '/security/app-lock',
      );
    });
  });
}
