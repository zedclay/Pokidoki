# Mock Social Graph

Batch 3 uses in-memory mock data via `SocialGraphController`.

## Conversations

Pinned and recent conversations include Amira, Yacine, Lina, Karim, Nour, Samir, and Maya with previews, timestamps, unread counts, mute/pin/disappearing indicators.

## Contacts

Connected contacts: Amira, Karim, Lina, Maya, Nour, Samir.

Verified section highlights verified contacts.

## Contact requests

Received: Yasmine A., Sofiane K.

Sent: Nadia A.

Accept adds the person to contacts and removes the request.

Decline removes the request.

## User search

Directory users include Amira Mansouri, Amira Rahal, Meriem Amira, Yasmine A., Sofiane K., and Riad B.

Search matches display name, username, and Pokidoki ID with a short debounce.

## Profile preview

Profiles are privacy-safe (no email/phone). Send contact request transitions relationship to pending outgoing.

## Verification (Batch 4)

Amira starts unverified. Marking verified via Safety Number updates contacts, conversations, and profile previews through `SocialGraphController.markVerified`.

Mock QR payloads and safety-number groups live in `MockSampleData`.

## Blocked users (Batch 6)

`SocialGraphController` owns `blockedUsers`. Initial mock entries: Riad B., Nadia A.

Blocking from Conversation Information (`MessagingController.setBlocked`) adds the peer to this list and sets `conversation.isBlocked`. Unblocking from Settings → Blocked Users removes the entry and re-enables the chat composer.

## Future integration

Replace `SocialGraphController` / mock sample data with API repositories without changing presentation widgets.
