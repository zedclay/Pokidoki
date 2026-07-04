# Environment example

Pokidoki uses compile-time defines for non-secret configuration.

Copy these examples into local run configurations. Do not commit real secrets.

```bash
flutter run \
  --dart-define=APP_ENV=development \
  --dart-define=API_BASE_URL=https://api.example.pokidoki.invalid
```

| Variable | Allowed values | Notes |
| --- | --- | --- |
| `APP_ENV` | `development`, `staging`, `production` | Defaults to `development` |
| `API_BASE_URL` | HTTPS URL | Non-secret API base only |

Do not place the following in source control:

- API keys
- authentication secrets
- database credentials
- encryption keys
- private endpoint credentials
- signing passwords
