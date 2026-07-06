# Offline Security Limitations

This phase adds **local encryption at rest** for cached messaging data. Important limitations:

## Not end-to-end encryption

- Local SQLite encryption protects the on-device cache if the device is compromised at rest.
- Messages are **not** E2EE between users.
- Backend development storage remains **plaintext**.
- Do not describe this phase as production-secure messaging.

## No secure deletion claims

Disappearing messages remove **local** expired rows and update previews. This is not cryptographic deletion on the backend.

## Offline access

- Cold-start offline access requires successful **authenticated session restoration** through the existing auth stack.
- If session restoration needs network, offline cache may be unavailable until connectivity returns.
- No password-less or token-less offline bypass was added.

## No background delivery

When the app is terminated, queued messages do not send until the user opens the app again. No push notifications or background fetch in this phase.

## Logging policy

Never log: message text, search queries, queue payloads, encryption keys, tokens, PRAGMA key statements, or database file paths in user-visible errors.

## What is protected

| Protected | Not protected |
|-----------|---------------|
| Local DB file at rest | Messages on backend (plaintext dev) |
| Key in secure storage | Messages in transit (TLS only) |
| Logout wipe of local cache | Other users' devices |

## Next phases

Push notifications, attachments, and true E2EE would require separate design and are out of scope here.

## Platform validation status

| Platform | sqlite3mc runtime | Offline workflow |
|----------|-------------------|------------------|
| iOS Simulator (×2) | Pass — see [IOS_OFFLINE_VALIDATION.md](./IOS_OFFLINE_VALIDATION.md) | Manual two-simulator workflow (operator) |
| Android | **Deferred** — APK build only; runtime test required on physical device before Play Store beta | N/A in this phase |

Do not report Android sqlite3mc runtime validation as complete until the integration test passes on a physical Android device.
