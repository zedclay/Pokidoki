# Email Management Flow

Route: `/settings/account/email`

## Overview

- Masked email only (`z••••••@example.com` initially)
- Verified status and last-verified date
- Security alerts and recovery alerts always on
- New-device alerts toggleable
- Optional product updates and research invitations (off by default)
- Email is not shown to contacts

## Change email

1. Reauthenticate with current password
2. Enter new email
3. Verify with six-digit code (mock: `123456`)
4. Update masked email and mark verified

Conflict text is privacy-preserving:

```text
This email cannot be used for this account.
```

Security Activity events: `Email change requested`, `Email changed`.

## Limitations

- No real email delivery
- Codes remain in memory only during the active step
