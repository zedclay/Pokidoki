# Local Messaging Database

Pokidoki stores cached conversations, messages, outbound queue items, and sync metadata in an encrypted Drift/SQLite database (`pokidoki_messages_v1.sqlite`).

## Architecture

```
Backend REST / Socket.IO
        ↓
MessagingSyncEngine + OutboundMessageQueueProcessor
        ↓
Encrypted MessagingDatabase (Drift)
        ↓
Reactive streams → Controllers → UI
```

The local database is the **UI source of truth** for displayed conversations and messages. Remote events update the database first; widgets observe Drift streams.

## Tables (schema v1)

| Table | Purpose |
|-------|---------|
| `local_conversations` | Conversation list, preview, unread, mute, disappearing, send capability |
| `local_messages` | Message history, delivery status, sync state |
| `outbound_message_queue` | Durable send queue (`sendTextMessage` only in this phase) |
| `messaging_sync_metadata` | Safe sync timestamps and schema markers |

## Opening policy

- Database opens **only after** authenticated session restoration.
- One application-wide `MessagingDatabaseLifecycle` instance.
- Logout and session revocation **close and wipe** the database file and encryption key.

## Recovery

| Condition | Behavior |
|-----------|----------|
| Key exists, file missing | Create fresh encrypted DB with existing key |
| File exists, key missing | Delete orphan file, generate new key, resync from backend |
| Wrong key / corrupt file | Fail closed, delete local cache, new key, resync |

The backend remains authoritative; local data is a cache only.

## Migrations

Schema version starts at **1**. Future versions use Drift `onUpgrade` without destructive default migrations. See `messaging_database.dart`.

## Not in scope

- End-to-end encryption (local encryption ≠ E2EE)
- Attachments, groups, push, background execution

## Code generation (Drift)

Regenerate Drift/DAO code after schema changes:

```bash
dart run build_runner build --delete-conflicting-outputs
```

**Important:** `build_runner` **2.14+** AOT-compiles builders with `dart compile`, which fails when the `sqlite3mc` hook is enabled (`pubspec.yaml` → `hooks.user_defines.sqlite3.source`). This project pins **`build_runner: 2.13.1`** (JIT builders). Do not upgrade to 2.14+ until Dart hooks support AOT builder compilation.

Expected failure if unpinned:

```
E 'dart compile' does not support build hooks, use 'dart build' instead.
E Failed to compile build script.
```

`flutter pub run build_runner` uses the same pinned version and is equivalent when `pubspec.lock` is resolved.
