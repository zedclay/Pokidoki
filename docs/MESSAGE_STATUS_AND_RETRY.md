# Message Status and Retry

## Flutter statuses

| Status | Meaning |
|--------|---------|
| `sending` | Optimistic local row, transport in flight |
| `sent` | Server accepted message |
| `delivered` | Recipient client acknowledged delivery |
| `read` | Recipient read through visible chat |
| `failed` | Send failed after safe error handling |

Backend authoritative values: `sent`, `delivered`, `read`.

## Send flow

1. Validate non-empty text.
2. Generate UUID `clientMessageId`.
3. Insert optimistic message (`sending`).
4. Attempt `message.send` on Socket.IO.
5. Reconcile optimistic row from acknowledgement or `message.created`.
6. REST fallback: `POST /conversations/:id/messages` when socket unavailable.
7. Mark `failed` only after both paths fail safely.

## Idempotency

- Retries reuse the same `clientMessageId`.
- Deduplication keys: server message ID and client message ID.
- Status updates are monotonic (`read` never downgrades to `delivered`).

## Memory-only pending state

Failed and in-flight messages are not persisted locally in this phase. App termination may lose pending/failed messages.
