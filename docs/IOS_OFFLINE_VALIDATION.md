# iOS Offline Messaging Validation

Validation performed on branch `feature/encrypted-offline-messaging` using **two iOS Simulators only**. No Android emulator was used in this phase.

## Simulators

| Role | Device | ID | Runtime |
|------|--------|-----|---------|
| A | iPhone 17 Pro | `4A1C3481-8B8E-48BD-983D-03896884EF09` | iOS 26.0 (Simulator) |
| B | iPhone 17 | `C9DCC929-2612-403F-A332-CD79BA4968EB` | iOS 26.0 (Simulator) |

## sqlite3mc runtime (integration test)

Command:

```bash
flutter test integration_test/messaging_database_encryption_test.dart -d <simulator-id>
```

Both simulators: **pass** (0 failures).

Verified on device:

- `PRAGMA cipher` non-empty (sqlite3mc loaded)
- Correct-key open, close, reopen
- Wrong-key fails closed (no plaintext fallback)
- No encryption key in Drift tables
- Wipe removes database file, `-wal`, `-shm`, and secure-storage key
- Fresh encrypted database after wipe

## Two-simulator manual offline workflow

**Status:** Must be executed interactively by an operator on the two simulators above.

**Offline simulation policy (priority order):**

1. Application-level network override — not implemented in production builds.
2. Per-simulator network condition — use only if a supported Simulator A–only control is available.
3. **Shared temporary Backend outage** — both simulators lose API access; validates queue persistence and restart recovery on Simulator A; after Backend restart, Simulator B must receive queued messages exactly once. Document this as shared-outage simulation, not per-device isolation.

**Blocked-queue manual two-device scenario:** Deferred when only shared Backend outage is available. Automated `failedPermanent` queue tests remain authoritative.

## Automated queue coverage (host VM)

See `test/features/messaging/sync/outbound_message_queue_processor_test.dart` and `test/features/messaging/local/messaging_database_test.dart` for FIFO, concurrent drain, stale `inFlight`, permanent failure, persistence, and logout wipe.

## Android limitation (explicit)

- **Android debug APK build:** pass (`flutter build apk --debug`).
- **Android sqlite3mc runtime validation:** **not executed** in this phase (no Android emulator per release policy).
- **Required before Play Store beta:** run `integration_test/messaging_database_encryption_test.dart` on a **physical Android device** or during final Android QA.

## Remaining limitations

- No E2EE; backend development storage remains plaintext.
- Local encryption protects data at rest on the device only.
- No push notifications in this phase.
- No background queue drain while the app is terminated.
- No attachments or group messaging.
