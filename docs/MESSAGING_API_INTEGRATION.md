# Messaging API Integration

Production messaging uses the Backend REST API under `/api/v1` through `ApiConversationsRepository` and `MessagingApi`.

## Endpoints

| Method | Route | Purpose |
|--------|-------|---------|
| POST | `/conversations` | Create or fetch a direct conversation |
| GET | `/conversations` | Paginated conversation list |
| GET | `/conversations/:id` | Conversation details |
| GET | `/conversations/:id/messages` | Message history (`before` cursor) |
| POST | `/conversations/:id/messages` | REST send fallback |
| POST | `/conversations/:id/read` | Batch read receipts |
| PATCH | `/conversations/:id/mute` | Mute / unmute |
| PATCH | `/conversations/:id/disappearing-messages` | Disappearing duration (seconds) |
| GET | `/conversations/:id/messages/search` | In-conversation search |
| POST | `/messages/:messageId/delivered` | Delivery receipt |

## Architecture

- UI and controllers depend on domain models and `ConversationsRepository`.
- DTO mapping lives in `messaging_api_mapper.dart`.
- Errors map to localized keys through `ApiErrorMapper` and `MessagingFailure`.
- Tests override `conversationsRepositoryProvider` with `MockConversationsRepository`.

## Disappearing messages

Flutter UI uses hours (`null`, `1`, `24`, `168`). Backend uses seconds (`0`, `3600`, `86400`, `604800`). Conversion is centralized in `DisappearingDurationMapper`.

## Limitations (this phase)

- No offline database or durable retry queue.
- Pending/failed messages exist in memory only until app restart.
- No attachments, push, or E2EE.

See also: `MESSAGING_SOCKET_LIFECYCLE.md`, `MESSAGE_STATUS_AND_RETRY.md`, `MESSAGING_CURRENT_SECURITY_LIMITATIONS.md`.
