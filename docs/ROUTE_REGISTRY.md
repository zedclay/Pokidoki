# Route Registry

Generated from `lib/app/routing/app_router.dart` and `route_names.dart` during final global QA.

## Main tabs (StatefulShellRoute)

Exactly three branches — Chats, Contacts, Settings. No fourth tab.

| Route | Screen | Bottom nav | Auth | Mock |
| --- | --- | --- | --- | --- |
| `/app/chats` | Conversations Home | Yes | After mock sign-in | Mock messaging |
| `/app/contacts` | Contacts | Yes | After mock sign-in | Mock graph |
| `/app/settings` | Settings | Yes | After mock sign-in | Mock + local prefs |

## Entry and onboarding

| Route | Screen | Params | Bottom nav | Auth | Mock |
| --- | --- | --- | --- | --- | --- |
| `/splash` | Splash | — | No | No | Bootstrap |
| `/onboarding` | Onboarding (3 pages) | — | No | No | Mock |
| `/welcome` | Welcome | — | No | No | Mock |

## Authentication and security setup

| Route | Screen | Params | Bottom nav | Auth | Mock |
| --- | --- | --- | --- | --- | --- |
| `/auth/create-account` | Create Account | — | No | No | Mock auth |
| `/auth/sign-in` | Sign In | — | No | No | Mock auth |
| `/auth/email-verification` | Email Verification | — | No | No | Mock code |
| `/auth/username-setup` | Username Setup | — | No | No | Mock |
| `/auth/profile-setup` | Profile Setup | — | No | Mock |
| `/security/create-pin` | Create PIN | `?mode=settings` optional | No | No | Mock PIN |
| `/security/confirm-pin` | Confirm PIN | `?mode=settings` optional | No | No | Mock PIN |
| `/security/enable-biometrics` | Enable Biometrics | — | No | No | Mock |
| `/security/app-lock` | App Lock | — | No | No | Mock lock |

## Social and messaging

| Route | Screen | Params | Bottom nav | Auth | Mock |
| --- | --- | --- | --- | --- | --- |
| `/chats/new` | New Conversation | — | No | Yes | Mock |
| `/users/search` | User Search | — | No | Yes | Mock |
| `/users/:userId` | User Profile Preview | `userId` (non-sensitive ID) | No | Yes | Mock |
| `/contacts/requests` | Contact Requests | — | No | Yes | Mock |
| `/chats/:conversationId` | One-to-One Chat | `conversationId` | No | Yes | Mock messaging |
| `/chats/:conversationId/info` | Conversation Information | `conversationId` | No | Yes | Mock |
| `/chats/:conversationId/search` | Conversation Search | `conversationId` | No | Yes | Mock |
| `/chats/:conversationId/shared` | Shared Media and Files | `conversationId` | No | Yes | Mock |
| `/chats/:conversationId/disappearing-messages` | Disappearing Messages | `conversationId` | No | Yes | Mock |

## Verification

| Route | Screen | Params | Bottom nav | Auth | Mock |
| --- | --- | --- | --- | --- | --- |
| `/security/qr-scanner` | QR Scanner | — | No | Yes | Mock camera |
| `/security/my-qr` | My QR Code | — | No | Yes | Mock |
| `/security/contact-verification/:userId` | Contact Verification | `userId` | No | Yes | Mock |
| `/security/safety-number/:userId` | Safety Number | `userId` | No | Yes | Mock |

## Settings (pushed)

| Route | Screen | Params | Bottom nav | Auth | Mock |
| --- | --- | --- | --- | --- | --- |
| `/settings/account` | Account Management | — | No | Yes | Mock |
| `/settings/account/change-password` | Change Password | — | No | Yes | Mock |
| `/settings/account/email` | Email Management | — | No | Yes | Mock email |
| `/settings/account/recovery` | Account Recovery | — | No | Yes | Mock recovery |
| `/settings/linked-devices` | Linked Devices | — | No | Yes | Mock |
| `/settings/security-activity` | Security Activity | — | No | Yes | Mock |
| `/settings/security-activity/:eventId` | Security Event Detail | `eventId` | No | Yes | Mock |
| `/settings/blocked-users` | Blocked Users | — | No | Yes | Mock |
| `/settings/app-lock` | App Lock Settings | — | No | Yes | Mock |
| `/settings/appearance` | Appearance | — | No | Yes | Local theme |
| `/settings/language` | Language | — | No | Yes | Local locale |
| `/settings/storage` | Storage Usage | — | No | Yes | Mock |

## Safety

| Route | Screen | Params | Bottom nav | Auth | Mock |
| --- | --- | --- | --- | --- | --- |
| `/report/:userId` | Report User | `userId` | No | Yes | Mock moderation |

## Legacy redirects

| Route | Redirect |
| --- | --- |
| `/dev/conversations-home` | `/app/chats` |
| `/dev/account-recovery` | `/settings/account/recovery` |
| `/dev/report-user` | `/report/u-riad` |
| `/chats/conv-amira` | *(legacy alias — use parameterized route)* |

## Dev-only

| Route | Screen | Notes |
| --- | --- | --- |
| `/dev/placeholder` | Dev placeholder | Internal |
| `/dev/pin-recovery` | Dev placeholder | PIN recovery not in scope |

## Error handling

| Condition | Screen |
| --- | --- |
| Unknown path | `RouteNotFoundScreen` — safe message + “Go to Welcome” |

## Sensitive data policy

Routes must **not** carry passwords, PINs, verification codes, message text, report details, or full email addresses. Only opaque IDs (`userId`, `conversationId`, `eventId`) are used in paths.

## Navigation behavior

- **Back:** `SettingsAppBar` and standard app bars call `context.pop()`.
- **Android system back:** `PopScope` on onboarding; shell tabs preserve branch state via `StatefulShellRoute.indexedStack`.
- **Sign-out:** Clears auth flow state; navigates to Welcome; theme and language persist.
- **Deep links:** Route structure is ready; production auth guards not yet wired.
