# Local Data Lifecycle

## Login / session restore

1. Restore auth session (existing flow)
2. Open encrypted database
3. Recover abandoned queue jobs
4. Bind Drift streams to controllers
5. Display cached conversations immediately
6. Connect Socket.IO, refresh from backend, drain queue

## App restart (authenticated)

Same as bootstrap if session restores successfully. Queued messages and cached history persist.

## Access-token refresh

Database **stays open**. Socket reconnects; queue continues.

## Temporary network loss

Database and queue **unchanged**. UI shows cached data; sends queue locally.

## App foreground

Recover stale in-flight jobs, refresh conversations, sync active chat, drain queue, purge expired messages.

## App background

State persisted; typing stopped; no queue wipe; no aggressive background sync (no background execution package in this phase).

## Logout / session revocation

1. Stop queue processor
2. Disconnect Socket.IO
3. Close encrypted database
4. Delete database file and encryption key
5. Clear messaging providers and in-memory state

## Account switch

Logout wipe ensures no cross-account data leakage. New login gets a fresh key and resync.

## Token refresh vs logout

| Event | Database | Queue |
|-------|----------|-------|
| Token refresh | Keep | Keep |
| Logout / revocation | Wipe | Wipe |
| Network loss | Keep | Keep |
