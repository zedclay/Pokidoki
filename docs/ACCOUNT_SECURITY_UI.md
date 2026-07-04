# Account Security UI

## Change Password

Route: `/settings/account/change-password`

- Current, new, and confirm password fields (obscured, LTR)
- Requirements: 12+ characters, upper/lower, number, symbol, different from current
- Sign out other devices toggle (default on)
- Forgot current password → Account Recovery

Mock current password (developer docs only): `Pokidoki!2026`

On success:

- Updates in-memory account password
- Adds Security Activity event `Password changed`
- Signs out other mock linked devices when enabled
- Shows “Password updated.” and returns to Account Management

## Limitations

- Mock password change only
- No real session revocation
- Passwords never persisted to preferences or logs
