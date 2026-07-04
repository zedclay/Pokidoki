# Messaging UI Flow (Batch 5)

## Routes

| Screen | Route |
| --- | --- |
| One-to-One Chat | `/chats/:conversationId` |
| Conversation Information | `/chats/:conversationId/info` |
| Conversation Search | `/chats/:conversationId/search` |
| Shared Media and Files | `/chats/:conversationId/shared` |
| Disappearing Messages | `/chats/:conversationId/disappearing-messages` |

## Composer

- Send is disabled when text is empty.
- Sends mock text messages through `MessagingController`.
- Reply preview is supported.
- Attachments show a later-phase snackbar (no permissions).

## Message actions

Long-press supports Reply, Copy, Delete (outgoing), and Message Info.

## Conversation information

Mute, block, delete conversation, and navigation to search, shared content, disappearing messages, verification, and report placeholder.

Block updates shared `SocialGraphController.blockedUsers` so Settings → Blocked Users stays consistent. Unblock from Settings clears `isBlocked` on the conversation and re-enables the composer.

Report User opens `/report/:peerId` from Conversation Information. Evidence selection may include deliberately chosen mock messages; reporting does not change block state.

## Limitations

Messages are local mock data only. No backend, WebSockets, uploads, or production encryption.
