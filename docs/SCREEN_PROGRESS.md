# Pokidoki Final Screen Registry

Authoritative registry after global UI QA (Batches 1–7). Sequential numbers replace earlier onboarding sublabels. **44** approved product screens are implemented. **Delete Account** is intentionally absent.

Legend: **Nav** = bottom navigation visible. **Mock** = in-memory mock data; **Local** = device preference only.

| # | Screen | Route | Main Dart | Stitch PNG | Stitch HTML | Status | Visual | Tests | Nav | Behavior |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | Splash | `/splash` | `splash_screen.dart` | Batch 1 | Batch 1 | Done | Reviewed | Pass | Hidden | Mock bootstrap |
| 2 | Onboarding — Privacy | `/onboarding` p0 | `onboarding_flow_screen.dart` | Batch 1 | Batch 1 | Done | Reviewed | Pass | Hidden | Mock |
| 3 | Onboarding — Verification | `/onboarding` p1 | `onboarding_flow_screen.dart` | Batch 1 | Batch 1 | Done | Reviewed | Pass | Hidden | Mock |
| 4 | Onboarding — App Lock | `/onboarding` p2 | `onboarding_flow_screen.dart` | Batch 1 | Batch 1 | Done | Reviewed | Pass | Hidden | Mock |
| 5 | Welcome | `/welcome` | `welcome_screen.dart` | Batch 1 | Batch 1 | Done | Reviewed | Pass | Hidden | Mock |
| 6 | Create Account | `/auth/create-account` | `create_account_screen.dart` | Batch 2 | Batch 2 | Done | Reviewed | Pass | Hidden | Mock auth |
| 7 | Sign In | `/auth/sign-in` | `sign_in_screen.dart` | Batch 2 | Batch 2 | Done | Reviewed | Pass | Hidden | Mock auth |
| 8 | Email Verification | `/auth/email-verification` | `email_verification_screen.dart` | Batch 2 | Batch 2 | Done | Reviewed | Pass | Hidden | Mock email |
| 9 | Username Setup | `/auth/username-setup` | `username_setup_screen.dart` | Batch 2 | Batch 2 | Done | Reviewed | Pass | Hidden | Mock |
| 10 | Profile Setup | `/auth/profile-setup` | `profile_setup_screen.dart` | Batch 2 | Batch 2 | Done | Reviewed | Pass | Hidden | Mock |
| 11 | Create PIN | `/security/create-pin` | `create_pin_screen.dart` | Batch 2 | Batch 2 | Done | Reviewed | Pass | Hidden | Mock PIN |
| 12 | Confirm PIN | `/security/confirm-pin` | `confirm_pin_screen.dart` | Batch 2 | Batch 2 | Done | Reviewed | Pass | Hidden | Mock PIN |
| 13 | Enable Biometrics | `/security/enable-biometrics` | `enable_biometrics_screen.dart` | Batch 2 | Batch 2 | Done | Reviewed | Pass | Hidden | Mock biometrics |
| 14 | App Lock | `/security/app-lock` | `app_lock_screen.dart` | Batch 2 | Batch 2 | Done | Reviewed | Pass | Hidden | Mock lock |
| 15 | Conversations Home | `/app/chats` | `conversations_home_screen.dart` | Batch 3 | Batch 3 | Done | Reviewed | Pass | **Yes** | Mock messaging |
| 16 | New Conversation | `/chats/new` | `new_conversation_screen.dart` | Batch 3 | Batch 3 | Done | Reviewed | Pass | Hidden | Mock |
| 17 | User Search | `/users/search` | `user_search_screen.dart` | Batch 3 | Batch 3 | Done | Reviewed | Pass | Hidden | Mock |
| 18 | User Profile Preview | `/users/:userId` | `user_profile_preview_screen.dart` | Batch 3 | Batch 3 | Done | Reviewed | Pass | Hidden | Mock |
| 19 | Contacts | `/app/contacts` | `contacts_screen.dart` | Batch 3 | Batch 3 | Done | Reviewed | Pass | **Yes** | Mock |
| 20 | QR Scanner | `/security/qr-scanner` | `qr_scanner_screen.dart` | Batch 4 | Batch 4 | Done | Reviewed | Pass | Hidden | Mock camera |
| 21 | My QR Code | `/security/my-qr` | `my_qr_code_screen.dart` | Batch 4 | Batch 4 | Done | Reviewed | Pass | Hidden | Mock |
| 22 | Contact Verification | `/security/contact-verification/:userId` | `contact_verification_screen.dart` | Batch 4 | Batch 4 | Done | Reviewed | Pass | Hidden | Mock |
| 23 | Safety Number | `/security/safety-number/:userId` | `safety_number_screen.dart` | Batch 4 | Batch 4 | Done | Reviewed | Pass | Hidden | Mock |
| 24 | One-to-One Chat | `/chats/:conversationId` | `one_to_one_chat_screen.dart` | Batch 5 | Batch 5 | Done | Reviewed | Pass | Hidden | Mock messaging |
| 25 | Conversation Information | `/chats/:conversationId/info` | `conversation_info_screen.dart` | Batch 5 | Batch 5 | Done | Reviewed | Pass | Hidden | Mock |
| 26 | Conversation Search | `/chats/:conversationId/search` | `conversation_search_screen.dart` | Batch 5 | Batch 5 | Done | Reviewed | Pass | Hidden | Mock |
| 27 | Shared Media and Files | `/chats/:conversationId/shared` | `shared_content_screen.dart` | Batch 5 | Batch 5 | Done | Reviewed | Pass | Hidden | Mock placeholders |
| 28 | Contact Requests | `/contacts/requests` | `contact_requests_screen.dart` | Batch 3 | Batch 3 | Done | Reviewed | Pass | Hidden | Mock |
| 29 | Settings | `/app/settings` | `settings_screen.dart` | Batch 6 | Batch 6 | Done | Reviewed | Pass | **Yes** | Mock + local prefs |
| 30 | Account Management | `/settings/account` | `account_management_screen.dart` | Batch 6 | Batch 6 | Done | Reviewed | Pass | Hidden | Mock |
| 31 | Linked Devices | `/settings/linked-devices` | `linked_devices_screen.dart` | Batch 6 | Batch 6 | Done | Reviewed | Pass | Hidden | Mock |
| 32 | Security Activity | `/settings/security-activity` | `security_activity_screen.dart` | Batch 6 | Batch 6 | Done | Reviewed | Pass | Hidden | Mock |
| 33 | Blocked Users | `/settings/blocked-users` | `blocked_users_screen.dart` | Batch 6 | Batch 6 | Done | Reviewed | Pass | Hidden | Mock |
| 34 | App Lock Settings | `/settings/app-lock` | `app_lock_settings_screen.dart` | Batch 6 | Batch 6 | Done | Reviewed | Pass | Hidden | Mock |
| 35 | Appearance | `/settings/appearance` | `appearance_screen.dart` | Batch 6 | Batch 6 | Done | Reviewed | Pass | Hidden | Local theme |
| 36 | Disappearing Messages | `/chats/:conversationId/disappearing-messages` | `disappearing_messages_screen.dart` | Batch 5 | Batch 5 | Done | Reviewed | Pass | Hidden | Mock |
| 37 | Language | `/settings/language` | `language_screen.dart` | Batch 6 | Batch 6 | Done | Reviewed | Pass | Hidden | Local locale |
| 38 | Storage Usage | `/settings/storage` | `storage_usage_screen.dart` | Batch 6 | Batch 6 | Done | Reviewed | Pass | Hidden | Mock |
| 39 | Change Password | `/settings/account/change-password` | `change_password_screen.dart` | Batch 7 | Batch 7 | Done | Reviewed | Pass | Hidden | Mock |
| 40 | Email Management | `/settings/account/email` | `email_management_screen.dart` | Batch 7 | Batch 7 | Done | Reviewed | Pass | Hidden | Mock email |
| 41 | Account Recovery | `/settings/account/recovery` | `account_recovery_screen.dart` | Batch 7 | Batch 7 | Done | Reviewed | Pass | Hidden | Mock recovery |
| 42 | Report User | `/report/:userId` | `report_user_screen.dart` | Batch 7 | Batch 7 | Done | Reviewed | Pass | Hidden | Mock moderation |
| 43 | Security Event Detail | `/settings/security-activity/:eventId` | `security_activity_screen.dart` | Batch 6 | Batch 6 | Done | Reviewed | Pass | Hidden | Mock |
| 44 | Route Not Found | *(error route)* | `route_not_found_screen.dart` | — | — | Done | N/A | Pass | Hidden | Safe fallback |

### Sub-route note

Numbers 26–27 in an earlier draft mapped to Conversation Search and Shared Content; Contact Requests is #28. This table uses one sequential product order aligned with user flows.

## Not implemented

| Screen | Status | Notes |
| --- | --- | --- |
| **Delete Account** | **Not implemented — no approved Stitch reference** | Account Management shows unavailable snackbar (`settingsDeleteAccountUnavailable`) |

## Dev / legacy routes

| Route | Resolves to |
| --- | --- |
| `/dev/conversations-home` | Redirect → `/app/chats` |
| `/dev/account-recovery` | Redirect → `/settings/account/recovery` |
| `/dev/report-user` | Redirect → `/report/u-riad` |
| `/dev/pin-recovery` | `DevPlaceholderScreen` (PIN recovery out of scope) |
| `/dev/placeholder` | Generic dev placeholder |

## Screenshots

Final matrix: `artifacts/ui_comparisons/final/`  
Batch archives: `artifacts/ui_comparisons/batch_01/` … `batch_07/`
