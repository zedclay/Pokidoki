# Stitch Reference Manifest

## Batch 5

| Screen | PNG | HTML | Size | Route | Implementation |
| --- | --- | --- | --- | --- | --- |
| One-to-One Chat | `pokidoki_one_to_one_chat_screen screen.png` | `… code.html` | 780×2286 | `/chats/:conversationId` | `one_to_one_chat_screen.dart` |
| Conversation Information | `pokidoki_conversation_information_screen screen.png` | `… code.html` | 352×1600 | `/chats/:conversationId/info` | `conversation_info_screen.dart` |
| Conversation Search | `pokidoki_conversation_search_screen screen.png` | `… code.html` | 669×1600 | `/chats/:conversationId/search` | `conversation_search_screen.dart` |
| Shared Media and Files | `pokidoki_shared_content_screen screen.png` | `… code.html` | 606×1600 | `/chats/:conversationId/shared` | `shared_content_screen.dart` |
| Disappearing Messages | `pokidoki_disappearing_messages_screen screen.png` | `… code.html` | 408×1600 | `/chats/:conversationId/disappearing-messages` | `disappearing_messages_screen.dart` |

All five pairs found. Screenshots: `artifacts/ui_comparisons/batch_05/`.

## Batch 6

| Screen / state | PNG | HTML | Size | Route | Main Dart | Runtime assets | Visual review | Tests | Remaining discrepancy |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Settings | `pokidoki_settings_screen screen.png` | `… code.html` | 780×3070 | `/app/settings` | `settings_screen.dart` | Design-system icons | Screenshot vs Stitch | Pass | Preferences section added for Appearance/Language/Storage (required routes, not in Stitch list) |
| Account Management | `pokidoki_account_management_screen screen.png` | `… code.html` | 780×2514 | `/settings/account` | `account_management_screen.dart` | — | Screenshot vs Stitch | Pass | Minor spacing |
| Linked Devices | `pokidoki_linked_devices_screen screen.png` | `… code.html` | 470×1600 | `/settings/linked-devices` | `linked_devices_screen.dart` | — | Screenshot vs Stitch | Pass | Minor card density |
| Security Activity (list + attention) | `pokidoki_security_activity_screen_1 screen.png` | `… code.html` | 352×1600 | `/settings/security-activity` | `security_activity_screen.dart` | — | Screenshot vs Stitch | Pass | Combined with filters from screen 2 |
| Security Activity (filters) | `pokidoki_security_activity_screen_2 screen.png` | `… code.html` | 635×1600 | `/settings/security-activity` (+ Devices filter) | `security_activity_screen.dart` | — | Screenshot vs Stitch | Pass | Same screen; detail at `/:eventId` |
| Blocked Users | `pokidoki_blocked_users_screen screen.png` | `… code.html` | 780×1674 | `/settings/blocked-users` | `blocked_users_screen.dart` | — | Screenshot vs Stitch | Pass | Shared block state may include Amira |
| App Lock Settings | `pokidoki_app_lock_settings_screen screen.png` | `… code.html` | 311×1600 | `/settings/app-lock` | `app_lock_settings_screen.dart` | — | Screenshot vs Stitch | Pass | Subset of Stitch rows (mock-only) |
| Appearance | `pokidoki_appearance_screen screen.png` | `… code.html` | 780×2714 | `/settings/appearance` | `appearance_screen.dart` | Theme previews | Screenshot vs Stitch | Pass | Chat preview block omitted |
| Language | `pokidoki_language_screen screen.png` | `… code.html` | 780×2186 | `/settings/language` | `language_screen.dart` | — | Screenshot vs Stitch | Pass | Minor preview card layout |
| Storage Usage | `pokidoki_storage_usage_screen screen.png` | `… code.html` | 780×1932 | `/settings/storage` | `storage_usage_screen.dart` | Custom bar chart | Screenshot vs Stitch | Pass | Segmented bar vs Stitch proportions |

**Security Activity interpretation:** screen_1 and screen_2 are one feature (attention banner + filters), not two unrelated products. Detail uses `/settings/security-activity/:eventId`.

Screenshots: `artifacts/ui_comparisons/batch_06/`.

## Batch 7

| Screen / state | PNG | HTML | Size | Route | Main Dart | Shared widgets | Visual review | Tests | Remaining discrepancy |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Change Password | `pokidoki_change_password_screen screen.png` | `… code.html` | 388×1600 | `/settings/account/change-password` | `change_password_screen.dart` | `SecurePasswordField`, `PasswordRequirementList` | Screenshot vs Stitch | Pass | Minor spacing |
| Email Management | `pokidoki_email_management_screen screen.png` | `… code.html` | 780×3076 | `/settings/account/email` | `email_management_screen.dart` | Settings cards, verification input | Screenshot vs Stitch | Pass | Change/verify as internal steps |
| Account Recovery | `pokidoki_account_recovery_screen screen.png` | `… code.html` | 504×1600 | `/settings/account/recovery` | `account_recovery_screen.dart` | Step cards, code input | Screenshot vs Stitch | Pass | Multi-step internal states |
| Report User | `pokidoki_report_user_screen screen.png` | `… code.html` | 340×1600 | `/report/:userId` | `report_user_screen.dart` | Reason rows, evidence picker | Screenshot vs Stitch | Pass | Evidence picker is bottom sheet |

Screenshots: `artifacts/ui_comparisons/batch_07/`.
