module Route.Concepts.PhantomRows exposing (ActionData, Data, Model, Msg, route)

{-| A conceptual page (`/concepts/phantom-rows`) on the **kind row** mental model:
why you never "convert" a phantom row, a component→slot-kind cheat-sheet, the
kitchen-sink open row, and the fact that `Native.node` takes typed `Attr`s.

Prose is rendered through the shared Markdown pipeline (`Doc.markdown`); code
samples are syntax-highlighted Elm (`Doc.code_`).

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
        , description = "The phantom kind-row mental model: never convert a row, a slot-kind cheat-sheet, the kitchen-sink open row, and Native.node."
        , locale = Nothing
        , title = "Phantom rows · elm-m3e"
        }
        |> Seo.website


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


section : String -> List (Block msg) -> Block msg
section title items =
    Layout.section "space-y-3" (heading2 title :: items)


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Phantom rows · elm-m3e"
    , body =
        [ Element.toNode
            (pane
                [ Layout.div "space-y-10"
                    [ Layout.section "space-y-4"
                        [ heading1 "Phantom rows"
                        , Layout.div "max-w-2xl text-on-surface-variant" [ Doc.markdown intro ]
                        ]
                    , section "Never “convert” a phantom row"
                        [ Doc.markdown neverConvert
                        , Doc.code_ Doc.Elm neverConvertCode
                        ]
                    , section "Component → slot-kind cheat-sheet"
                        [ Doc.markdown cheatSheet ]
                    , section "The kitchen-sink row"
                        [ Doc.markdown kitchenSink
                        , Doc.code_ Doc.Elm kitchenSinkCode
                        ]
                    , section "`Native.node` takes `Attr`"
                        [ Doc.markdown nativeNode
                        , Doc.code_ Doc.Elm nativeNodeCode
                        ]
                    ]
                ]
            )
        ]
    }


intro : String
intro =
    """Every `M3e.*` value is an `Element` carrying three *extensible phantom rows* — one for the **values** an attribute accepts, one for the **attributes** a component admits, and one for the **kind** an element *is*. This page is the mental model for that third row, the **kind row**, and how to live with it in everyday composition.

The kind row is how slots stay type-safe: a slot is a **closed** consumer ("I accept only these kinds") and a piece of content is an **open** producer ("I am *at least* this kind"). They meet at compile time — no runtime slot checks, no orphan content silently vanishing into the default slot."""


neverConvert : String
neverConvert =
    """`M3e.Button.view … : Element { s | button : Supported } msg` reads as *"I am a button."* You never rewrite that into `{ icon }` or anything else. Composition in this library is **add-only**: helpers like `withSlot`, `leadingIcon`, or the `M3e.*` slot setters only ever *add* a `slot=` association — they never change or strip the kind.

So there is no `phantomA → phantomB` conversion function, by design. If you genuinely must place a kind a slot forbids (you believe the design system is wrong), you don't "convert" — you reach for the loud, greppable break-glass `Seam.stripPhantom` (formerly `EscapeHatch.asElement`). It coerces the row, it's easy to `grep`, and the design-system team **audits** every use: they either fix the misuse or fix the generated binding. It's a pressure-release valve, not a data transformation."""


neverConvertCode : String
neverConvertCode =
    """-- add-only: withSlot keeps the kind, just associates the slot
withSlot : String -> Element supported msg -> Element supported msg

-- there is deliberately NO conversion like this:
-- convert : Element { button } msg -> Element { icon } msg   -- does not exist

-- the only escape is loud, greppable, and audited:
Seam.stripPhantom : Element a msg -> Element b msg"""


