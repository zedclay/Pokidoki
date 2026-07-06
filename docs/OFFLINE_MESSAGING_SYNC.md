# Offline Messaging Sync

## Triggers

| Event | Action |
|-------|--------|
| Authenticated bootstrap | Open DB, recover queue, connect socket, refresh conversations, drain queue |
| Open conversation | Show cache immediately, sync newest page, reconcile by `serverMessageId` / `clientMessageId` |
| Pull-to-refresh | Fetch backend, upsert to Drift |
| Socket `message.created` | Upsert message, update preview, increment unread if chat hidden |
| Socket receipts | Monotonic status update |
| Socket `conversation.updated` | Upsert conversation fields |
| App foreground | Recover stale queue jobs, refresh conversations, purge expired messages |
| Network restoration (`connectivity_plus`) | Request queue drain (connectivity is a hint only) |

## Conversation sync

- Fetch conversation pages via existing REST APIs.
- Upsert all returned rows; do not delete local conversations missing from one page.
- Preserve local pending-message preview when newer than server preview.

## Message sync

- Newest page on open; older pages via cursor when local history exhausted.
- Queued unsent messages always preserved.
- Expired messages filtered from queries and cleaned periodically.

## Offline auth

Cached data is available after cold start only when the existing auth architecture safely restores an authenticated session. No offline authentication bypass is implemented.

## Search

Server search remains online-only. Cached message text may be searched locally when offline (limited to cached history).
