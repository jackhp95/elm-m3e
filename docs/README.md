# elm-m3e docs site

This directory hosts the elm-pages documentation app — Material 3 component
reference, studies, and design-token guides.

## Quickstart

```sh
pnpm install
pnpm run gen:reference   # generate the API reference JSON
pnpm run gen:pages       # generate .elm-pages/ codegen (see note below)
pnpm run dev             # elm-pages dev, serves on http://localhost:1234
```

`elm-pages dev` proxies through Vite, which watches your `.elm` source.

> **First-run prerequisite — run `gen` before `elm-review` or the dev server.**
> A fresh checkout/worktree has no `.elm-pages/` (it is gitignored). `elm-review`
> and compiling any route depend on that codegen output, so a fresh tree must run
> `pnpm run gen:reference && pnpm run gen:pages` (or `elm-pages gen` directly) **first** —
> otherwise you get cryptic type errors instead of an obvious "missing codegen"
> message. Note that `elm-pages gen` prints nothing on success, so the `gen`
> script echoes a one-line confirmation.
>
> Re-run `pnpm run gen:pages` after changing any route's `Model`/`Msg`: those changes
> staleness-invalidate `.elm-pages/`, and a forgotten re-gen surfaces later as a
> confusing type error far from the edit.

## Verification gate — run before claiming a route compiles

```sh
pnpm run build:site   # elm-pages build — the authoritative compile
```

**`elm-review` clean does NOT mean the app compiles.** elm-review does not
reliably re-typecheck changed route bodies against the generated,
Lamdera-wired `.elm-pages/Main.elm`, so route type errors pass review (see
[`DESIGN.md` §5](DESIGN.md)). The
authoritative gate is a real compile: `pnpm run build:site`, or loading the
route in `pnpm run dev`.

## Styling — no manual CSS rebuild

CSS is bundled by **Vite via the Tailwind v4 plugin** (`@tailwindcss/vite` in
`elm-pages.config.mjs`); `./style.css` is imported as a side effect from
`index.ts` (which also registers the `@m3e/web` custom elements). There is no
`build:css` script and no separately-emitted `public/style.css` or `m3e.js`
artifact — Vite content-hashes the bundle at build time and picks up new class
strings on its own during `elm-pages dev`. Just edit `.elm`/`style.css` and the
dev server rebuilds.

## Scripts

Naming follows the family convention: `gen:*` writes git-tracked files,
`build:*` produces untracked artifacts, `check:*` verifies without writing,
`test:*` runs a suite. Bare `gen` / `check` / `test` at the REPO ROOT run the
whole family — prefer running those from the root rather than `cd`-ing here.

| script                  | does                                                     |
| ----------------------- | -------------------------------------------------------- |
| `gen`                   | The full ordered generation pipeline (vendor → reference → examples). Order is load-bearing; it is an explicit serial list, not a glob. |
| `gen:vendor`            | Re-copies the unpublished HtmlIr.* / TypedHtml.* source into `vendor/elm-foundation` (a committed elm.json source-directory). Run after changing either sibling, then commit — the committed copy is what CI compiles. |
| `gen:reference`         | Extracts API reference JSON from `elm make --docs`.      |
| `gen:examples`          | Builds the examples data JSON from the example sources.  |
| `gen:pages`             | `elm-pages gen` (regenerate `.elm-pages/`).              |
| `build:site`            | `elm-pages build` (production output) — the authoritative compile. |
| `check:drift`           | Fails if committed generated data is stale vs a fresh regen. |
| `check:nav`             | Nav/route consistency check.                             |
| `check:roundtrip`       | Roundtrip verification report.                           |
| `test:examples-gen`     | Unit tests for the HTML→Elm converter.                   |
| `test:roundtrip`        | Roundtrip tests.                                         |
| `test:browser`          | Playwright runtime contract harness.                     |
| `dev`                   | `elm-pages dev`. Does NOT regenerate anything — run `gen` explicitly. |
| `serve`                 | Serves the built `dist/` output.                         |

> **`dev` no longer regenerates.** It used to run the asset pipeline first, which
> meant starting the dev server rewrote git-tracked JSON. Generation is now
> explicit (`gen`), and `check:drift` fails the gate if the committed output is
> stale — so staleness is caught at push time instead of surprising you at `dev`.
