# Settings Architecture

## Settings root

The Settings tab at `/app/settings` is a real screen (`SettingsScreen`), not a development placeholder. It lives in the third branch of `StatefulShellRoute.indexedStack` so Chats and Contacts tab state is preserved.

Bottom navigation appears only on the three root tabs. Pushed settings destinations are registered outside the shell and do not show the bottom bar.

## Routes

| Route | Screen |
| --- | --- |
| `/app/settings` | Settings |
| `/settings/account` | Account Management |
| `/settings/account/change-password` | Batch 7 placeholder |
| `/settings/account/email` | Batch 7 placeholder |
| `/settings/account/recovery` | Batch 7 placeholder |
| `/settings/linked-devices` | Linked Devices |
| `/settings/security-activity` | Security Activity list |
| `/settings/security-activity/:eventId` | Security event detail |
| `/settings/blocked-users` | Blocked Users |
| `/settings/app-lock` | App Lock Settings |
| `/settings/appearance` | Appearance |
| `/settings/language` | Language |
| `/settings/storage` | Storage Usage |
| `/report/:userId` | Batch 7 Report User placeholder |

Route identifiers are non-sensitive mock IDs only (event ID, user ID, device ID).

## Shared controllers

| Concern | Source |
| --- | --- |
| Theme | `themeModeProvider` |
| Locale | `localeOverrideProvider` / `setAppLocale` |
| App Lock preferences | `settingsProvider` (`AppSecurityPreferences`) synced with `authFlowProvider.biometricsEnabled` |
| Blocked users | `socialGraphProvider.blockedUsers` |
| Linked devices / security events / storage | `settingsProvider` |
| Current user profile | `MockSampleData.currentUser` + `authFlowProvider` display fields |

## Batch 7 destinations

Change Password, Email Management, and Account Recovery are real screens under `/settings/account/*`. Report User is `/report/:userId`.

Delete Account remains unavailable (no approved Stitch reference) and shows an unavailable snackbar only.

## Sign-out behavior

Shared helper: `confirmAndSignOut`.

On confirm:

1. Clears in-memory `AuthFlowState` (including temporary PIN values)
2. Sets `authPresentationProvider` to `unauthenticated`
3. Navigates to Welcome

Preserves theme and language preferences. Does not revoke server sessions or delete mock account data.
