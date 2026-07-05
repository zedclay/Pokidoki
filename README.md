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
- [Messaging API integration](docs/MESSAGING_API_INTEGRATION.md)
- [Messaging socket lifecycle](docs/MESSAGING_SOCKET_LIFECYCLE.md)
- [Design system](docs/DESIGN_SYSTEM.md)
- [Project setup](docs/PROJECT_SETUP.md)
- [Screen progress](docs/SCREEN_PROGRESS.md)
- [Security boundaries](docs/SECURITY_BOUNDARIES.md)

## Current status

Real-time text messaging is integrated against the Backend REST and Socket.IO APIs on branch `feature/messaging-realtime-integration`. Widget tests continue to use mock repositories via Riverpod overrides.
