# Production Integration Roadmap

Ordered next steps after UI implementation complete. **Do not implement during UI-only phase.**

## 1. Backend foundation

- API gateway, user service, conversation service
- Environment configuration (dev/staging/prod)
- Contract-first API schemas

## 2. Authentication integration

- Real sign-up, sign-in, token refresh
- Email verification delivery
- Session lifecycle and forced logout

## 3. Secure token storage

- Platform secure storage (Keychain / Keystore)
- No tokens in shared preferences or logs

## 4. Real App Lock and biometrics

- `local_auth` or equivalent
- PIN hashed at rest
- Lock on background / timeout

## 5. Real QR scanning

- Camera permission and plugin
- Payload validation and contact resolution

## 6. Messaging API and WebSockets

- Send/receive/sync messages
- Delivery and read receipts
- Typing indicators (if product requires)

## 7. Local encrypted persistence

- Encrypted database for messages and keys
- Migration from in-memory mock repositories

## 8. Attachment handling

- Upload/download pipeline
- Thumbnails and shared media index
- Storage quota enforcement

## 9. Push notifications

- FCM/APNs with privacy-conscious payload design
- Notification preferences in settings

## 10. Audited encryption integration

- Real safety numbers and key verification
- Replace mock wording with accurate E2E claims only when verified

## 11. Reporting and moderation backend

- Report submission, evidence upload policy
- Block/sync with server state

## 12. Production analytics and crash reporting

- Opt-in analytics
- Crash reporting without sensitive content

## 13. Android release

- Play App Signing, ProGuard/R8 rules
- Permission audit (camera, notifications when features ship)
- `applicationId` finalization

## 14. iOS release

- Bundle ID, provisioning, App Store metadata
- Usage descriptions when camera/biometrics/photos added
- App Transport Security review

---

**Current status:** UI implementation complete and stable; all items above are pending.
