# Authentication API Integration

Phase 1 connects the existing Flutter authentication UI to the Pokidoki NestJS backend (`auth-core-v0.2.0`).

## Production wiring

- `ApiAuthenticationRepository` is the default via `authenticationRepositoryProvider`.
- `MockAuthenticationRepository` remains for widget tests and previews (`test/helpers/test_overrides.dart`).
- Access tokens live in memory (`AuthSessionManager`).
- Refresh tokens live in secure storage (`SecureAuthTokenStorage`).

## API base URL

Provide at compile time:

```bash
flutter run --dart-define=API_BASE_URL=http://127.0.0.1:3000/api/v1
```

Debug builds fall back to `http://127.0.0.1:3000/api/v1` when unset. Release builds require an explicit value.

## Integrated endpoints

| Flow | Endpoint |
| --- | --- |
| Register | `POST /auth/register` |
| Send verification | `POST /auth/email-verification/send` |
| Verify email | `POST /auth/email-verification/verify` |
| Sign in | `POST /auth/login` |
| Current user | `GET /auth/me` |
| Refresh | `POST /auth/refresh` |
| Sign out | `POST /auth/logout` |
| Sign out all | `POST /auth/logout-all` |

## Local onboarding (still mock)

Username setup, profile setup, PIN, and biometrics remain local UI steps. They are not sent to the backend in this phase.

## Development verification codes

The backend may expose a development code when configured:

```env
ALLOW_DEV_AUTH_CODE=true
DEV_AUTH_CODE=<six-digit-code>
```

Never hardcode this value in Flutter. See `LOCAL_BACKEND_CONNECTIVITY.md`.

## Security activity

`GET /security-activity` is documented via `SecurityActivityRepository`. Full settings integration is deferred.
