# Accessibility QA

Audit of touch targets, semantics, contrast, and dynamic text across implemented screens.

## Touch targets

- Design token: `PokidokiSpacing.minTouchTarget` = 48 dp.
- Buttons default height 52 dp; icon buttons and PIN keypad keys meet or exceed 48 dp.
- Bottom navigation tabs use full-width `InkWell` with semantic labels.

## Semantics implemented

| Feature | Semantics |
| --- | --- |
| Bottom navigation | `button`, `selected`, label per tab |
| Language / theme options | `selected`, `button`, descriptive label |
| Verification status | Verified badge semantics on contacts and chat app bars |
| PIN entry | Digit count progress without exposing digits |
| QR scanner | Frame described; simulate control debug-only |
| Safety number | Grouped blocks; copy action labeled |
| Report reasons | Radio selection state |
| Loading / error | `liveRegion` on splash; snackbars for success/error |
| Welcome features | Row-level semantic labels |

## Contrast and themes

- Dark mode is default when no preference is stored.
- Light and dark themes use `PokidokiColors` tokens — primary, secure green, error red, warning yellow, info blue.
- Appearance screen previews both theme variants.

## Dynamic text

- Settings and welcome rows use `maxLines` + ellipsis where needed.
- Buttons use `FittedBox` for label scaling on narrow widths.
- Large text scale (1.4×) tested on Settings — no overflow exceptions.

## Reduced motion

- Splash animation skipped when `prefersReducedMotion` is true.

## Remaining limitations

- Not all list tiles have custom semantic hints beyond defaults.
- Storage chart is visual-first; summary text available but not fully enumerated for screen readers.
- Mock delivery ticks (sent/delivered) rely on icon semantics without granular live regions.
- Production TalkBack/VoiceOver pass on physical devices recommended before release.

## Sensitive data in semantics

PIN digits, passwords, verification codes, and safety numbers are **not** exposed in semantic labels. Labels describe role and state only.
