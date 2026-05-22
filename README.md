# Orangerie NK — TV Dashboard

Daily operations dashboard combining Monday.com events + ZenChef reservations.
Auto-refreshes every 5 minutes.

## Setup

### 1. Get your credentials

**Monday.com API key:**
→ monday.com → Profile → Developers → API v2 Token

**ZenChef:**
→ https://app.zenchef.com/zw#/parameters/partners
→ auth token + restaurant ID

### 2. Deploy

Set your env vars and run the deploy script:

```bash
export MONDAY_API_KEY="eyJ..."
export ZENCHEF_TOKEN="your_token"
export ZENCHEF_RESTAURANT_ID="12345"

chmod +x deploy.sh
./deploy.sh
```

Or with Claude Code:
```
run deploy.sh with env vars set
```

### 3. Add to OptiSigns

1. Copy the Netlify URL
2. In OptiSigns → New Widget → Web Page / URL
3. Paste URL, set refresh to 5 min (or rely on the built-in auto-refresh)
4. Set display resolution to 1920×1080

## What's shown

**Left panel — Events (Monday board 1721179729):**
- Event name, start/end time, location, host
- Pax, status badge (Definite / Handover / Scheduled / Tentative)
- Exclusive flag, setup notes / Ablauf

**Right panel — Reservations (ZenChef):**
- Time, guest name, party size, booking status
- Color-coded status dots

**Footer stats:** Total events · Reservierungen · Gäste · Event pax

## Notes

- The Monday query filters by `date__1 = today` and fetches the relevant op columns
- ZenChef filters `reservation_type = reservation` and `day = today`
- Credentials are injected at deploy time — never stored in git
- Add a `.gitignore` if you version-control this: ignore `dist/` and any `.env` files
