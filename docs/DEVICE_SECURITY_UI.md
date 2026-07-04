# Device Security UI

## Linked Devices

Mock list in `settingsProvider` / `MockSampleData.linkedDevices`:

- Current device: Hafid's iPhone (cannot be removed)
- Secondary: MacBook Pro (needs review, Algeria)

Remove requires confirmation. Success removes the device from the mock list, prepends a `deviceRemoved` security event, and shows “Device removed.”

No real token revocation or session invalidation is performed.

## Security Activity interpretation

Stitch exports:

1. `pokidoki_security_activity_screen_1` — list with attention banner and detailed event rows
2. `pokidoki_security_activity_screen_2` — same feature with filter chips (All / Devices / Identity / Sign-in)

**Implementation:** one Security Activity list combining the attention banner (screen 1) and filter chips (screen 2). Tapping an event opens `/settings/security-activity/:eventId` for detail, including “Review linked devices” when `requiresAttention` is true.

Sensitive metadata (exact IP, GPS, tokens, user-agent) is never shown.

## App Lock Settings

Uses `AppSecurityPreferences` in `settingsProvider`:

- App Lock enabled (confirm before disable)
- Biometric unlock (mock preference only)
- Change app PIN (Create PIN → Confirm PIN with `?mode=settings`, returns to App Lock Settings)
- Lock delay (Immediately / 1 / 5 / 30 minutes)
- Hide content in app switcher (mock preference)

Raw PIN is never displayed or written to ordinary preferences. Confirmed PIN remains in-memory only via `AuthFlowController`.

## Limitations

| Area | Status |
| --- | --- |
| Biometrics | Mock preference; no OS biometric dialog |
| Session removal | Mock list update only |
| App-switcher privacy | Preference only; no native screenshot protection |
| Security events | Local mock timeline |
| Device linking | No real multi-device protocol |
| Password / recovery sign-out | Mock list update via `signOutOtherDevices` |
