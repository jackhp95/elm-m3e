# Layers, forms, enforcement, and a compilable starter

## The two axes (from `docs/DESIGN.md` §1, §3)

- **Layer axis** — how raw you go. `M3e` (top) → `M3e.Html` (Html) → `M3e.Raw` (raw) →
  raw `elm/html`: a *safety* gradient. Dropping a layer is rawer, less convenient, less
  safe. Only `toHtml` is eager.
- **Form axis** — how strict one call site is (top layer only): how required/optional
  parts are passed. Namespace depth here names a form, **not** less safety —
  `M3e.Record`/`M3e.Build` are deeper yet *safer*.

## Full layer/form table

| Layer/form | Namespace | Call form | Guarantee |
|------------|-----------|-----------|-----------|
| top layer, standard form (barrel, flat) | `M3e` | `M3e.button [attrs] [content]` | one import; enum + slot-kind checked at compile |
| top layer, standard form (per-component) | `M3e.Button` | `M3e.Button.view [attrs] [content]` | same as barrel, qualified |
| Record form (required record) | `M3e.Record.Button` | `view { required } [attrs] [content]` | + missing-required is a compile error |
| Build form (availability pipeline) | `M3e.Build.Button` | `seed {req} \|> setter \|> build` | + duplicate-singular is unwritable |
| Html layer (lazy IR attrs) | `M3e.Html.Button` | `M3e.Html.Button.button [attrs] children` | phantom Value + capability, no top-layer slotting sugar |
| raw layer (partial `elm/html`) | `M3e.Raw.Button` | `M3e.Raw.Button.button [Html.Attribute] [Html]` | no phantom types; the floor |

## Which mistake each layer/form catches (§3)

| Mistake | standard form | Record form | Build form |
|---------|:---:|:---:|:---:|
| Invalid enum token | compiler | compiler | compiler |
| Wrong slot-kind child | compiler | compiler | compiler |
| Missing **required** (label/action) | linter | **compiler** | **compiler** |
| **Duplicate singular** (`icon` twice) | linter | linter | **impossible** |

The standard form leans on `elm-review` (the Cem rules) for the bottom two rows; the
Record and Build forms convert them to type errors. Choose the layer/form by which
guarantee the screen actually needs — do not blanket-adopt the Build form "to be safe";
it costs per-component qualified imports and pipeline ceremony.

## Barrel setter naming

Shared scalar setters are re-exposed on the barrel `attr`-prefixed and self-categorizing:
`M3e.attrDisabled`, `M3e.attrValue`, `M3e.attrName`, `M3e.attrChecked`. Where a type
conflicts across components, both are kept: `attrValue : String -> …` **plus**
`attrValueFloat : Float -> …`, each with a distinct capability so the wrong-typed setter
cannot unify. ARIA setters keep natural names (`M3e.ariaLabel`).

## Compilable starter

A `Browser.sandbox` counter with a filled button and an icon. Copy `docs/kit/Kit.elm`
into your app's source directory first (the seam producers are not in the package).

```elm
module Main exposing (main)

import Browser
import Html exposing (Html)
import Kit
import M3e
import M3e.Element as Element
import M3e.Token as Token
import Native


type alias Model =
    { count : Int }


type Msg
    = Inc


init : Model
init =
    { count = 0 }


update : Msg -> Model -> Model
update Inc model =
    { model | count = model.count + 1 }


view : Model -> Html Msg
view model =
    -- The single eager exit: IR -> Html.
    Element.toNode (screen model)


screen : Model -> Element.Element { s | html : Token.Supported } Msg
screen model =
    Native.div "flex flex-col gap-4 p-6"
        [ Kit.text ("Count: " ++ String.fromInt model.count)
        , M3e.button
            [ M3e.variant Token.filled
            , M3e.onClick Inc
            ]
            [ M3e.buttonSlotIcon (M3e.icon [ M3e.attrName "add" ] [])
            , Kit.text "Increment"
            ]
        ]


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }
```

> **JS registration required.** This compiles, but renders nothing until the app's
> `index.js` does `import "@m3e/web";` before `Elm.Main.init`. See the SKILL body.

(Exact attribute/slot names per component — `M3e.onClick` vs `M3e.Button.onClick`,
`buttonSlotIcon`, `variant` — come from that component's `src/M3e/Button.elm` doc
comment and the generated implementation card; verify against them, don't guess.)
