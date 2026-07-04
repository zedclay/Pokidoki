# Main App Navigation

## Three-tab shell

After App Lock unlock, the app opens the authenticated shell:

| Tab | Route | Screen |
| --- | --- | --- |
| Chats | `/app/chats` | Conversations Home |
| Contacts | `/app/contacts` | Contacts |
| Settings | `/app/settings` | Settings (real screen) |

Implemented with `StatefulShellRoute.indexedStack` so tab state is preserved.

## Bottom-navigation visibility

Shown only on the three root tab screens.

Hidden on pushed screens:

- New Conversation (`/chats/new`)
- User Search (`/users/search`)
- User Profile Preview (`/users/:userId`)
- Contact Requests (`/contacts/requests`)
- QR Scanner (`/security/qr-scanner`)
- My QR Code (`/security/my-qr`)
- Contact Verification (`/security/contact-verification/:userId`)
- Safety Number (`/security/safety-number/:userId`)
- Settings destinations under `/settings/*`
- Batch 7 placeholders (change password, email, recovery, report)

## Settings

Settings is implemented. See `docs/SETTINGS_ARCHITECTURE.md`.
