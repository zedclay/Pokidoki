# Pokidoki

Private conversations. Trusted connections.

Pokidoki is a Flutter mobile application for private one-to-one messaging with a calm, premium, security-conscious experience.

## Quick start

```bash
flutter pub get
flutter run
```

## Documentation

- [Architecture](docs/ARCHITECTURE.md)
- [Local messaging database](docs/LOCAL_MESSAGING_DATABASE.md)
- [Local database encryption](docs/LOCAL_DATABASE_ENCRYPTION.md)
- [Offline messaging sync](docs/OFFLINE_MESSAGING_SYNC.md)
- [Durable message queue](docs/DURABLE_MESSAGE_QUEUE.md)
- [Messaging API integration](docs/MESSAGING_API_INTEGRATION.md)
- [Messaging socket lifecycle](docs/MESSAGING_SOCKET_LIFECYCLE.md)
- [Design system](docs/DESIGN_SYSTEM.md)
- [Project setup](docs/PROJECT_SETUP.md)
- [Screen progress](docs/SCREEN_PROGRESS.md)
- [Security boundaries](docs/SECURITY_BOUNDARIES.md)

## Current status

Encrypted offline messaging persistence is implemented on branch `feature/encrypted-offline-messaging`. Production messaging uses an encrypted Drift/SQLite cache, durable outbound queue, and REST/Socket.IO synchronization. Widget tests continue to use mock repositories via Riverpod overrides.
