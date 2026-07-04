# Mock Storage Data

## Categories

Deterministic mock totals (248 MB):

| Category | Bytes |
| --- | --- |
| Photos and videos | 136 MB |
| Files | 54 MB |
| Voice messages | 31 MB |
| Cache | 19 MB |
| Other local data | 8 MB |

Defined in `MockSampleData.storageUsage` and owned by `settingsProvider`.

## Clear cache

Confirmation dialog, then `SettingsController.clearCache()`:

- Sets `cacheBytes` to 0
- Subtracts previous cache from `totalBytes`
- Leaves messages and other categories unchanged
- Shows “Cache cleared.”

No real filesystem access or media deletion occurs.

## Future integration

A production storage service would:

1. Measure on-device cache and media directories
2. Enforce retention policies
3. Report progress for large cleanups

Batch 6 intentionally stays mock-only.
