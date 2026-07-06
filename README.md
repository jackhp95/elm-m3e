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

## Install

```bash
elm install jackhp95/elm-m3e
```

> **Prerelease.** Until `1.0.0` is tagged and published this command will not yet
> resolve; see [`RELEASE-CHECKLIST.md`](RELEASE-CHECKLIST.md) for the owner-only
> publish steps.

`M3e.*` only produces the **Elm** side — `<m3e-*>` custom-element markup. Those
elements do nothing until the matching JS custom elements are registered. In your
consuming app, install and import the web components once at startup:

```bash
npm install @m3e/web
```

```js
// index.js — register every <m3e-*> element before your Elm app mounts
import "@m3e/web";
import { Elm } from "./Main.elm";

Elm.Main.init({ node: document.getElementById("root") });
```

## The API — five addressable surfaces per component

Every component is generated at **five** addressable surfaces
(see [ADR 0013](docs/adr/0013-top-shape-matrix-and-translation.md)):

| Surface | Module | Call shape |
| --- | --- | --- |
| **Barrel** (top) | `M3e` | `M3e.treeItem [attrs] [content]` — lowercase name |
| **Per-component** (top) | `M3e.TreeItem` | `M3e.TreeItem.view [attrs] [content]` — double list |
| **Record** (top) | `M3e.Record.TreeItem` | `view { required } [attrs] [content]` — required slots hoisted into a record |
| **Middle** | `M3e.Cem.TreeItem` | phantom-typed attrs, ordinary `Html` children, returns `Html` |
| **Bottom** | `M3e.Cem.Html.TreeItem` | plain `elm/html`, one constructor per tag |

The three **top** shapes are co-equal peers — the extra `M3e.Record` / `M3e.Build`
segment names a *shape variant*, not a deeper/less-safe layer. The
`M3e` → `M3e.Cem` → `M3e.Cem.Html` axis is the **escape gradient** (deeper = less
safe, more raw). **Start at the top** (`M3e.*` or the `M3e` barrel); reach deeper
only to escape.

A top-layer call returns an `Element` — a lazy, phantom-typed IR node — which
collapses to `Html` exactly once, at the application root, via
`M3e.Element.toNode >> M3e.Node.toHtml`:

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
        [ M3e.TreeItem.open True ]                          -- attributes (phantom capability row)
        [ M3e.TreeItem.label (Kit.text "Getting Started")   -- content (phantom slot row)
        , M3e.TreeItem.icon
            (M3e.Icon.view [ M3e.Icon.name "folder" ] [])
        , M3e.TreeItem.child
            (M3e.TreeItem.view [] [ M3e.TreeItem.label (Kit.text "Child") ])
        ]
        -- one conversion at the application root turns the typed IR into Html:
        |> M3e.Element.toNode
        |> M3e.Node.toHtml
```

The same tree in the **Record** shape hoists the required `label` slot into a
record, so the compiler enforces its presence exactly once:

```elm
M3e.Record.TreeItem.view
    { label = Kit.text "Getting Started" }
    [ M3e.Record.TreeItem.open True ]
    [ M3e.Record.TreeItem.icon (M3e.Icon.view [ M3e.Icon.name "folder" ] []) ]
```

> **`Kit.text` is userland.** `text`/`link`/`label` producers are config-declared
> semantic *seams*, not part of the published package — the `Kit` module above
> lives in `packages/m3e-kit/` (copy-paste, not a dependency). A consuming app
> supplies its own via a small `Seam` adapter; the [Quickstart](#quickstart)
> below shows a minimal one that needs only the published package.

- **Type-level (the MISI that matters):** kind + capability validity via extensible
  phantom rows. A wrong attribute or a wrong-kind slot child is a **compile error**.
- **`any` slots** accept any element (a plain type variable). **`EscapeHatch`** is the
  loud, auditable break-glass when the design system is wrong.
- **Advisory (generated elm-review + docs):** required-presence and singular
  cardinality — see [ADR 0011](docs/adr/0011-ir-faithfulness-advisory-cardinality.md).
- The IR is for **composition**, not introspection; it renders once at
  `M3e.Node.toHtml`.

## Quickstart

A complete, compiling `Main.elm` that needs **only the published package**
(`elm/browser` + `jackhp95/elm-m3e`). The `text` helper is the one-line seam a
consuming app writes once (or copies from `packages/m3e-kit/`) to turn a `String`
into slot-admissible content:

```elm
module Main exposing (main)

import Browser
import Html exposing (Html)
import M3e.Button
import M3e.Element
import M3e.Element.Internal
import M3e.Icon
import M3e.Node
import M3e.Seam.Internal
import M3e.Value


type alias Model =
    { count : Int }


type Msg
    = Clicked


main : Program () Model Msg
main =
    Browser.sandbox
        { init = { count = 0 }
        , update = \Clicked model -> { model | count = model.count + 1 }
        , view = view
        }


{-| The text seam: lift a String into slot-admissible text content. In a real app
this (and its `link`/`label` friends) live in one small `Seam`/`Kit` adapter
module — copy `packages/m3e-kit/src/Seam.elm` + `Kit.elm`.
-}
text : String -> M3e.Element.Element { s | text : M3e.Value.Supported } msg
text s =
    M3e.Seam.Internal.text (M3e.Element.Internal.fromNode (M3e.Node.text s))


view : Model -> Html Msg
view model =
    M3e.Button.view
        [ M3e.Button.variant M3e.Value.filled
        , M3e.Button.onClick Clicked
        ]
        [ M3e.Button.child (text ("Clicked " ++ String.fromInt model.count))
        , M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "add" ] [])
        ]
        |> M3e.Element.toNode
        |> M3e.Node.toHtml
```

Remember the [wiring note](#install): nothing renders until `@m3e/web` is imported
so the `<m3e-button>`/`<m3e-icon>` custom elements are registered.

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

## Contributing, versioning & reporting

- **Contributing / running the checks:** [`CONTRIBUTING.md`](CONTRIBUTING.md).
- **Release notes / versioning:** [`CHANGELOG.md`](CHANGELOG.md) (Keep a Changelog;
  Elm enforces SemVer from the API).
- **Bugs & feature requests:** the repo's [GitHub issues](https://github.com/jackhp95/elm-m3e/issues).
- **Security issues:** please report privately — see [`SECURITY.md`](SECURITY.md).
- **Owner-only release steps:** [`RELEASE-CHECKLIST.md`](RELEASE-CHECKLIST.md).

See the repo's GitHub issues for tracked work.
