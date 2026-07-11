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

1. **library** — `elm-format --validate` on the hand-written IR core, `elm make src/M3e.elm`
   (the package correctness proof), `elm-test` (IR-core + slot unit tests), and `elm-review`
   with the Cem rules + `NoProprietaryDsClasses`.
2. **docs** — the reference pipeline (`build:reference`, which runs `elm make --docs` and
   **fails hard if any exposed value lacks a doc comment**) and the full elm-pages
   production build.
3. **harness** — the Playwright runtime contract harness (the components actually upgrade
   and render in a browser).

Each fetches the sibling public `jackhp95/elm-review-cem` at `../elm-review-cem`.

## The publish gate: `elm make --docs`

The single most important local check before publishing — it is what `elm publish`
enforces and what the docs job runs:

```bash
elm make src/M3e.elm --docs docs.json      # must be EXIT 0
```

This validates the license, that the root `elm.json` version matches the tag, and —
critically — that **every exposed value has a doc comment** (the F8 discipline). A missing
doc comment on any generated exposed value fails here. If it fails, fix it upstream in the
generator/config and regenerate (see regenerating-elm-m3e), never by hand-editing `src/`.

## `elm bump` discipline

Elm computes the version bump from the API diff — you do not choose it:

```bash
elm bump          # inspects the API diff vs the last published version, writes elm.json
```

- A changed/removed exposed value or type → **MAJOR**. A regen from a `@m3e/web` bump can
  produce this (a renamed phantom capability, a removed setter) — reconcile the changelog
  and let `elm bump` set the number; do not hand-set `version`.
- Added exposed values only → **MINOR**. Doc/impl-only changes → **PATCH**.
- Update `CHANGELOG.md` to match what `elm bump` reports before tagging.

## The irreversible steps (from RELEASE-CHECKLIST.md)

Run from the **repo root** (the published package is `elm.json` + `src/` at the root;
generator/docs/tests live in subdirs, `export-ignore`d via `.gitattributes`).

1. **Confirm structure & license** (green today): `elm make src/M3e.elm --output=/dev/null`
   from root; root `LICENSE`, root `elm.json` `"license"`, and `package.json` all agree on
   **BSD-3-Clause**.
2. **Tag** the release commit — the tag must exactly match `elm.json`'s `version`:
   ```bash
   git tag 1.0.0
   git push origin 1.0.0
   ```
3. **Publish** (permanent):
   ```bash
   elm publish        # from the repo root
   ```
4. **After publishing**, point the repo homepage at the `package.elm-lang.org` page.

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
