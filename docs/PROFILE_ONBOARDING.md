# Profile Onboarding

After email verification, profile completion is **server-authoritative**:

1. Username Setup checks availability via `GET /users/username-availability` (debounced).
2. Profile Setup creates the profile via `POST /users/me/profile`.
3. On success, local PIN setup continues (still device-local).

## Session restoration

On cold start:

1. Restore auth session (refresh token).
2. Load `GET /users/me/profile`.
3. If profile missing → route to Username Setup (not Chats).
4. If profile exists → App Lock → Chats.

`ProfileCompletionStatus` in `currentProfileProvider` drives routing via `auth_route_guard.dart`.

## Race conditions

If profile creation returns `USERNAME_UNAVAILABLE`, Profile Setup returns the user to Username Setup while preserving display-name and bio drafts in `authFlowProvider`.
