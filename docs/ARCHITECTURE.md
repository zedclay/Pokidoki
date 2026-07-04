# Pokidoki Architecture

## Overview

Pokidoki uses a feature-first Flutter architecture with a shared design system, Riverpod for state and dependency injection, and `go_router` for navigation.

The first-run foundation prioritizes UI development with replaceable mock repositories. Real networking and native cryptography are intentionally out of scope for this phase.

## Project structure

```text
lib/
  main.dart
  app/                    # App shell, bootstrap, routing, providers
  core/                   # Config, errors, services, utilities
  design_system/          # Tokens and reusable components
  features/               # Feature modules (presentation-first)
  data/                   # Models, repository interfaces, mocks
  l10n/                   # ARB localization sources
```

## State management

- Package: `flutter_riverpod`
- Application-wide state lives in providers under `lib/app/providers/`
- Bootstrap state uses a `StateNotifier` (`AppBootstrap`)
- Theme mode and locale override are `StateProvider`s
- Repositories and services are exposed as `Provider`s for easy replacement

Business logic is not placed directly in widgets. Small local UI state (animations, password visibility) may use widget state.

## Final UI QA status

All approved Stitch screens (Batches 1–7) are implemented. See `docs/FINAL_UI_QA_REPORT.md`, `docs/SCREEN_PROGRESS.md`, and `docs/ROUTE_REGISTRY.md`. Production backend integration is tracked in `docs/PRODUCTION_INTEGRATION_ROADMAP.md`.

## Routing

- Package: `go_router`
- Initial route: `/splash`
- Route constants live in `lib/app/routing/route_names.dart`
- Routes are registered only when screens exist
- Future main tabs: Chats, Contacts, Settings (no Groups tab)
- Bottom navigation will appear only after authentication and onboarding

## Repository strategy

Repository interfaces live in `lib/data/repositories/`.

Mock implementations live in `lib/data/mock/` and read from centralized `MockSampleData`.

Screens depend on interfaces through Riverpod providers. Later API implementations can replace mocks without changing presentation code.

## Feature boundaries

Each feature owns presentation code under:

```text
features/<feature>/presentation/
  screens/
  widgets/
  controllers/
```

Shared UI belongs in `design_system/components/`. Shared non-UI utilities belong in `core/`.

## Dependency decisions

| Concern | Choice | Reason |
| --- | --- | --- |
| State management | `flutter_riverpod` | Scalable DI and testable overrides |
| Routing | `go_router` | Deep-link ready, declarative routes |
| Localization | Flutter gen-l10n + ARB | Official workflow, en/ar/fr |
| Fonts | `google_fonts` | Inter + Noto Sans Arabic without bundling unlicensed files |
| Models | Immutable Dart classes | No code generation required for UI models |

## Security boundary

`SecureMessagingService` is an interface only. The mock implementation does not provide production cryptographic protection. See `docs/SECURITY_BOUNDARIES.md`.

## Environment configuration

`AppConfig` and `AppEnvironment` read non-secret values from `--dart-define`:

- `APP_ENV` = `development` | `staging` | `production`
- `API_BASE_URL` = non-secret base URL

Secrets must never be committed.
