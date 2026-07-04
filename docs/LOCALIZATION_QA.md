# Localization QA

Languages: **English (en)**, **Arabic (ar)**, **French (fr)** via Flutter gen-l10n (`lib/l10n/app_*.arb`).

## Coverage summary

| Locale | ARB file | Status |
| --- | --- | --- |
| English | `app_en.arb` | Complete for all product screens |
| Arabic | `app_ar.arb` | Complete; RTL verified |
| French | `app_fr.arb` | Complete; overflow fixes applied |

Automated matrix: `test/final/global_qa_regression_test.dart` — critical screens (Welcome, Chats, Settings, Appearance, Language) render in all three locales without exceptions.

## RTL rules (Arabic)

- App uses locale-driven `Directionality` from Flutter localization.
- Arabic typography: Noto Sans Arabic via theme (`PokidokiTheme`).
- Mirrored: app bars, back icons, settings chevrons, bottom navigation order.
- **LTR preserved** for: usernames, Pokidoki IDs, emails, URLs, safety numbers, verification codes, PIN indicators, file extensions, times (via `LtrText` / `Directionality` wrappers where needed).
- Message bubble alignment follows sender (not reversed purely because UI is RTL).

## French notes

- Accents verified in ARB strings.
- Bottom navigation labels use `FittedBox` scaling to prevent overflow (“Discussions”, “Réglages”).
- Welcome screen uses compact button letter-spacing when locale is French.
- Settings rows use `maxLines` + ellipsis for long subtitles.

## Hardcoded strings audit

User-facing Dart literals in `lib/` are limited to:

- Language preview cards on Language screen (native language names — intentional)
- Theme preview “Aa” glyph
- Mock weekday abbreviations in conversation timestamps (EN short names — acceptable mock limitation)
- Non-translatable mock filenames and sample usernames in mock data

No product screen titles or primary actions remain hardcoded in English only.

## Known limitations

- Help placeholder text is translated but content is stub-only.
- Dev placeholder l10n keys exist for unused dev routes.
- Some mock data display names remain Latin script by design.
- Full every-screen × every-language widget matrix is covered by a balanced subset plus route navigation tests; expanding to all 44 screens × 3 locales is optional future work.

## Locale switching

`localeOverrideProvider` + `setAppLocale` update the entire app without duplicate locale state. Sign-out preserves theme and language choices.
