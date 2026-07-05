# Users and Profiles API Integration

Production user APIs use `ApiUserRepository` via `userRepositoryProvider` in `lib/features/users/data/user_providers.dart`.

## Endpoints

| Method | Path | Mobile use |
| --- | --- | --- |
| GET | `/users/username-availability` | Username setup |
| POST | `/users/me/profile` | Profile setup (create) |
| GET | `/users/me/profile` | Bootstrap, account screen |
| PATCH | `/users/me/profile` | Account display name / bio |
| PATCH | `/users/me/username` | Username change (future account edit) |
| GET | `/users/search` | User search |
| GET | `/users/:userId` | Profile preview |

All calls reuse the authenticated Dio client from `apiClientProvider`.

## Mock vs production

Widget and unit tests override `userRepositoryProvider` with `MockUserRepository`. Production uses `ApiUserRepository`.

## Error mapping

Backend profile error codes map through `ApiErrorMapper` to l10n keys in `auth_message_localization.dart` (en/ar/fr).
