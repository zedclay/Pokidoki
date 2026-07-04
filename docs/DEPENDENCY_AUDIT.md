# Dependency Audit

From `pubspec.yaml` after final QA (`flutter pub get`, July 2026).

## Runtime dependencies

| Package | Version | Purpose | Used | Native config | Production-ready | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| `flutter` | SDK | Framework | Yes | Yes | Yes | — |
| `flutter_localizations` | SDK | l10n | Yes | No | Yes | — |
| `cupertino_icons` | ^1.0.8 | iOS-style icons | Yes | No | Yes | Tree-shaken in release |
| `flutter_riverpod` | ^2.6.1 | State management | Yes | No | Yes | v3 available; not upgraded |
| `go_router` | ^14.8.1 | Navigation | Yes | No | Yes | v17 available; stable on 14.x |
| `google_fonts` | ^6.2.1 | Typography | Yes | No | Yes | Runtime font fetch |
| `intl` | any (0.20.2) | Formatting | Yes | No | Yes | SDK-pinned |
| `qr_flutter` | ^4.1.0 | QR display | Yes | No | Yes | Display only; no scanner |

## Dev dependencies

| Package | Purpose |
| --- | --- |
| `flutter_test` | Widget/unit tests |
| `flutter_lints` | Analyzer rules |

## Transitive highlights

- `path_provider` (via google_fonts) — font caching only.
- No camera, biometric, Firebase, HTTP client, or encryption packages.

## Unused packages removed

None — all declared direct dependencies are referenced.

## Outdated packages (documented, not upgraded)

`flutter pub outdated` reports newer major versions for `go_router`, `flutter_riverpod`, `google_fonts`, `qr`, etc. Upgrades deferred to avoid regression during UI freeze.

## Production additions (future)

See `docs/PRODUCTION_INTEGRATION_ROADMAP.md` for planned packages (secure storage, WebSocket client, camera, local DB, push, crash reporting).
