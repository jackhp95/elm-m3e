# elm-m3e · `M3e.*` — type-safe Material 3 Expressive for Elm

A **Make-Impossible-States-Impossible** Elm surface over matraic's
[`@m3e/web`](https://github.com/matraic/m3e) Material 3 Expressive web components.
The invariant is the **Material 3 spec + accessibility**, not the DOM: slots are
typed to the kinds M3 allows, and the whole library is **generated** by
[`elm-cem`](https://github.com/jackhp95/elm-cem) from the `@m3e/web` Custom
Elements Manifest — learn two or three components and you know them all.

> The `M3e.*` modules under `src/M3e/` are generated output; the hand-written
> surface is only the IR core (`M3e.Node`, `M3e.Element`, `M3e.Content`).

## Install

```bash
elm install jackhp95/elm-m3e
```

`M3e.*` only produces the **Elm** side — `<m3e-*>` custom-element markup. Register
the matching JS custom elements once, before your Elm app mounts:

```bash
npm install @m3e/web
```

```js
import "@m3e/web";          // registers every <m3e-*> element
import { Elm } from "./Main.elm";

Elm.Main.init({ node: document.getElementById("root") });
```

Without this, nothing you build here will render.

## Five addressable surfaces per component

| Surface | Module | Call shape |
| --- | --- | --- |
| **Barrel** (top) | `M3e` | `M3e.button [attrs] [content]` — lowercase name |
| **Per-component** (top) | `M3e.Button` | `M3e.Button.view [attrs] [content]` — double list |
| **Record** (top) | `M3e.Record.Button` | `view { required } [attrs] [content]` |
| **Middle** | `M3e.Cem.Button` | phantom-typed attrs, `Html` children, returns `Html` |
| **Bottom** | `M3e.Cem.Html.Button` | plain `elm/html`, one constructor per tag |

The three **top** shapes are co-equal peers; the `M3e` → `M3e.Cem` → `M3e.Cem.Html`
axis is the escape gradient (deeper = less safe, more raw). **Start at the top.**

A top-layer call returns an `Element` — a lazy, phantom-typed IR node — which
collapses to `Html` exactly once, at the application root, via
`M3e.Element.toNode >> M3e.Node.toHtml`.

## Quickstart

A complete, compiling `Main.elm` that needs only this package plus `elm/browser`:

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


{-| The text seam: lift a String into slot-admissible text content. `text`/`link`/
`label` producers are userland semantic seams — in a real app they live in one
small adapter module. `M3e.Seam.Internal` is the fenced crossing they are built on.
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

## Where to start reading

- `M3e.Button`, `M3e.Dialog`, `M3e.Icon`, `M3e.List` — common components.
- `M3e.Value` — the enum token vocabulary (`filled`, `outlined`, `rounded`, …).
- `M3e.Aria` — accessible-name attributes, settable on any component.
- `M3e.Node` / `M3e.Element` — the opaque IR and the `toNode`/`toHtml` extraction.

## Concepts

- **Typed slots.** Slot children are phantom-typed to the kinds Material 3 allows;
  a wrong-kind child is a compile error. `any` slots accept any element.
- **Attributes** are a phantom capability row — a wrong attribute is a compile
  error. Values that map to a fixed set take an `M3e.Value` token.
- **Events** take your `msg` (or a decoder) directly, e.g. `M3e.Button.onClick`.
- **One render.** The IR is for composition, not introspection; it renders once at
  `M3e.Element.toNode >> M3e.Node.toHtml`.

## Rebuild check

```bash
elm make src/M3e.elm --output=/dev/null   # compiles all exposed modules
```

## License & links

BSD-3-Clause (see [`LICENSE`](LICENSE)). Source, issues, changelog, and the full
design docs live at <https://github.com/jackhp95/elm-m3e>.
