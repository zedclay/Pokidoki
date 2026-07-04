# Pokidoki Project Setup

## Requirements

- Flutter `3.38.3` or compatible stable release
- Dart `3.10.1` or compatible SDK (`sdk: ^3.10.1` in `pubspec.yaml`)
- Xcode for iOS builds
- Android Studio / Android SDK for Android builds

## Installation

```bash
flutter pub get
```

Localization classes are generated automatically by Flutter because `generate: true` is set in `pubspec.yaml` and `l10n.yaml` is present.

## Running the app

```bash
flutter run
```

Optional environment defines:

```bash
flutter run \
  --dart-define=APP_ENV=development \
  --dart-define=API_BASE_URL=https://api.example.pokidoki.invalid
```

Never pass real secrets through source control. Prefer local, untracked mechanisms for credentials.

## Analysis

```bash
dart format .
flutter analyze
```

## Tests

```bash
flutter test
```

## Localization

ARB sources:

- `lib/l10n/app_en.arb`
- `lib/l10n/app_ar.arb`
- `lib/l10n/app_fr.arb`

Generated output is produced under `.dart_tool/flutter_gen/gen_l10n/` and imported as `package:pokidoki/l10n/app_localizations.dart`.

Supported languages:

| Language | Locale | Direction | Font |
| --- | --- | --- | --- |
| English | `en` | LTR | Inter |
| Arabic | `ar` | RTL | Noto Sans Arabic |
| French | `fr` | LTR | Inter |

Initial locale follows the device when supported; otherwise English.

## Environment handling

`AppEnvironment` and `AppConfig` provide a safe non-secret configuration foundation.

Example values are documented in `docs/env.example.md`.

Do not commit:

- `.env` files with secrets
- API keys
- signing passwords
- private certificates

## Platform identifiers

Preserved from the generated project:

- Android application id: `com.example.pokidoki`
- iOS bundle identifier: `com.example.pokidoki`