cheatSheet : String
cheatSheet =
    """Each slot lists exactly the kinds it accepts. A few representative components (read the per-component **API** page for the rest):

| Component | Slot | Accepts |
|---|---|---|
| `M3e.Button` | `icon` | `icon`, `loadingIndicator` |
| `M3e.Button` | *(default)* | `text`, `icon`, `html` |
| `M3e.Card` | `content` | **any** (unrestricted) |
| `M3e.AppBar` | `leading` | `icon`, `iconButton`, `button`, … |
| `M3e.AppBar` | `title` / `subtitle` | `text`, `html` |
| `M3e.ListItem` | `leading` | `icon`, `avatar`, `text`, `html` |
| `M3e.ListItem` | `trailing` | `icon`, `avatar`, `text`, `html`, `switch`, `radio`, `checkbox` |
| `M3e.ListItem` | `overline` / `supporting-text` | `text`, `html` |
| `M3e.NavMenuItem` | `icon` | `icon` |
| `M3e.NavMenuItem` | *(default)* | `navMenuItem` (nested items) |

Two things to note. An **`any`** slot (like `Card.content : Element any msg`) takes a bare type variable, so *every* kind fits — that's the widest sink. And a **closed** slot lists a fixed set; to place anything outside it you must step through `Seam`, never a conversion."""


kitchenSink : String
kitchenSink =
    """If slots are closed consumers, producers are the open counterpart. Userland producers return an **open row** so one value drops into many slots:

- `Kit.text : String -> Element { k | text : Supported } msg` — the `k |` means *"at least text"*, so it unifies with any slot that lists `text`.
- Non-semantic native tags (`Native.div`, `Native.p`, `Native.span`) return `Element any msg` — the **widest producer**. A bare type variable in the kind slot means *"any kind at all"*, so it drops into every slot. (Semantic native tags instead stamp their real kind: `Native.a` is `link`, `Native.label` is `label`.)
- The **kitchen-sink** `html` kind is what `Seam.fromHtml` and `Native.node` carry — `Element { k | html : Supported } msg`. It fits every `any` slot (Card content, Dialog body) and every closed slot that lists `html`.

The open producer row ("I am *at least* X") meets the closed slot row ("I accept *at most* these") in the middle. That handshake is the whole slot-safety story — and `any` slots, being a free type variable, accept the kitchen-sink and everything else."""


kitchenSinkCode : String
kitchenSinkCode =
    """-- open producers (`k |`) fit many closed slots; Seam.fromHtml / Native.node
-- carry the kitchen-sink `html` kind:
text : String -> Element { k | text : Supported } msg
Seam.fromHtml : Html msg -> Element supported msg

-- non-semantic native tags go one wider — `Element any`, which fits EVERY slot:
Native.p : List (Attr { slot : Supported } msg) -> List (Element s msg) -> Element any msg

-- an `any` slot is the widest sink — a bare type variable:
content : Element any msg -> Content { r | content : Supported } msg

Card.content (Native.p [] [ Kit.text "arbitrary prose is fine here" ])"""


nativeNode : String
nativeNode =
    """The native-HTML producers — `Native.node`, `Native.div`, `Native.span`, `Native.p`, … — are first-class IR `Element`s, not a way out of the type system. The key detail: their attribute list is the **typed middle-layer `Attr`**, *not* raw `Html.Attribute`. `Native.node` takes a fully-open `List (Attr c msg)`; the generated tags take an HTML-natural, element-constrained row (every tag admits `slot`; `Native.a` also admits `href`/`target`, and so on).

So you compose the very same typed setters onto a plain `<div>` that you would onto an `<m3e-button>` — `Aria.label`, `Kit.tint`, `Seam.asAttribute (class …)`. Typed attrs in, children of any kind in, and a slottable `Element` out: `Native.node` stamps the kitchen-sink `html` kind, while a non-semantic tag like `Native.div` goes wider still to `Element any`. Native elements stay inside the same composition system."""


nativeNodeCode : String
nativeNodeCode =
    """node :
    (List (Html.Attribute msg) -> List (Html msg) -> Html msg) -- the elm/html tag fn
    -> List (Attr c msg)                                        -- TYPED middle-layer attrs
    -> List (Element s msg)                                     -- children of any kind
    -> Element { k | html : Supported } msg                     -- kitchen-sink html Element

Native.div
    [ Kit.tint [ Kit.primary ], Aria.label "greeting" ]
    [ Kit.text "hello" ]"""
