# Messaging Socket Lifecycle

Real-time messaging uses Socket.IO namespace `/messaging`.

## Authentication

```dart
{
  'auth': {
    'token': '<access-token>',
  },
}
```

- Only the in-memory access token is sent.
- Refresh tokens are never sent over Socket.IO.
- Connection is refused when no access token exists.

## Origin

Socket origin is derived from the REST base URL:

- API: `http://127.0.0.1:3000/api/v1`
- Socket: `http://127.0.0.1:3000/messaging`

## Coordinator

`MessagingSocketCoordinator` owns lifecycle:

1. Connect after session restoration or login.
2. Disconnect on logout or session revocation.
3. Reconnect after access-token rotation (disconnect old socket, connect with new token).
4. Rejoin the active conversation after reconnect.
5. Bounded exponential reconnect (1s → 15s cap).
6. Clear typing state on disconnect.

## Client events

`conversation.join`, `conversation.leave`, `message.send`, `message.delivered`, `conversation.read`, `typing.start`, `typing.stop`

## Server events

`message.created`, `message.delivered`, `message.read`, `conversation.updated`, `conversation.settings.updated`, `typing.started`, `typing.stopped`

## Privacy

Never log tokens, socket auth payloads, or message bodies.
