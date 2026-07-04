# Responsive Layout QA

Viewports and overflow behavior verified during final global QA.

## Tested viewports

| Size | Use case | Result |
| --- | --- | --- |
| 320 × 568 | Small phone | Welcome scroll + compact padding; nav icon-only below 360 px width |
| 360 × 800 | Common Android | Pass |
| 390 × 844 | Primary design target | Pass (incl. French bottom nav after fix) |
| 430 × 932 | Large phone | Pass |

Additional: large text scale 1.4× on Settings; keyboard-safe scroll on form screens via `SingleChildScrollView` / scaffold resize.

## Fixes applied in final QA

| Area | Fix |
| --- | --- |
| Welcome | Compact padding and logo on narrow widths; `FittedBox` on language chip |
| Bottom navigation | `FittedBox` labels; icon-only below 360 px; width constraint fix |
| Onboarding header | `Flexible` + `FittedBox` on brand row (French overflow) |
| Settings rows | Title/subtitle ellipsis |
| Primary buttons | `FittedBox` labels; reduced horizontal padding on narrow screens |
| Conversation rows | `Expanded` on name column |

## Keyboard and focus

Form screens (auth, recovery, report, chat composer, search) use appropriate `TextInputAction`, email/numeric keyboard types, and scrollable bodies. PIN uses custom keypad (not system keyboard).

## Remaining minor discrepancies

- Very long French/German-scale strings may still truncate with ellipsis — acceptable.
- Theme preview cards use fixed preview dimensions by design.
- QR frame scales with viewport; production camera preview aspect ratio may differ.

## Screenshots

Critical matrix captured at 390 × 844 under `artifacts/ui_comparisons/final/` including light mode, Arabic RTL, French, and 320 px welcome variant.
