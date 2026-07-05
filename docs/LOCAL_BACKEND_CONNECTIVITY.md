# Local Backend Connectivity

## URLs

| Target | API base URL |
| --- | --- |
| iOS Simulator | `http://127.0.0.1:3000/api/v1` |
| Android Emulator | `http://10.0.2.2:3000/api/v1` |
| Physical device | `http://<MAC_LAN_IP>:3000/api/v1` |

## Commands

```bash
# iOS Simulator
flutter run --dart-define=API_BASE_URL=http://127.0.0.1:3000/api/v1

# Android Emulator
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3000/api/v1
```

## HTTP in debug

- **Android:** debug manifest enables cleartext only for localhost / emulator bridge hosts via `network_security_config.xml`.
- **iOS:** `NSAllowsLocalNetworking` and a localhost ATS exception support local development. Release production URLs must use HTTPS.

## Backend health

```bash
curl -fsS http://localhost:3000/api/v1/health
```

## Development verification email

Configure the backend (not Flutter):

```env
ALLOW_DEV_AUTH_CODE=true
DEV_AUTH_CODE=<six-digit-code>
```

Use the configured code only during manual local testing. Flutter never displays or logs it.

## Optional integration test

Run manually when the backend and PostgreSQL are available:

```bash
flutter test test/integration/auth_backend_integration_test.dart
```

Do not run this in CI unless the backend test stack is provisioned.
