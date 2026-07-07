module Route.Concepts.Layers exposing (ActionData, Data, Model, Msg, route)

{-| The lead conceptual page (`/concepts/layers`): the **surface gradient**.
elm-m3e is not one API but four surfaces over the same `<m3e-*>` components —
`M3e.*` (with its `M3e.Record.*` / `M3e.Build.*` shapes) → `M3e.Cem.*` →
`M3e.Cem.Html.*` → raw `elm/html`. This page is the map: what each surface is,
what it returns, and when to reach for it. Drawn from THREE\_LAYER\_PATTERN.md and
ADRs 0008–0010.
-}

import BackendTask
import Doc
import Head
import Head.Seo as Seo
import Kit
import Layout
import M3e.ContentPane as ContentPane
import M3e.Element as Element exposing (Element)
import M3e.Record.Heading as Heading
import M3e.Value as Value exposing (Supported)
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatelessRoute)
import Shared
import UrlPath
import View exposing (View)


type alias Model =
    {}


type alias Msg =
    ()


type alias RouteParams =
    {}


type alias Data =
    {}


type alias ActionData =
    {}


route : StatelessRoute RouteParams Data ActionData
route =
    RouteBuilder.single { head = head, data = BackendTask.succeed {} }
        |> RouteBuilder.buildNoState { view = view }


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-m3e"
        , image = { url = [ "favicon.svg" ] |> UrlPath.join |> Pages.Url.fromPath, alt = "elm-m3e", dimensions = Nothing, mimeType = Nothing }
        , description = "The surface gradient: M3e.Cem.Html → M3e.Cem → M3e (with M3e.Record / M3e.Build) — what each layer is and when to reach for it."
        , locale = Nothing
        , title = "The layers · elm-m3e"
        }
        |> Seo.website



-- PAGE CHROME -----------------------------------------------------------------


pane : List (Element { s | html : Supported } msg) -> Element { r | contentPane : Supported } msg
pane items =
    ContentPane.view [] (List.map ContentPane.child items)


type alias Block msg =
    Element { html : Supported, heading : Supported, contentPane : Supported } msg


heading1 : String -> Block msg
heading1 s =
    Heading.view { content = Kit.text s }
        [ Heading.variant Value.display, Heading.size Value.small, Heading.level 1 ]
        []


heading2 : String -> Block msg
heading2 s =
    Heading.view { content = Kit.text s }
        [ Heading.variant Value.headline, Heading.size Value.small, Heading.level 2 ]
        []


lead : String -> Block msg
lead s =
    Layout.div "max-w-2xl"
        [ Kit.paragraph Value.large [ Kit.onSurfaceVariant ] [ Kit.text s ] ]


section : String -> List (Block msg) -> Block msg
section title items =
    Layout.section "space-y-4" (heading2 title :: items)


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "The layers · elm-m3e"
    , body =
        [ Element.toNode
            (pane
                [ Layout.div "space-y-12"
                    [ Layout.section "space-y-4"
                        [ heading1 "The layers"
                        , lead intro
                        ]
                    , section "The gradient"
                        [ Doc.markdown gradientProse
                        , Doc.code_ Doc.NoLang gradientDiagram
                        ]
                    , section "The four surfaces"
                        [ Doc.markdown surfacesTable ]
                    , section "The top has three shapes"
                        [ Doc.markdown topShapes
                        , Doc.code_ Doc.Elm topShapesCode
                        ]
                    , section "Descending for control"
                        [ Doc.markdown descending
                        , Doc.code_ Doc.Elm descendingCode
                        ]
                    ]
                ]
            )
        ]
    }



-- PROSE -----------------------------------------------------------------------


intro : String
intro =
    "elm-m3e is not one API but a gradient of surfaces over the same components. Every layer renders the same <m3e-*> custom elements — they differ only in how much the compiler holds for you and how much you spell out by hand. The correct way and the easy way are the same way: the top. You can always descend a layer for more control, but it takes a louder, more explicit step."


