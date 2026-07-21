# elm-m3e · `M3e.*` — type-safe Material 3 Expressive for Elm

[![CI](https://github.com/jackhp95/elm-m3e/actions/workflows/ci.yml/badge.svg)](https://github.com/jackhp95/elm-m3e/actions/workflows/ci.yml)
[![License: BSD-3-Clause](https://img.shields.io/badge/License-BSD--3--Clause-blue.svg)](LICENSE)

A **Make-Impossible-States-Impossible** Elm API over matraic's
[`@m3e/web`](https://github.com/matraic/m3e) Material 3 Expressive web components.
The invariant is the **Material 3 spec + accessibility**, not the DOM: slots are
typed to the kinds M3 allows, accessible-name requirements are lint-enforced (an
`elm-review` rule refuses a nameless icon-only control), and the whole library is
**generated** — you learn two or three components and you know them all, because
they came from the same machine.

> **Accessible names.** Valid *slotting* is a compile-time guarantee. Accessible names are
> a lint-time guarantee: per-component facts mark controls like `iconButton`/`fab` as
> requiring `aria-label`, and the codegen-aware `missingRequiredAttribute` rule refuses a
> nameless control — run `elm-review` in CI to hold it.

> **Status: prerelease, not yet published.** Breaking changes are embraced; the
> priority is correctness and uniformity over back-compat.

## What's in the repo

The published Elm package **is** the repo root (`elm.json` + `src/`); everything
else is generator, docs, and tooling that consumers never download.

```
elm.json + src/        THE library — the package root. Generated M3e.* modules
                       (general surface + per-component modules). The IR core
                       (HtmlIr.*) is imported from the elm-html-intermediate-
                       representation package, NOT emitted here.
config/slots.json      The declarative config that shapes the generated surface
                       (per-slot kinds/multi/required + aria/action/variant groups).
                       Its "_phantom": true switches on the phantom pipeline.
elm-cem/ (sibling)     The library-agnostic generator (the phantom pipeline).
                       Regenerates src/ from the @m3e/web CEM + config.
docs/                  The elm-pages docs site + the design docs (read order below).
docs/kit/              Userland producer kit (copyable, NOT in the package):
                       Kit (text/link), Native (native-HTML IR), Seam.
review/                The codegen-aware elm-review config.
tests/                 IR-core + slot unit tests (self-contained elm-test project);
                       tests/build-shape/ holds the per-component build type-form checks.
```

## Install

`elm-m3e` is a **single Elm package** — the whole `M3e.*` surface plus its one runtime
dependency, the shared IR:

```bash
# The shared phantom-typed HTML IR (HtmlIr.*), imported by every generated brand:
elm install jackhp95/elm-html-intermediate-representation

# The library itself (the general surface + every per-component module):
elm install jackhp95/elm-m3e
```

The package exposes **two coordinated surfaces**:

| Surface | Modules | Purpose |
|---|---|---|
| **General** | `M3e`, `M3e.Attributes`, `M3e.Events`, `M3e.Values` | Every component in the `elm/html` call shape, one import (`M3e.button [attrs] [content]`), plus the shared attribute/event/value vocabulary. |
| **Per-component** | `M3e.Button`, `M3e.Dialog`, … (one per component) | The strict surface — narrowed values, required content, the incremental `build` pipeline, full compile-time guarantees. |

Plus a few support modules: `M3e.Kind` (the brand's phantom rows), `M3e.Coerce`
(config-blessed brand crossings), `M3e.Unsafe` (the `fromHtml` escape hatch), and
`M3e.Review.Facts` (elm-review facts, consumed by the `review/` app). The IR core
(`HtmlIr.Element/Node/Attribute/Value/Kind`, `HtmlIr.Internal`) comes from the
`elm-html-intermediate-representation` dependency — it is **imported, not bundled**.

> **Prerelease.** Until `1.0.0` is tagged and published these commands will not yet
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

## The API

One component, **two surfaces** — general and per-component. Both are element↔attr
typed and compiler-checked; the per-component surface adds required-content,
narrowed values, and the incremental `build` pipeline. See
[`docs/DESIGN.md`](docs/DESIGN.md):

| | Module | Call | When |
| --- | --- | --- | --- |
| **general** | `M3e` | `M3e.treeItem [attrs] [content]` — lowercase name, one import | the everyday default |
| **general vocabulary** | `M3e.Attributes` / `M3e.Events` / `M3e.Values` | `M3e.Attributes.open True`, `M3e.Events.onClick …` | shared attribute/event/value setters, library-wide unions |
| **per-component** | `M3e.TreeItem` | `M3e.TreeItem.view [attrs] [content]` | tighter narrowed values + required content, compile-time |
| **per-component build** | `M3e.TreeItem` | `M3e.TreeItem.build { … } \|> M3e.TreeItem.open True \|> …` | the incremental pipeline where a one-only setter can't be written twice |

The two surfaces are peers: the general surface is the `elm/html`-shaped everyday
API; drop to `M3e.<Component>` when you want the compiler (not `elm-review`) to enforce
required content and placed-child slot-kinds. Exactly three checks — missing-required,
duplicate-singular, and slot-kind of a child placed via a slot function — are
`elm-review` guidance on the general surface and compile errors on the per-component
surface; everything else (invalid enum token, wrong attr on an element, wrong-kind
direct child) is a compile error on both. **Start general; reach for `M3e.<Component>`
when you want the tighter guarantees.**

A call returns an `Element` — a lazy, phantom-typed IR node — which collapses to
`Html` exactly once, at the application root, via
`HtmlIr.Element.toNode >> HtmlIr.Node.toHtml`:

```elm
import Html exposing (Html)
import HtmlIr.Element
import HtmlIr.Node
import M3e
import M3e.TreeItem


tree : Html msg
tree =
    M3e.TreeItem.view
        [ M3e.TreeItem.open True ]                          -- attributes (phantom capability row)
        [ M3e.TreeItem.label (M3e.text "Getting Started")   -- a named slot (setter)
        , M3e.TreeItem.icon (M3e.icon [ M3e.Attributes.name "folder" ] [])
        , M3e.TreeItem.view [] [ M3e.TreeItem.label (M3e.text "Child") ]
            -- a default-slot child is just the raw Element — no wrapper
        ]
        -- one conversion at the application root turns the typed IR into Html:
        |> HtmlIr.Element.toNode
        |> HtmlIr.Node.toHtml
```

> **`M3e.text` is built in.** The general surface exposes `M3e.text : String -> Element …`
> directly — no userland seam needed for plain text content. For richer producers
> (`link`, `label`, `recast`, raw-`Html` crossings) copy `docs/kit/Seam.elm` + `Kit.elm`
> into your app (copy-paste, not a dependency) — that userland `Seam` is built on
> `HtmlIr.Internal` and is the sanctioned boundary between raw `Html` and the typed IR.

- **Type-level (the MISI that matters):** kind + capability validity via extensible
  phantom rows. A wrong attribute or a wrong-kind slot child is a **compile error**.
- **`arbitrary` slots** accept any element (a plain type variable). `Seam.recast`
  (from `docs/kit/Seam.elm`) is the loud, auditable override when the design system is wrong.
- **Advisory (elm-review):** required-presence, singular cardinality, and slot-kind
  correctness for children placed via a slot function
  (`Cem.ValidSlotKind`, `Lenient` by default / `Strict` opt-in) — see
  [`docs/DESIGN.md`](docs/DESIGN.md).
- The IR is for **composition**, not introspection; it renders once at
  `HtmlIr.Node.toHtml`.

## Quickstart

A complete, compiling `Main.elm` that needs **only the published package**
(`elm/browser` + `jackhp95/elm-m3e` + its `elm-html-intermediate-representation`
dependency). `M3e.text` is built in — no userland seam required for plain text:

```elm
module Main exposing (main)

import Browser
import Html exposing (Html)
import HtmlIr.Element
import HtmlIr.Node
import M3e
import M3e.Attributes
import M3e.Button
import M3e.Values as Value


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


view : Model -> Html Msg
view model =
    M3e.button
        [ M3e.Button.variant Value.filled
        , M3e.Button.onClick Clicked
        ]
        [ M3e.text ("Clicked " ++ String.fromInt model.count)
        , M3e.Button.icon (M3e.icon [ M3e.Attributes.name "add" ] [])
        ]
        |> HtmlIr.Element.toNode
        |> HtmlIr.Node.toHtml
```

Remember the [wiring note](#install): nothing renders until `@m3e/web` is imported
so the `<m3e-button>`/`<m3e-icon>` custom elements are registered.

## How it's built

`elm-cem` reads the `@m3e/web` **Custom Elements Manifest** plus a **hand-authored
`config/slots.json`** (encoding slot kinds, required attributes, and variant groups the
manifest doesn't carry) and — because that config sets `"_phantom": true` — runs the
**phantom pipeline**: it emits the general surface (`M3e` / `M3e.Attributes` / `M3e.Events`
/ `M3e.Values`) and one strict module per component (`M3e.Button`, …), all **importing**
the shared IR core (`HtmlIr.*`) rather than bundling it. The generator carries **no m3e
opinions** — all m3e specifics live in `config/`.

On a new `@m3e/web` release you **regenerate** — a runbook step you run, not
something that happens on its own (see the `regenerating-elm-m3e` skill). Components
already covered by `config/slots.json` regenerate cleanly; any component the manifest
*adds* that the config doesn't yet cover degrades to loose `arbitrary` slots (and skips
its required-attribute facts) until `config/slots.json` is updated by hand. Because an
uncovered component surfaces as loose `arbitrary` slots in the generated output, that gap
is visible rather than silent.

## Documentation site

The docs are an [elm-pages](https://elm-pages.com) app that renders **the real
library modules** (source-dirs point at `src` + `docs/kit`),
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

The old IR-introspection unit suite was removed — the per-component surface makes those
facts compile-time guarantees. Coverage now lives in four layers:

- **The type system** — a green compile of `src/M3e.elm` proves the *closed-slot*
  invariants: named-slot inputs and kind-restricted default child lists are compile
  errors, as is a wrong enum value or an unadmitted attribute. (Open `arbitrary`-default
  slots accept any element by design — their slot-kind correctness is elm-review
  guidance, not a compile-time fact; see the elm-review layer below.) Compile it via
  `npm run gate` (split + docs-size gate + isolation probe), which wires the unpublished
  `HtmlIr.*` dependency with `--dep-src` — a bare `elm make src/M3e.elm` fails on the
  missing IR module. The
  per-component `build` shape carries positive/negative type-level checks in
  [`tests/build-shape/BuildShapeTest.elm`](tests/build-shape/BuildShapeTest.elm)
  and [`BuildShapeNegative.elm`](tests/build-shape/BuildShapeNegative.elm).
- **elm-review rules** — the repo's strongest coverage. One rule is repo-local:
  `NoProprietaryDsClasses` (in [`review/src`](review/src/NoProprietaryDsClasses.elm)),
  with its own [`review/tests/`](review/tests/) suite (7 cases). It runs on top of the
  codegen-aware, facts-driven and seam rules — `ValidEnumValue`, `RequireSlot`,
  `SingularSlot`, `NoSeamOutsideAllowedModules`, `NoInternalImportOutsideAllowed`, … —
  which are sourced from the published
  [`jackhp95/elm-review-cem`](https://package.elm-lang.org/packages/jackhp95/elm-review-cem/latest/)
  package (a normal `elm-review` dependency — see
  [`review/README.md`](review/README.md)). Run with `elm-review --config review`.
- **`Test.Html.Query` runtime suite** — targeted regression tests for the hand-written
  IR core under [`tests/`](tests/): `NodeSlotTest.elm` (named-slot survives on
  `Raw`/mapped nodes, #79) and `IrCoreTest.elm` (`addChild` leaf no-op, `map`→`Raw`
  collapse, `slotWithAttr` for/id wiring, Text/Raw→`<span>` attr promotion). Run with
  `npm test` (wraps `elm-test --compiler node_modules/.bin/elm` from `tests/`).
- **Playwright** — [`docs/tests-browser/`](docs/tests-browser/), for the runtime contract
  (shadow DOM, DOM properties, the a11y tree) that only a real browser shows.

## Docs

- [`docs/DESIGN.md`](docs/DESIGN.md) — the library's design: layers, slots, shapes, seams.
- [`docs/CONFIG_SCHEMA.md`](docs/CONFIG_SCHEMA.md) — the `config/slots.json` schema.
- The [documentation site](https://elm-m3e.netlify.app) — the Guide, reference, and examples.

## Contributing, versioning & reporting

- **Contributing / running the checks:** [`CONTRIBUTING.md`](CONTRIBUTING.md).
- **Release notes / versioning:** [`CHANGELOG.md`](CHANGELOG.md) (Keep a Changelog;
  Elm enforces SemVer from the API).
- **Bugs & feature requests:** the repo's [GitHub issues](https://github.com/jackhp95/elm-m3e/issues).
- **Security issues:** please report privately — see [`SECURITY.md`](SECURITY.md).
- **Owner-only release steps:** [`RELEASE-CHECKLIST.md`](RELEASE-CHECKLIST.md).

See the repo's GitHub issues for tracked work.
