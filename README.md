# elm-m3e · `M3e.*` — type-safe Material 3 Expressive for Elm

A **Make-Impossible-States-Impossible** Elm surface over matraic's
[`@m3e/web`](https://github.com/matraic/m3e) Material 3 Expressive web components.
The invariant is the **Material 3 spec + accessibility**, not the DOM: slots are
typed to the kinds M3 allows, accessible-name attributes (`M3e.Aria.label`,
`labelledby`, `describedby`) are first-class, and the whole library is
**generated** — you learn two or three components and you know them all, because
they came from the same machine.

> **Accessible names — enforcement status.** The type system guarantees valid
> *slotting*, but it does **not** yet force an accessible name onto components
> that need one; the Aria attributes are optional. A codegen-aware advisory
> elm-review rule (`RequireAriaLabel`, driven by per-component facts of which
> components require a name) is **planned, not yet implemented**. Until it lands,
> treat accessible names as an author responsibility, not a compile- or
> lint-time guarantee.

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

Every component ships two equivalent surfaces: a **per-component** module whose
entry point is `view` (`M3e.TreeItem.view`, `M3e.Icon.view`) and a **barrel**
`M3e` module whose entry point is the component's lowercase name (`M3e.treeItem`,
`M3e.icon`). Either takes up to three arguments — an optional **required record**,
an **attributes list**, and a **content list** — and returns an `Element` that
collapses to `Html` exactly once, at the application root, via `M3e.Node.toHtml`:

```elm
import Html exposing (Html)
import Kit
import M3e.Element
import M3e.Icon
import M3e.Node
import M3e.TreeItem


tree : Html msg
tree =
    M3e.TreeItem.view
        { label = Kit.text "Getting Started" }              -- required-singular slots (record)
        [ M3e.TreeItem.disabled True ]                      -- attributes (phantom capability row)
        [ M3e.TreeItem.icon                                 -- content (phantom slot row)
            (M3e.Icon.view [ M3e.Icon.name "folder" ] [])
        , M3e.TreeItem.child
            (M3e.TreeItem.view { label = Kit.text "Child" } [] [])
        ]
        -- one conversion at the application root turns the typed IR into Html:
        |> M3e.Element.toNode
        |> M3e.Node.toHtml
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
pnpm install
pnpm run build     # -> docs/dist  (CSS is Vite/Tailwind-bundled & content-hashed;
                   #                custom elements are bundled from index.ts)
pnpm start         # local dev server
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
