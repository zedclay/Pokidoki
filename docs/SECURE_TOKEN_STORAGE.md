# Secure Token Storage

## Policy

| Secret | Storage |
| --- | --- |
| Access token | Memory only (`AuthSessionManager`) |
| Refresh token | `flutter_secure_storage` |
| Password | Never stored |
| Verification code | Never stored |

## Implementation

- Interface: `AuthTokenStorage`
- Production: `SecureAuthTokenStorage`
- Tests: `InMemoryAuthTokenStorage`

Widgets must not read secure storage directly. Repositories and interceptors use the provider layer.

## Test overrides

```dart
import 'test/helpers/test_overrides.dart';

ProviderScope(
  overrides: pokidokiTestOverrides,
  child: ...,
);
```
