# tidwick.dev tasks. CI runs these same recipes.
set shell := ["bash", "-euo", "pipefail", "-c"]

default:
    @just --list

install:
    npm ci

# Type-check, build, assert the site ships no <script>, lint workflows and pins.
check: lint-actions pin-check
    npx astro check
    npx astro build
    npx --no-install wrangler deploy --dry-run --outdir "$(mktemp -d)" >/dev/null
    if grep -rl '<script' dist >/dev/null; then echo "FAIL: <script> found in dist"; grep -rl '<script' dist; exit 1; fi

lint-actions:
    actionlint
    zizmor --min-severity medium .github

pin-check:
    pinact run --check

ci: install check

# Build, then serve dist/ for at most two minutes.
preview: check
    timeout 120 npx astro preview

# Deploy dist/ to Cloudflare Workers. CI only; the token is environment-scoped.
deploy:
    if [ -z "${CLOUDFLARE_API_TOKEN:-}" ]; then echo "refusing to deploy: CLOUDFLARE_API_TOKEN is not set (deploys run in CI, in a GitHub environment)"; exit 1; fi
    npx --no-install wrangler deploy
