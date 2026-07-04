# Account Recovery Flow

Route: `/settings/account/recovery`

## Steps

```text
Introduction → Code Verification → New Password → Completed
```

Introduction shows masked verified email, current device, four-step explanation, local encrypted-data warning, and sign-out-other-devices toggle.

Mock recovery code (developer docs only): `654321`

## Boundaries

- Recovery confirms account ownership in the mock UI only
- Local encrypted data may remain unavailable
- Recovery does not create a backdoor into conversations
- App PIN is not changed
- Support sheet states support never asks for password, PIN, or code

## Completion

- Updates mock account password
- Security Activity: recovery started, password reset, recovery completed
- Signs out other devices when selected
- Shows “Account access restored.”
