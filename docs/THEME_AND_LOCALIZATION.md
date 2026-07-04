# Theme and Localization

## Theme controller

Single source: `themeModeProvider` (`StateProvider<ThemeMode>`), default `ThemeMode.dark`.

Appearance screen updates this provider immediately. `PokidokiApp` watches it and applies `PokidokiTheme.light()` / `PokidokiTheme.dark()`.

Bootstrap may load a mock theme name from `UserRepository.getAccountSettings()` on splash; Appearance remains the interactive control for Batch 6.

## Locale controller

Single source: `localeOverrideProvider` (`StateProvider<Locale?>`).

`setAppLocale(ref, locale)` updates the override. `PokidokiApp` resolves supported locales (en, ar, fr) and applies directionality.

Language screen options keep native names:

- English
- العربية
- Français

## Persistence

Theme and language use in-memory Riverpod state for this UI batch. Non-sensitive preferences may later use the existing account-settings mock path. No secure storage package was added.

## RTL rules

When Arabic is active:

- App shell and settings chevrons/back affordances follow RTL
- Usernames, Pokidoki IDs, emails, and safety numbers stay LTR via `LtrText`
- Message ownership remains logical (outgoing/incoming), not merely right-aligned text

## Font rules

`PokidokiTypography` supplies Inter-based styles. Tests disable network fonts via `PokidokiTypography.useNetworkFonts = false`.

## Light-theme limitations

Light tokens exist in `PokidokiColors.light`. Batch 1–6 screens use shared tokens; Stitch references remain dark-first. Light mode is usable for Settings, Chats, Contacts, Chat, App Lock, Appearance, and Language without a full redesign of every reference.
