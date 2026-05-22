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

# ── 2. Inject credentials into the HTML ──
cp index.html index.deploy.html

sed -i "s|YOUR_MONDAY_API_KEY|${MONDAY_API_KEY}|g" index.deploy.html
sed -i "s|YOUR_ZENCHEF_TOKEN|${ZENCHEF_TOKEN}|g" index.deploy.html
sed -i "s|YOUR_ZENCHEF_RESTAURANT_ID|${ZENCHEF_RESTAURANT_ID}|g" index.deploy.html

echo "✓ Credentials injected"

# ── 3. Deploy to Netlify Drop (no account needed) ──
# Option A: Netlify CLI (recommended — persistent URL)
if command -v netlify &> /dev/null; then
  echo "Deploying via Netlify CLI..."
  mkdir -p dist
  cp index.deploy.html dist/index.html
  netlify deploy --prod --dir=dist
else
  echo ""
  echo "────────────────────────────────────────────"
  echo "Netlify CLI not found. Two options:"
  echo ""
  echo "Option A — Install Netlify CLI:"
  echo "  npm install -g netlify-cli"
  echo "  netlify login"
  echo "  then re-run this script"
  echo ""
  echo "Option B — Manual drag & drop:"
  echo "  1. Open https://app.netlify.com/drop"
  echo "  2. Drag the 'dist/' folder onto the page"
  echo "  3. Done — you'll get a URL like https://xyz.netlify.app"
  echo "────────────────────────────────────────────"
  mkdir -p dist
  cp index.deploy.html dist/index.html
  echo ""
  echo "✓ dist/index.html is ready to upload"
fi

# ── Cleanup ──
rm -f index.deploy.html
