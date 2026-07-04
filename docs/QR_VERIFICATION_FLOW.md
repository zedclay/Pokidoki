# QR Verification Flow (Batch 4)

## Routes

| Screen | Route |
| --- | --- |
| QR Scanner | `/security/qr-scanner` |
| My QR Code | `/security/my-qr` |
| Contact Verification | `/security/contact-verification/:userId` |
| Safety Number | `/security/safety-number/:userId` |

## Mock QR payloads

Developer-only public contact codes (never include secrets):

- Current user: `pokidoki://contact/zed-demo`
- Amira: `pokidoki://contact/amira-demo`

## Scanner

- Live camera scanning is **not** implemented.
- No camera permission is requested.
- Debug builds expose **Simulate scan**, which resolves Amira’s mock payload and opens Contact Verification.
- Invalid payloads show a safe error without displaying the raw payload.

## QR generation

- Package: `qr_flutter`
- Renders a real QR visual from the public mock payload only.

## Safety numbers

- Deterministic mock groups for Amira UI only.
- Not derived from cryptographic keys.
- Always displayed LTR.

## Shared verification state

`SocialGraphController.markVerified` / `resetVerification` update:

- Contacts
- Conversations
- Profile previews

## Production boundary

Real QR scanning, identity keys, and safety-number derivation require audited cryptography and native camera integration. Those are intentionally out of scope.
