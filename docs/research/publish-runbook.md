# Publish runbook — when (and how) `elm-m3e-repo` can ship to the Elm registry

This repo is the **Layer 4** typed-builder package. It can't be published to
`package.elm-lang.org` today because its only direct dep — the `M3e.*` atoms
in `vendor/elm-m3e/` — is **not a published Elm package yet**. The Elm
registry only accepts dependencies that are themselves published packages.

The remaining work is layered. Each step depends on the one before it.

---

## Layer dependencies (publish order)

1. **`elm-custom-elements-manifest-package`** — the CEM → Elm generator tool
   ([github.com/jackhp95/elm-custom-elements-manifest-package](https://github.com/jackhp95/elm-custom-elements-manifest-package)).
   Must be installable + usable (`npx elm-cem` or equivalent).
2. **`elm-cem-template`** — the package-shaped template the generator emits
   into ([github.com/jackhp95/elm-cem-template](https://github.com/jackhp95/elm-cem-template)).
   Defines the shape of any generated CEM-derived Elm package.
3. **`elm-m3e`** — the actual generated Elm package for `@m3e/web`
   ([github.com/jackhp95/elm-m3e](https://github.com/jackhp95/elm-m3e)).
   **Publish-blocker #1**: until this is on the Elm registry, the atoms in
   `vendor/elm-m3e/M3e/*` are vendored copies, not a real dep.
4. **`elm-m3e-repo`** — *this* repo. Layer 4. Depends on `elm-m3e` once
   published. **Publish-blocker #2**: requires the package-ready elm.json
   below + `elm-m3e` on the registry.

---

## Phase-8 artifact already in place

The F8 docs-generation pipeline already materializes a **valid
package-shaped elm.json** every time `npm run build:reference` runs (at
`/tmp/m3e-docs-gen/elm.json`). Its `exposed-modules` array lists every
`Ui.*` module the package will publish. `docs/scripts/extract-reference.mjs`
is the source of truth for that list.

That elm.json plus `vendor/elm-m3e/M3e/*` is what `elm make --docs` accepts
today; it's the same shape the Elm registry will accept once `elm-m3e` is
a real dep.

When `elm-m3e` ships, the package-ready elm.json for this repo becomes:

```json
{
  "type": "package",
  "name": "jackhp95/elm-m3e-repo",
  "summary": "Material 3 Expressive — typed, MISI Elm builders over @m3e/web.",
  "license": "BSD-3-Clause",
  "version": "0.1.0",
  "exposed-modules": [ /* 52 Ui.* modules, generated */ ],
  "elm-version": "0.19.0 <= v < 0.20.0",
  "dependencies": {
    "elm/browser": "1.0.0 <= v < 2.0.0",
    "elm/core": "1.0.0 <= v < 2.0.0",
    "elm/html": "1.0.0 <= v < 2.0.0",
    "elm/json": "1.0.0 <= v < 2.0.0",
    "elm/time": "1.0.0 <= v < 2.0.0",
    "elm-community/html-extra": "3.0.0 <= v < 4.0.0",
    "elm-community/list-extra": "8.0.0 <= v < 9.0.0",
    "elm-community/maybe-extra": "5.0.0 <= v < 6.0.0",
    "jackhp95/elm-m3e": "1.0.0 <= v < 2.0.0"
  }
}
```

The only diffs from `/tmp/m3e-docs-gen/elm.json` are: replacing the
`vendored M3e/` symlink with a `jackhp95/elm-m3e` dependency line, and
changing `name` to `jackhp95/elm-m3e-repo` (or whatever the published name
will be).

---

## When `elm-m3e` is published — the actual publish steps

Pre-flight (all gates green on `main`):
- `elm-format --validate src/ tests/ review/src/` clean
- `elm-test` green
- `elm-review` clean
- `npm run build:reference` succeeds (the F8 pipeline — fails hard if any
  exposed value lacks a doc comment)
- `npm run build` (full elm-pages production build) succeeds
- All five gates pass in CI on `main`

Then on a **`package-ready` branch** (never merged to main as long as main
hosts the elm-pages application):

1. Replace the root `elm.json` (currently `type: application`) with the
   package-shaped version above. Delete `vendor/elm-m3e/` (the dep replaces
   it). Update tests/elm.json to point at `jackhp95/elm-m3e` instead of the
   vendor source-dir.
2. `elm make --docs docs.json` at the repo root — must succeed with zero
   `NO DOCS` errors. (The F8 pipeline rehearses this every CI run.)
3. `elm-test` from the repo root — must still pass.
4. `elm publish` — bumps to `0.1.0` (initial release).
5. **Do not delete the `package-ready` branch**; future minor releases
   re-cut against it.

`main` continues to host the elm-pages application (the docs site +
studies). Treat it like a monorepo with a single published package living
on a long-lived sibling branch.

---

## Risks / unknowns at publish time

- **Module signatures may need to widen.** The 52 modules currently expose
  the `Ui.* msg` type aliases inline; the registry is strict about
  exported-vs-internal type leakage. A practice publish to a private mirror
  can shake this out without burning a real `0.1.0`.
- **`vendor/elm-m3e/` deletion is a one-way door.** Cut a tag on `main`
  before deleting, so the application-shaped history is preserved.
- **Tests use `Test.Html` which only sees real attributes, not properties.**
  See friction log F4: any property-driven assertion has to live in
  Playwright, not the elm-test suite. The registry doesn't run Playwright;
  publishing means CI's Playwright pass becomes the *only* gate on
  property-driven behavior.

See the friction log (`docs/research/api-friction-log.md`) for the full
backlog of API decisions that landed this milestone.
