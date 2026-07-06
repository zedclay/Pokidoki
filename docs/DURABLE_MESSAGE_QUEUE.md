# Durable Message Queue

## Purpose

Outgoing text messages are persisted in `outbound_message_queue` together with an optimistic `local_messages` row in a **single transaction**. Pending sends survive app restart and network loss.

## States

```
pending → inFlight → completed
                 ↘ waitingRetry → (back to pending cycle)
                 ↘ failedPermanent
```

## Rules

- One queue row per `clientMessageId` (unique constraint).
- Retries **reuse the same `clientMessageId`** for backend idempotency.
- FIFO ordering by `createdAt`.
- Only one drain loop at a time.
- Stale `inFlight` jobs revert to `waitingRetry` after restart.

## Send path

1. User sends text → UUID `clientMessageId`
2. Transaction: insert message (`queued`) + queue row (`pending`) + update preview
3. UI updates via Drift stream
4. `OutboundMessageQueueProcessor` drains: Socket.IO when connected, REST fallback otherwise

## Retry policy

| Type | Examples | Action |
|------|----------|--------|
| Transient | timeout, 5xx, 429, socket disconnect | Exponential backoff: 2s, 5s, 10s, 30s, 60s, 5m max + jitter |
| Permanent | `MESSAGE_TOO_LONG`, `MESSAGE_SEND_NOT_ALLOWED`, block/contact errors | `failedPermanent`, stop retries |

Manual retry resets queue row to `pending` with the **same** `clientMessageId`.

## Block / contact enforcement

When `canSend` becomes false, pending items for that conversation are marked `failedPermanent`.

## Logout

Queue and all local messaging tables are wiped with the database on logout or session revocation.
