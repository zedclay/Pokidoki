# Authentication UI Flow (Batch 2)

## Account creation

```text
Welcome
→ Create Account
→ Email Verification
→ Username Setup
→ Profile Setup
→ Create PIN
→ Confirm PIN
→ Enable Biometrics
→ App Lock
→ /dev/conversations-home (placeholder)
```

## Sign in

```text
Welcome
→ Sign In
→ App Lock
→ /dev/conversations-home (placeholder)
```

## Mock behavior

| Concern | Behavior |
| --- | --- |
| Create account | Always succeeds after a short delay |
| Sign in | Succeeds unless password is exactly `wrong` |
| Email verification | Accepts development code `123456` only |
| Username availability | Reserved: `admin`, `pokidoki`, `support` |
| App PIN | In-memory only; development fallback `123456` when no setup PIN exists |
| Biometrics | Mock enabled/disabled flag; no OS dialog |

Development code and PIN are documented here only. They are never shown in the UI.

## Sensitive data rules

- Passwords, PINs, and verification codes stay in memory for the active flow.
- Values are cleared after successful unlock (`clearSensitiveFlow`).
- Never placed in route URLs, logs, preferences, or analytics.
- Emails are shown masked on verification (`h••••@example.com` style).

## Sign-out (Batch 6)

Settings and Account Management share `confirmAndSignOut`:

- Clears in-memory auth flow state (including temporary PIN values)
- Sets presentation status to unauthenticated
- Returns to Welcome
- Preserves theme and language preferences

Does not revoke backend sessions.

## App Lock Settings (Batch 6)

`/settings/app-lock` edits mock preferences and can start Change PIN via Create PIN / Confirm PIN with `?mode=settings` without restarting onboarding.

## Account security (Batch 7)

Change Password and Account Recovery update the mock account password in `MockAccountSecurityRepository`. App PIN remains separate and unchanged by recovery.

See `docs/ACCOUNT_SECURITY_UI.md`, `docs/EMAIL_MANAGEMENT_FLOW.md`, and `docs/ACCOUNT_RECOVERY_FLOW.md`.

## Future integration points

- Replace `MockAuthenticationRepository` with a real API implementation.
- Store the app PIN through platform secure storage.
- Integrate audited biometric APIs (`local_auth` or native bridges) behind the existing mock boundary.
