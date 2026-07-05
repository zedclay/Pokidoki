# Messaging Current Security Limitations

This development phase integrates real-time text messaging against a Backend that stores message content in **plaintext**.

## Not implemented

- End-to-end encryption
- Encrypted local message database
- Offline durable queues
- Push notifications
- Attachment encryption or storage
- Production retention / cryptographic deletion guarantees
- Remote-device secure wipe

## Client protections

- Access token only for Socket.IO auth (never refresh token).
- No logging of message text, search queries, or tokens.
- Read receipts only when chat is visibly open.
- Block state disables composer and outbound send.

## Production roadmap

See `PRODUCTION_INTEGRATION_ROADMAP.md` for encrypted persistence, offline sync, push, and attachments.
