# Pokidoki Security Boundaries

## Current phase

This foundation prepares UI and architecture only.

It does **not** implement production cryptography.

## Rules

1. Do not invent or implement custom encryption algorithms.
2. Do not write a fake end-to-end encryption implementation.
3. Do not present ordinary encoding (for example base64) as encryption.
4. Do not create fake safety numbers that claim cryptographic verification.
5. Do not store passwords, app PINs, private keys, or verification codes in plain text.
6. Do not log passwords, PINs, tokens, verification codes, private keys, message content, or full email addresses unnecessarily.
7. Do not expose stack traces, file paths, or internal identifiers in user-facing errors.

## Mock security service

`SecureMessagingService` is an integration boundary for future native cryptography.

`MockSecureMessagingService`:

- exists only for UI development and bootstrap warm-up
- returns a development-ready state
- sets `providesProductionProtection` to `false`
- must never be described as production protection in user-facing copy

## Future cryptography integration

Real messaging protection is expected to integrate audited protocol components through native bridges, for example:

- Signal-style protocol family
- PQXDH
- Double Ratchet
- Audited `libsignal` integration
- Kotlin and Swift platform bridges

Those components are intentionally not implemented in this phase.

## Final QA (July 2026)

- Mock development values centralized in `lib/data/mock/mock_development_credentials.dart` — see `docs/MOCK_DEVELOPMENT_CREDENTIALS.md`.
- No `print` / `debugPrint` of sensitive values in `lib/`.
- Route parameters use opaque IDs only — no passwords, PINs, or codes in URLs.
- QR simulate-scan control guarded by `kDebugMode`.
- Full audit: `docs/FINAL_UI_QA_REPORT.md`, `docs/PLACEHOLDER_AND_MOCK_AUDIT.md`.

## Secret storage rules

When secure storage is introduced later:

- use platform-backed secure storage for secrets
- never commit secrets to the repository
- never embed secrets in client source as defaults
- keep example environment files free of real values

## PIN and password restrictions

- PINs and passwords are presentation concerns only in this phase
- mock flows must not persist secrets in plain text files or shared preferences without encryption
- UI fields may collect values for interaction design, but must not claim secure storage until implemented
- Account password and app PIN are separate concepts and separate in-memory fields
- Batch 2 clears temporary PIN values after successful unlock (`clearSensitiveFlow`)
- Development verification code `123456` and development app PIN `123456` exist only for UI tests and developer docs — never shown in production UI
- Biometrics in Batch 2 are a mock session flag only; Pokidoki does not store biometric templates
- Batch 4 QR payloads are public contact locators only (`pokidoki://contact/...`) — never email, phone, PIN, tokens, or private keys
- Safety numbers are deterministic mock UI groups, not cryptographic fingerprints
- QR recognition is mocked when no live camera integration is present; no camera permission is requested for the mock scanner
- Raw QR payloads and safety numbers must not be logged
- Batch 5 messages are local mock data only; message text and search queries must not be logged or placed in routes
- No file uploads, camera/microphone access, or production encryption claims in messaging UI
- Batch 6 settings must not display full email (masked only), phone, exact IP, exact GPS, device serial, push tokens, or auth tokens
- App Lock preferences are non-sensitive UI flags; raw PIN remains in-memory only and is never written to ordinary preferences
- Linked-device removal and cache clearing are mock-only; do not claim real session revocation or filesystem cleanup
- Biometrics and app-switcher privacy are preference mocks until native integration exists
- Security event routes use non-sensitive event IDs only
- Batch 7 passwords, verification codes, recovery codes, and report evidence stay in memory during the active flow only
- Development mock values (`Pokidoki!2026`, `123456`, `654321`) are documented for developers and never shown in UI
- Email management shows masked addresses only
- Report User does not claim moderation enforcement or attach full conversation history by default
