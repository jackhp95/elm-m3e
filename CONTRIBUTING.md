# Contributing to elm-m3e

Thanks for your interest! This repo is a code-generation monorepo: the shippable
package `jackhp95/elm-m3e` (nested at `packages/m3e/`) is a **generated artifact**,
the userland Kit (`packages/m3e-kit/`) is copy-paste, and an elm-pages docs site
plus a codegen-aware `elm-review` config round it out.

## Generated code — do not hand-edit

The per-component modules under `packages/m3e/src/M3e/` are emitted by `elm-cem`
from the `@m3e/web` Custom Elements Manifest plus `config/slots.json`. **Do not
hand-edit them** — change the generator (`elm-cem/`) or the config (`config/`) and
regenerate. The only hand-written sources are the IR core (`M3e/Node.elm`,
`M3e/Element.elm`, `M3e/Content.elm`) and the `packages/m3e-kit/` userland.

## Setup

```bash
npm ci        # installs elm, elm-format, elm-test (root dev deps)
```

## Verify — the same gates CI runs

CI (`.github/workflows/ci.yml`) has three jobs. To reproduce them locally:

**Library — format, build, test, review**

```bash
# 1. Format-check the HAND-WRITTEN IR core only (generated modules are excluded by design)
node_modules/.bin/elm-format --validate \
  packages/m3e/src/M3e/Node.elm packages/m3e/src/M3e/Element.elm packages/m3e/src/M3e/Content.elm

# 2. The real correctness proof — a green `elm make` over the package
cd packages/m3e && ../../node_modules/.bin/elm make src/M3e.elm --output=/dev/null && cd ../..

# 3. Tests
node_modules/.bin/elm-test --compiler node_modules/.bin/elm

# 4. elm-review — run from docs/ so it picks up docs/elm.json; `elm-pages gen`
#    must run first or the router shows false NoUnused errors
cd docs && pnpm install --frozen-lockfile && pnpm exec elm-pages gen \
  && node_modules/.bin/elm-review --config ../review --compiler node_modules/.bin/elm && cd ..
```

**Docs — reference pipeline + production build**

```bash
cd docs
pnpm install --frozen-lockfile
pnpm run build:reference   # `elm make --docs` — fails on any exposed value missing a doc comment
pnpm run build             # full elm-pages + Netlify build
```

**Docs — Playwright runtime contract harness**

```bash
cd docs
pnpm exec playwright install --with-deps chromium
pnpm run test:browser      # boots the app and asserts the runtime contract Test.Html can't
```

## Regenerating the library

After changing `config/slots.json` or the generator, regenerate and re-run the
library gates above so `elm.json`'s `exposed-modules` and the emitted tree stay in
sync. Every exposed value must carry a doc comment (the `build:reference` gate).

## Pull requests

- Branch off `main`; keep changes focused.
- Ensure the library gates (build + test + review) are green.
- Reference the issue you're addressing.

## Reporting

- Bugs / features: [GitHub issues](https://github.com/jackhp95/elm-m3e/issues).
- Security vulnerabilities: **do not** open a public issue — see
  [`SECURITY.md`](SECURITY.md).
