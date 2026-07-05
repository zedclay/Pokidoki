# Local Database Encryption

Local message cache encryption protects data **at rest on the device**. It does **not** provide end-to-end encryption. Backend development storage remains plaintext.

## Implementation

- **Engine**: SQLite via `sqlite3` with **SQLite3MultipleCiphers** (`sqlite3mc`)
- **Hook** (`pubspec.yaml`):

```yaml
hooks:
  user_defines:
    sqlite3:
      source: sqlite3mc
```

- **Verification**: `PRAGMA cipher;` must return a non-empty result at startup. Failure throws `LOCAL_DATABASE_ENCRYPTION_UNAVAILABLE` — no plaintext fallback.

## Key management

| Rule | Detail |
|------|--------|
| Generation | Cryptographically random 256-bit key, once per installation |
| Storage | `flutter_secure_storage` key `pokidoki.local_database.key.v1` |
| Never stored in | SharedPreferences, Drift rows, logs, Riverpod state, source control |
| Derivation | Not derived from password, email, user ID, or device ID |

Key is applied via `PRAGMA key` in the database setup callback before any table access.

## File location

Application support directory: `pokidoki_messages_v1.sqlite` (+ `-wal`, `-shm`).

## Wrong-key behavior

Unreadable databases are deleted, a new key is generated, and data is resynchronized from the backend. Backend data is never deleted.

## Security limitations

See also `OFFLINE_SECURITY_LIMITATIONS.md` and `MESSAGING_CURRENT_SECURITY_LIMITATIONS.md`.
