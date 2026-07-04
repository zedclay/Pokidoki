# Placeholder and Mock Audit

Final audit of development placeholders, mock behaviors, and debug controls.

## Obsolete Batch 1–7 placeholders removed

All formerly placeholder routes now resolve to real screens:

| Legacy route | Current behavior |
| --- | --- |
| `/dev/conversations-home` | Redirect → Conversations Home |
| `/dev/account-recovery` | Redirect → Account Recovery |
| `/dev/report-user` | Redirect → Report User |
| `/security/qr-scanner` | Real QR Scanner UI (mock camera) |

Auth, messaging, settings, and account-security screens are fully implemented — no “coming later” navigation targets remain for approved flows.

## Intentional remaining mock behaviors

| Area | Mock behavior | Why it remains |
| --- | --- | --- |
| Authentication | In-memory sign-up/sign-in | No backend |
| Email delivery | Code accepted from `MockDevelopmentCredentials` | No mail service |
| Account recovery | Code + security events in memory | No recovery API |
| Messaging | Send/receive in `MessagingController` | No WebSocket/API |
| QR scanner | Frame UI + debug simulate scan | No camera plugin |
| Safety numbers | Deterministic mock fingerprint | No real crypto |
| Linked devices | Static list + remove simulation | No session API |
| Security activity | Generated mock events | No audit log API |
| Report submission | Snackbar success, no upload | No moderation backend |
| Storage / cache clear | Mock sizes + simulated clear | No filesystem audit |
| Biometrics / app lock | UI flow only | No secure enclave |
| Attachments / shared media | Placeholder tiles | No file pipeline |
| Voice / video calling | “Coming later” snackbar | Out of UI scope |
| Help center | Placeholder dialog | No help CMS |
| Delete account | Unavailable snackbar | No Stitch reference |

## Dev-only routes and screens

| Item | Guard | Notes |
| --- | --- | --- |
| `/dev/placeholder` | Dev route only | Generic placeholder |
| `/dev/pin-recovery` | Dev route only | PIN recovery out of scope |
| `DevPlaceholderScreen` l10n keys | Used only by dev routes | Not shown in product flows |

## Debug controls

| Control | Location | Guard |
| --- | --- | --- |
| Simulate QR scan | `qr_scanner_screen.dart` | `kDebugMode` only |
| Development verification hints | Tests only | Not in release UI |

No hidden long-press shortcuts, test auto-complete buttons, or mock PIN display in production-facing widgets.

## User-facing “unavailable” messaging

Consistent snackbars/dialogs for out-of-scope features:

- Voice and video calls
- Real attachment upload / file preview
- Delete account
- Help center content

These do not crash and avoid internal development language where possible.

## Localization keys for legacy dev messages

Keys such as `devScreenCreateAccount`, `devConversationsHome`, etc. remain in ARB files for `DevPlaceholderScreen` compatibility but are **not** shown in implemented product routes.

## Mock credentials

Centralized in `lib/data/mock/mock_development_credentials.dart`. Documented in `docs/MOCK_DEVELOPMENT_CREDENTIALS.md`.
