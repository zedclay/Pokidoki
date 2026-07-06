# Two-iOS Offline Messaging — Operator Checklist

**Branch:** `feature/encrypted-offline-messaging`
**Status:** Not yet executed — operator must run and record PASS / FAIL / BLOCKED.

Use **only** the two simulators below. Do **not** use an Android emulator.

| Role | Device | Simulator ID |
|------|--------|----------------|
| **Simulator A** | iPhone 17 Pro | `4A1C3481-8B8E-48BD-983D-03896884EF09` |
| **Simulator B** | iPhone 17 | `C9DCC929-2612-403F-A332-CD79BA4968EB` |

**Bundle ID:** `com.example.pokidoki` (from `ios/Runner.xcodeproj`)

**Backend health:** `http://localhost:3000/api/v1/health`

**Offline simulation:** Shared Backend outage (both simulators lose API). This is **not** per-device network isolation.

---

## Prerequisites

- [ ] Backend healthy: `curl -fsS http://localhost:3000/api/v1/health`
- [ ] Two verified test accounts ready (do not record credentials in this checklist)
- [ ] Accounts are mutual contacts
- [ ] Flutter branch checked out: `feature/encrypted-offline-messaging`

### Launch commands

**Simulator A (iPhone 17 Pro):**

```bash
cd /Users/mac/Downloads/pokidoki-workspace/pokidoki-mobile
flutter run -d 4A1C3481-8B8E-48BD-983D-03896884EF09 \
  --dart-define=API_BASE_URL=http://127.0.0.1:3000/api/v1
```

**Simulator B (iPhone 17):**

```bash
cd /Users/mac/Downloads/pokidoki-workspace/pokidoki-mobile
flutter run -d C9DCC929-2612-403F-A332-CD79BA4968EB \
  --dart-define=API_BASE_URL=http://127.0.0.1:3000/api/v1
```

### Backend control (shared outage)

**A. Stop Backend temporarily (PostgreSQL keeps running):**

```bash
# In the terminal where Nest is running, press Ctrl+C.
# Or, if you know the PID:
pkill -f "nest start" || pkill -f "pokidoki-backend"
```

**B. Restart Backend and verify health:**

```bash
cd /Users/mac/Downloads/pokidoki-workspace/pokidoki-backend
npm run start:dev
# In another terminal:
curl -fsS http://localhost:3000/api/v1/health
```

If the current Backend tree has WIP and cannot start, use a **separate clean worktree** from `origin/main` instead of resetting local WIP:

```bash
cd /Users/mac/Downloads/pokidoki-workspace
git -C pokidoki-backend worktree add ../pokidoki-backend-clean origin/main
cd ../pokidoki-backend-clean && npm install && npm run start:dev
```

---

## Phase A — Online baseline

| Step | Action | Result |
|------|--------|--------|
| A1 | Start Backend; confirm `/api/v1/health` | PASS / FAIL / BLOCKED |
| A2 | Launch Simulator A and B with commands above | PASS / FAIL / BLOCKED |
| A3 | Login User A on Simulator A | PASS / FAIL / BLOCKED |
| A4 | Login User B on Simulator B | PASS / FAIL / BLOCKED |
| A5 | Confirm both users appear in each other's contacts | PASS / FAIL / BLOCKED |
| A6 | From A, open B's profile → Message; send one online message | PASS / FAIL / BLOCKED |
| A7 | On B, confirm message received | PASS / FAIL / BLOCKED |
| A8 | Confirm delivery status progresses (sent → delivered → read as applicable) | PASS / FAIL / BLOCKED |

**Notes (no secrets):** _______________________________________________

---

## Phase B — Queue messages offline

| Step | Action | Result |
|------|--------|--------|
| B1 | Stop Backend only (PostgreSQL stays up) | PASS / FAIL / BLOCKED |
| B2 | From Simulator A, send **exactly three** messages to User B | PASS / FAIL / BLOCKED |
| B3 | All three show queued/sending state (not silently dropped) | PASS / FAIL / BLOCKED |
| B4 | No duplicate bubbles in A's chat for the same send | PASS / FAIL / BLOCKED |

