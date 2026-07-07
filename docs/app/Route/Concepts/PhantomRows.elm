module Route.Concepts.PhantomRows exposing (ActionData, Data, Model, Msg, route)

{-| A conceptual page (`/concepts/phantom-rows`) on **one mechanism inside the
layers**: the phantom **kind row** that makes the top layer's slot composition
type-safe. The producer-open / consumer-closed handshake, a component→slot-kind
cheat-sheet, and why you never "convert" a row (you cross the seam instead).

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
        , description = "The phantom kind row — one mechanism inside the layers: the producer-open/consumer-closed handshake that makes slot composition type-safe, plus a slot-kind cheat-sheet."
        , locale = Nothing
        , title = "Phantom rows · elm-m3e"
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
    { title = "Phantom rows · elm-m3e"
    , body =
        [ Element.toNode
            (pane
                [ Layout.div "space-y-12"
                    [ Layout.section "space-y-4"
                        [ heading1 "Phantom rows"
                        , lead intro
                        ]
                    , section "The three rows"
                        [ Doc.markdown threeRows ]
                    , section "Producer open, consumer closed"
                        [ Doc.markdown handshake
                        , Doc.code_ Doc.Elm handshakeCode
                        ]
                    , section "Component → slot-kind cheat-sheet"
                        [ Doc.markdown cheatSheet ]
                    , section "You never convert a row"
                        [ Doc.markdown neverConvert
                        , Doc.code_ Doc.Elm neverConvertCode
                        ]
                    ]
                ]
            )
        ]
    }



-- PROSE -----------------------------------------------------------------------


intro : String
intro =
    "The layers are the map; this is one mechanism inside them. The top layer's slot safety rides on phantom types — extensible rows carried on public signatures that erase to uniform thunks at runtime but are fully checked at every composition. This page zooms into the row that governs slots: the kind row."


threeRows : String
threeRows =
    """Every `M3e.*` value carries three extensible phantom rows, introduced across the middle and top layers:

| # | Row | Guards | Producer / consumer |
|---|---|---|---|
| 1 | `Value { v \\| … }` | which **values** an enum attr accepts | token open / setter input |
| 2 | `Attr { c \\| … }` | which **attrs** a component admits | setter open / component closed |
| 3 | `Element { s \\| … }` | which **kind** an element *is* (its slots) | child open / slot closed |

Without the rows on the return types the composition guarantees fall apart — they are the foundation of the whole effort, not an option. The rest of this page is about row #3, the **kind row**, and how to live with it in everyday composition."""


handshake : String
handshake =
    """The kind row is how slots stay type-safe: a **slot** is a *closed consumer* ("I accept only these kinds") and a piece of **content** is an *open producer* ("I am *at least* this kind"). They meet at compile time — no runtime slot checks, no orphan content silently vanishing into the default slot.

- `Kit.text : String -> Element { k | text : Supported } msg` — the `k |` means *"at least text"*, so it unifies with any slot that lists `text`.
- Non-semantic native tags (`Native.div`, `Native.p`) return `Element any msg` — the **widest producer**. A bare type variable in the kind slot means *"any kind at all"*, so it drops into every slot.
- An **`any` slot** (like `Card.content : Element any msg`) is the widest sink — a bare type variable that accepts every kind.

The open producer row ("at least X") meets the closed slot row ("at most these") in the middle. That handshake is the entire slot-safety story."""


handshakeCode : String
handshakeCode =
    """-- open producers (`k |`) fit many closed slots:
text : String -> Element { k | text : Supported } msg

-- non-semantic native tags go widest — `Element any` fits EVERY slot:
Native.p : List (Attr c msg) -> List (Element s msg) -> Element any msg

-- an `any` slot is the widest sink — a bare type variable:
content : Element any msg -> Content { r | content : Supported } msg

Card.content (Native.p [] [ Kit.text "arbitrary prose is fine here" ])"""


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
| `M3e.NavMenuItem` | `icon` | `icon` |
| `M3e.NavMenuItem` | *(default)* | `navMenuItem` (nested items) |

An **`any`** slot takes a bare type variable, so *every* kind fits — the widest sink. A **closed** slot lists a fixed set; to place anything outside it you cross the seam, never a conversion."""


neverConvert : String
neverConvert =
    """`M3e.Button.view … : Element { s | button : Supported } msg` reads as *"I am a button."* You never rewrite that into `{ icon }` or anything else. Composition here is **add-only**: `withSlot`, `leadingIcon`, and the slot setters only ever *add* a `slot=` association — they never change or strip the kind. So there is deliberately no `phantomA → phantomB` conversion function.

If you genuinely must place a kind a slot forbids, you don't convert — you reach for the loud, greppable, audited `Seam.stripPhantom`. That break-glass and the whole escape story live on the [Userland](/concepts/userland) page."""


neverConvertCode : String
neverConvertCode =
    """-- add-only: withSlot keeps the kind, just associates the slot
withSlot : String -> Element supported msg -> Element supported msg

-- there is deliberately NO conversion like this:
-- convert : Element { button } msg -> Element { icon } msg   -- does not exist

-- the only escape is loud, greppable, and audited (see Userland):
Seam.stripPhantom : Element a msg -> Element b msg"""
