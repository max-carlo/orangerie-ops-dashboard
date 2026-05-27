#!/bin/bash
# ─────────────────────────────────────────────────
# Orangerie NK Dashboard — Deploy to Netlify
# Run this via Claude Code after setting your env vars
# ─────────────────────────────────────────────────

set -e

# ── 1. Check required env vars ──
: "${MONDAY_API_KEY:?Set MONDAY_API_KEY first}"
: "${ZENCHEF_TOKEN:?Set ZENCHEF_TOKEN first}"
: "${ZENCHEF_RESTAURANT_ID:?Set ZENCHEF_RESTAURANT_ID first}"

echo "✓ Credentials found"

# ── 2. Inject credentials into both HTML files ──
for SRC in index.html manager.html; do
  DEPLOY="${SRC%.html}.deploy.html"
  cp "$SRC" "$DEPLOY"
  sed -i '' "s|YOUR_MONDAY_API_KEY|${MONDAY_API_KEY}|g" "$DEPLOY"
  sed -i '' "s|YOUR_ZENCHEF_TOKEN|${ZENCHEF_TOKEN}|g" "$DEPLOY"
  sed -i '' "s|YOUR_ZENCHEF_RESTAURANT_ID|${ZENCHEF_RESTAURANT_ID}|g" "$DEPLOY"
done

echo "✓ Credentials injected (index + manager)"

# ── 3. Copy to docs/ for GitHub Pages ──
mkdir -p docs
cp index.deploy.html docs/index.html
cp manager.deploy.html docs/manager.html

echo "✓ docs/ updated"
echo ""
echo "Commit and push to deploy:"
echo "  git add docs/ && git commit -m 'Deploy' && git push"

# ── Cleanup ──
rm -f index.deploy.html manager.deploy.html
