# elm-m3e · `M3e.*` — type-safe Material 3 Expressive for Elm

A **Make-Impossible-States-Impossible** Elm surface over matraic's
[`@m3e/web`](https://github.com/matraic/m3e) Material 3 Expressive web components.
The invariant is the **Material 3 spec + accessibility**, not the DOM: slots are
typed to the kinds M3 allows, accessible names are required by construction, and the
whole library is **generated** — you learn two or three components and you know them
all, because they came from the same machine.

> **Status: prerelease, not yet published.** Breaking changes are embraced; the
> priority is correctness and uniformity over back-compat.

## What's in the repo

```
packages/m3e/          THE library — generated M3e.* modules (components + IR core).
                       A standalone Elm package (own elm.json, exposed-modules synced).
packages/m3e-kit/      Userland producer kit (copyable, NOT in the package):
                       Kit (text/link), Native (native-HTML IR), EscapeHatch, Seam.
config/slots.json      The declarative config that shapes the generated top layer
                       (per-slot kinds/multi/required + aria/action/variant groups).
elm-cem/               The library-agnostic generator (its own repo, cloned here to
                       work; regenerates packages/m3e from the @m3e/web CEM + config).
docs/                  The elm-pages docs site + the design docs (read order below).
```

## The API — a double list per component

Every component is its lowercase name taking up to three arguments: an optional
**required record**, an **attributes list**, and a **content list**:

```elm
M3e.TreeItem.treeItem
    { label = Kit.text "Getting Started" }                  -- required-singular slots (record)
    [ TreeItem.disabled True ]                              -- attributes (phantom capability row)
    [ TreeItem.icon (Icon.icon [ Icon.name "folder" ] [])  -- content (phantom slot row)
    , TreeItem.child (TreeItem.treeItem { label = Kit.text "Child" } [] [])
    ]
```

- **Type-level (the MISI that matters):** kind + capability validity via extensible
  phantom rows. A wrong attribute or a wrong-kind slot child is a **compile error**.
- **`any` slots** accept any element (a plain type variable). **`EscapeHatch`** is the
  loud, auditable break-glass when the design system is wrong.
- **Advisory (generated elm-review + docs):** required-presence and singular
  cardinality — see [ADR 0011](docs/adr/0011-ir-faithfulness-advisory-cardinality.md).
- The IR is for **composition**, not introspection; it renders once at
  `M3e.Node.toHtml`.

## How it's built

`elm-cem` reads the `@m3e/web` **Custom Elements Manifest** plus `config/slots.json`
and emits all layers (bottom partial-applied `elm/html` → middle `M3e.Cem.*` → top
`M3e.*` double-list) plus the IR core. On a new `@m3e/web` release you regenerate and
it "just works". The generator carries **no m3e opinions** — all m3e specifics live in
`config/`.

## Documentation site

The docs are an [elm-pages](https://elm-pages.com) app that renders **the real
library modules** (source-dirs point at `packages/m3e/src` + `packages/m3e-kit/src`),
styled with Tailwind v4 + the
[`tailwind-m3e-web`](https://github.com/jackhp95/tailwind-m3e-web) bridge.

```bash
cd docs
npm install
npm run build      # -> docs/dist  (also rebuilds public/style.css + public/m3e.js)
npm start          # local dev server
```

Deploy (Netlify): **Base directory** = `docs`; build/publish come from
`docs/netlify.toml`.

## Testing

The old IR-introspection unit suite was removed — the double-list makes those facts
compile-time guarantees. Coverage now lives in **the type system** (a green
`elm make packages/m3e` proves every slot/attr invariant) plus
`docs/tests-browser/` (Playwright, for what only a real browser shows). A lean
render/`Test.Html.Query` suite may be added later for runtime-only behaviors.

## Docs (read order)

- [`docs/THE_COMPLETE_EFFORT.md`](docs/THE_COMPLETE_EFFORT.md) — the vision + every decision.
- [`docs/ADOPTION_AND_SLOTS.md`](docs/ADOPTION_AND_SLOTS.md) — the slot model, `any`,
  the escape/extensibility gradient (§8), and the proven encodings.
- [`docs/THREE_LAYER_PATTERN.md`](docs/THREE_LAYER_PATTERN.md) — the layer mechanics.
- [`docs/MIGRATION_OLD_TO_NEW.md`](docs/MIGRATION_OLD_TO_NEW.md) — old→new API migration.
- [`docs/adr/`](docs/adr/) — the architecture decisions (0008–0011 are current).

See the repo's GitHub issues for tracked work.