gradientProse : String
gradientProse =
    """Each outer layer **reuses the one below** — it passes the inner layer's functions upward rather than re-deriving them. A string like `"m3e-button"` or `"variant"` is therefore written exactly once, at the floor, and travels up as a partially-applied function. (Rule of thumb: *if you define the same string to do the same thing on two layers, you did it wrong.*)

Going down the gradient trades safety and convenience for control. The only eager point in the whole stack is `toHtml` at the app root — everything above it is a lazy IR held un-applied."""


gradientDiagram : String
gradientDiagram =
    """M3e.*            top     — lazy IR for components AND attrs; phantom kind rows
  └ M3e.Cem.*    middle  — lazy IR attributes; EAGER component (→ Html); Value + capability rows
      └ M3e.Cem.Html.*  bottom — partial applications of elm/html; NO phantom types; → Html
          └ raw elm/html — the floor; opaque"""


surfacesTable : String
surfacesTable =
    """| Layer | What it is | Returns | Reach for it when |
|---|---|---|---|
| `M3e.*` | Lazy IR with the three phantom rows; slot-safe, add-only composition. | `Element` | **The default** — almost always. |
| `M3e.Cem.*` | Typed attribute IR; the component is eager (attrs collapse to `Html` when applied). | `Html` | You're already outside the `Element` IR and want typed attrs straight to `Html`. |
| `M3e.Cem.Html.*` | Partial applications of `elm/html`; no phantom types. This is where the strings live. | `Html` | You need a bare tag or attribute with zero ceremony. |
| raw `elm/html` | The opaque floor. Cannot be composed by the IR. | `Html` | You're crossing back to hand-written `Html` — do it through [Userland](/concepts/userland)'s `Seam`. |

The safety you get is the three phantom rows the top carries — a value row (which values an attr accepts), a capability row (which attrs a component admits), and a kind row (which slots an element fits). Those are the mechanism behind slot-safe composition; see [Phantom rows](/concepts/phantom-rows)."""


topShapes : String
topShapes =
    """The top layer isn't a single function shape. A component ships **three** of them, and all three return the *same* slottable `Element` — they differ only in how you hand over the component's parts:

- **`M3e.Button.view [attrs] [content]`** — the options-list shape. Everything is optional; the tersest form.
- **`M3e.Record.Button.view { content, action } [attrs] [content]`** — a **required record** pins the collaborators a button can't render without (its content and its action) at the call site, so you can't forget them.
- **`M3e.Build.Button`** — a phantom-typed **pipeline**: seed a `Builder`, apply setters with `|>`, finish with `build`. Capabilities ride the builder's rows as `Available → Used`, so each optional setter applies at most once and order doesn't matter. See [The ⑤ Build pipeline](/concepts/build)."""


topShapesCode : String
topShapesCode =
    """-- same button, three shapes, one Element out:

M3e.Button.view
    [ M3e.Button.variant Value.filled ]
    [ Content.default (Kit.text "Save") ]

M3e.Record.Button.view
    { content = Kit.text "Save", action = Action.link "#" }
    [ Button.variant Value.filled ]
    []

M3e.Build.Button.button { content = Kit.text "Save", action = Action.link "#" }
    |> Button.variant Value.filled
    |> Button.build"""


descending : String
descending =
    """When the top can't express what you need — a tag the bindings don't model, an attribute you want applied by hand — you step down. The **middle** (`M3e.Cem.*`) still gives you typed attributes (`variant` guards its `Value` row, `disabled` takes a `Bool`) but the component is eager: it evaluates the collected attrs and returns opaque `Html`. The **bottom** (`M3e.Cem.Html.*`) drops the phantom types entirely — it is just `elm/html` with the tag and attribute names baked in."""


descendingCode : String
descendingCode =
    """-- middle: typed attrs, eager component → Html
M3e.Cem.Button.button
    [ M3e.Cem.Button.variant Value.filled ]
    [ Html.text "Save" ]

-- bottom: partial applications of elm/html, no phantom types → Html
M3e.Cem.Html.Button.button
    [ M3e.Cem.Html.Button.variant "filled" ]
    [ Html.text "Save" ]"""
