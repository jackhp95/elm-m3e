---
name: releasing-elm-m3e
description: >-
  Releases the elm-m3e package to the Elm registry and deploys the docs site — the
  owner-only, irreversible release runbook. Use when maintaining elm-m3e and preparing a
  release, tagging a version, running elm publish, bumping the version with elm bump,
  cutting a changelog entry, or deploying the docs site. Covers RELEASE-CHECKLIST.md
  (structure/license/tag/publish steps), the three CI jobs that must be green (library /
  docs / harness), the elm bump discipline for API compatibility, the `elm make --docs
  docs.json` publish gate (every exposed value must be documented), and docs-site deploy.
  Elm versions are permanent and publishing cannot be undone, so this is a deliberate
  owner-run runbook, not model-triggered automation. Cross-references the release
  playbook's checklist 03 (03-elm-release). For regenerating the package see
  regenerating-elm-m3e.
disable-model-invocation: true
---

# Releasing elm-m3e

**Publishing to the Elm registry is permanent — a version cannot be unpublished or
overwritten, and tags are immutable.** This skill operationalizes `RELEASE-CHECKLIST.md`;
the owner runs the irreversible steps by hand, in order. Do not automate them.

> The library is deliberately **prerelease** ("breaking changes are embraced"). Only tag
> `1.0.0` when you are ready to freeze the API. Everything below is the runbook for when
> that day comes.

## Preconditions — all three CI jobs green

Do not release on a red or stale CI run. The three jobs in `.github/workflows/ci.yml`:

1. **library** — `elm-format --validate` on the generated output, `elm make src/M3e.elm`
   (the package correctness proof), `elm-test` (kind/token unit tests), and `elm-review`
   with the Cem rules + `NoProprietaryDsClasses`. Also runs `npm run measure-docs` to
   verify every facet's docs size is within the 700 KB Elm registry gate.
2. **docs** — the reference pipeline (`build:reference`, which runs `elm make --docs` and
   **fails hard if any exposed value lacks a doc comment**) and the full elm-pages
   production build.
3. **harness** — the Playwright runtime contract harness (the components actually upgrade
   and render in a browser).

Each fetches the sibling public `jackhp95/elm-review-cem` at `../elm-review-cem`.

## The publish gate: docs-size + `elm make --docs`

elm-m3e publishes as a **facet family** (core / raw / html / standard / record / build /
review-facts), each a separate Elm package. Before tagging:

```bash
npm run measure-docs        # in elm-m3e/ — runs elm make --docs on each facet,
                            # asserts every facet's docs.json ≤ 700 KB; must exit 0
```

This validates that every exposed value has a doc comment (what `elm publish` requires)
and that no facet has grown past the registry cap. A missing doc comment on any generated
exposed value fails here. If it fails, fix it upstream in the generator/config and
regenerate (see regenerating-elm-m3e), never by hand-editing `src/`.

The mirror release script (`scripts/mirror-release.mjs`) copies each facet's subset of
`src/M3e/` into its copy-only mirror repo and tags it. Run with `--rehearse` first to
verify the split before any real push.

## `elm bump` discipline

Elm computes the version bump from the API diff — you do not choose it. Run `elm bump`
from each facet mirror's clone:

```bash
elm bump          # inspects the API diff vs the last published version, writes elm.json
```

- A changed/removed exposed value or type → **MAJOR**. A regen from a `@m3e/web` bump can
  produce this (a renamed phantom capability, a removed setter) — reconcile the changelog
  and let `elm bump` set the number; do not hand-set `version`.
- Added exposed values only → **MINOR**. Doc/impl-only changes → **PATCH**.
- Update `CHANGELOG.md` to match what `elm bump` reports before tagging.
- Because the facets share a common source (`src/M3e/`), a breaking change in a shared
  module (e.g. a Kind or Token rename) usually bumps EVERY facet that exposes that value.

## The irreversible steps (from RELEASE-CHECKLIST.md)

elm-m3e releases as a facet family — each facet is a separate Elm package published from
its own copy-only mirror repo (e.g. `jackhp95/elm-m3e-standard`). The mirror release
script handles the split; the steps below cover the invariants and the topo order.

1. **Confirm structure & license**: `npm run measure-docs` (all facets compile + ≤ 700 KB);
   root `LICENSE`, root `elm.json` `"license"`, and `package.json` all agree on
   **BSD-3-Clause**.
2. **Run the mirror release script** in `--rehearse` mode, verify all 7 mirror repos get
   the correct tree + tag + copy-only banner, then run for real:
   ```bash
   node scripts/mirror-release.mjs --rehearse   # dry run to local bare repos
   node scripts/mirror-release.mjs              # real push (gated; runs once)
   ```
3. **Publish each facet in topo order** from the mirror repo (core → raw/html → standard →
   record/build → review-facts). Publishing is permanent and cannot be undone.
   ```bash
   # from each mirror clone:
   elm publish
   ```
4. **After publishing**, point each mirror repo's homepage at its `package.elm-lang.org`
   page.

The repo is already public with description/topics/homepage set. Optional hardening
(secret scanning, private vuln reporting, branch protection) is in RELEASE-CHECKLIST §5;
note the `.gitleaks.toml` allowlist already suppresses the false-positive
`M3e.Token.*`/`M3e.Heading.emphasized` "generic-api-key" hits in the examples corpus.

## Docs-site deploy

The docs site is a separate elm-pages build (`docs/`), deployed via the Netlify adapter
(`docs/netlify.toml`); the **docs** CI job runs the full production build on every push.
Build locally with `cd docs && pnpm install && pnpm run build` (output in `docs/dist`).
After publishing the package, the repo homepage moves from the docs site to the
`package.elm-lang.org` page (RELEASE-CHECKLIST §6).

## Cross-reference

- **`RELEASE-CHECKLIST.md`** (repo root) — the authoritative owner-only step list this
  skill operationalizes; read it before each release.
- The release playbook's **checklist 03 (`03-elm-release`)** — the cross-repo Elm-release
  procedure this repo's checklist instantiates.
- regenerating-elm-m3e — for any pre-release regen from a `@m3e/web` bump.

---
_Validated against elm-m3e 1.0.0, 2026-07._