**Notes:** _______________________________________________

---

## Phase C — App restart while offline

| Step | Action | Result |
|------|--------|--------|
| C1 | Fully terminate Pokidoki on Simulator A (swipe away / stop `flutter run`) | PASS / FAIL / BLOCKED |
| C2 | Relaunch A while Backend **still down** | PASS / FAIL / BLOCKED |
| C3 | Queued messages still visible after relaunch (if session restoration allows entry) | PASS / FAIL / BLOCKED |
| C4 | If offline auth/session restoration blocks entry, record **BLOCKED** with exact screen/error — do not claim success | PASS / FAIL / BLOCKED |

**Notes:** _______________________________________________

---

## Phase D — Reconnect and drain

| Step | Action | Result |
|------|--------|--------|
| D1 | Restart Backend; verify `/api/v1/health` | PASS / FAIL / BLOCKED |
| D2 | Three queued messages drain in **FIFO** order on A | PASS / FAIL / BLOCKED |
| D3 | Simulator B receives each message **exactly once** | PASS / FAIL / BLOCKED |
| D4 | Statuses update (sent / delivered / read as applicable) | PASS / FAIL / BLOCKED |
| D5 | No duplicate bubbles on A or B | PASS / FAIL / BLOCKED |

**Notes:** _______________________________________________

---

## Phase E — Second restart after sync

| Step | Action | Result |
|------|--------|--------|
| E1 | Restart Pokidoki on Simulator A (Backend up) | PASS / FAIL / BLOCKED |
| E2 | Message history and statuses persist | PASS / FAIL / BLOCKED |
| E3 | Completed queue entries do not reappear as pending | PASS / FAIL / BLOCKED |

**Notes:** _______________________________________________

---

## Phase F — Retry / idempotency

| Step | Action | Result |
|------|--------|--------|
| F1 | Stop Backend again | PASS / FAIL / BLOCKED |
| F2 | Send one **fourth** message from A | PASS / FAIL / BLOCKED |
| F3 | Restart Backend | PASS / FAIL / BLOCKED |
| F4 | Same `clientMessageId` used for the fourth message (no duplicate server rows) | PASS / FAIL / BLOCKED |
| F5 | Exactly one local bubble and one server message for the fourth send | PASS / FAIL / BLOCKED |

**Notes:** _______________________________________________

---

## Phase G — Logout isolation

| Step | Action | Result |
|------|--------|--------|
| G1 | Logout User A on Simulator A | PASS / FAIL / BLOCKED |
| G2 | Outbound queue stops; socket disconnects | PASS / FAIL / BLOCKED |
| G3 | Login with a **different** account on A | PASS / FAIL / BLOCKED |
| G4 | User A conversations are **not** visible to the other account | PASS / FAIL / BLOCKED |
| G5 | Logout; login again as User A | PASS / FAIL / BLOCKED |
| G6 | Server history resynchronizes for User A | PASS / FAIL / BLOCKED |

**Notes:** _______________________________________________

---

## Privacy — do not record

- Message bodies
- Passwords
- OTP codes
- Email addresses
- Access or refresh tokens
- Encryption keys

---

## Overall outcome

| Phase | Result |
|-------|--------|
| A — Online baseline | PASS / FAIL / BLOCKED |
| B — Queue offline | PASS / FAIL / BLOCKED |
| C — Restart offline | PASS / FAIL / BLOCKED |
| D — Reconnect | PASS / FAIL / BLOCKED |
| E — Second restart | PASS / FAIL / BLOCKED |
| F — Retry idempotency | PASS / FAIL / BLOCKED |
| G — Logout isolation | PASS / FAIL / BLOCKED |

**Operator:** _______________ **Date:** _______________

**Ready for PR push:** YES / NO (requires all phases PASS or documented BLOCKED with acceptance)
