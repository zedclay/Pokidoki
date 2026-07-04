# Pokidoki Design System

Centralized tokens and components live under `lib/design_system/`.

Screens must consume tokens and components instead of hardcoding colors, spacing, radii, or typography.

## Color tokens

### Dark (default)

| Token | Value | Usage |
| --- | --- | --- |
| background | `#090B10` | Main background |
| surface | `#12151C` | Primary surface |
| surfaceElevated | `#191D26` | Elevated surface |
| surfaceSecondary | `#202530` | Secondary surface |
| primary | `#7C6CFF` | Brand and primary actions |
| primaryPressed | `#6858E8` | Pressed primary |
| secure | `#32D6A0` | Verified, protected, success only |
| textPrimary | `#F7F7FA` | Primary text |
| textSecondary | `#A7ACB8` | Secondary text |
| textTertiary | `#858B98` | Tertiary text |
| border | `#292E39` | Borders and dividers |
| error | `#FF5D6C` | Errors and destructive actions |
| warning | `#F5B942` | Warnings |
| information | `#62A8FF` | Informational states |

### Light

| Token | Value |
| --- | --- |
| background | `#F7F7FA` |
| surface | `#FFFFFF` |
| surfaceElevated | `#F0F1F5` |
| primary | `#6554E8` |
| secure | `#148A69` |
| textPrimary | `#161820` |
| textSecondary | `#656A76` |
| border | `#DFE1E7` |

### Color rules

- Purple is brand identity and primary actions.
- Green is reserved for secure, verified, protected, or successful states.
- Red is reserved for destructive actions, errors, and blocked status.
- Yellow is for warnings.
- Blue is for information.
- Do not use secure green decoratively.
- Avoid excessive gradients and glows.

## Spacing

`4, 8, 12, 16, 20, 24, 32, 40, 48, 64`

Minimum touch target: `48 × 48`.

## Radii

| Token | Value | Usage |
| --- | --- | --- |
| sm | 8 | Small controls |
| md | 12 | Inputs and chips |
| lg | 14 | Buttons |
| xl | 18 | Cards |
| chatBubble | 20 | Chat bubbles |
| modal | 24 | Modals and bottom sheets |

## Typography

Latin scripts (English, French): Inter via `google_fonts`.

Arabic: Noto Sans Arabic via `google_fonts`.

Styles:

- Display
- Screen title
- Section title
- Card title
- Body
- Supporting body
- Caption
- Button
- Input label
- Metadata
- Badge
- Chat message

Text styles support dynamic type scaling. Avoid fixed heights that clip larger accessibility text.

## Icons

Prefer Material rounded icons (`*_rounded`) for a consistent family.

Icons are never the only indication of meaning. Interactive icons require:

- Tooltip where appropriate
- Semantic label
- Minimum 48 × 48 touch target

## Components

Reusable components include layout, buttons, cards, inputs, settings rows, identity widgets, feedback states, and messaging foundations.

Use these components before inventing screen-local equivalents.

## Theme behavior

- Dark mode is the default (`ThemeMode.dark`).
- Light theme is fully defined and selectable later from Appearance settings.
- Themes are built by `PokidokiTheme` and exposed through `ThemeExtension`s.
