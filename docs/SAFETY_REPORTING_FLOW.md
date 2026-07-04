# Safety Reporting Flow

Route: `/report/:userId`

Opened from User Profile Preview and Conversation Information.

## Reasons

Spam, Harassment, Impersonation, Threats or violence, Sexual or inappropriate content, Scam or fraud, Other.

Submit is disabled until a reason is selected.

## Details and evidence

- Optional details, max 1,000 characters
- Evidence off by default
- When enabled, user deliberately selects mock messages from the relevant conversation
- No automatic full-history attachment

## Block vs report

Reporting does not block. Blocking does not report. Existing block state is preserved on submit.

## Limitations

- Mock submission only
- No moderation backend or enforcement claims
- Report details and evidence are not logged or persisted beyond an in-memory mock list for tests
