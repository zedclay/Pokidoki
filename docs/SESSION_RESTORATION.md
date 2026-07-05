# Session Restoration

Cold start flow:

1. Splash/bootstrap starts.
2. Refresh token is read from secure storage.
3. If absent, auth state becomes `unauthenticated`.
4. If present, `POST /auth/refresh` rotates the session.
5. New refresh token is stored; access token stays in memory.
6. `GET /auth/me` loads the authenticated user summary.
7. Router sends restored users to App Lock, then the authenticated shell.

Failures clear secure tokens and continue unauthenticated without exposing backend details.

Restoration is bounded by the splash timeout (`AppConstants.splashTimeout`).
