# Mock Development Credentials

**Developer-only.** These values power mock UI flows in debug and test builds. They are **not** production secrets.

Source: `lib/data/mock/mock_development_credentials.dart`

| Constant | Value | Used by |
| --- | --- | --- |
| `accountPassword` | `Pokidoki!2026` | Change password, reauthentication |
| `emailVerificationCode` | `123456` | Sign-up and email-change verification |
| `accountRecoveryCode` | `654321` | Account recovery flow |
| `appPinFallback` | `123456` | Sign-in when no in-memory PIN was set |

## Rules

- Do not log these values.
- Do not put them in route parameters or URLs.
- Do not show them in release-mode UI.
- Do not persist them in ordinary shared preferences.
- Automated tests may import the constants; production code should treat them as mock-only inputs.

## QR and safety-number mock data

Mock QR payloads and safety numbers live in `lib/data/mock/mock_sample_data.dart` and verification repositories. They follow the same rules as above.
