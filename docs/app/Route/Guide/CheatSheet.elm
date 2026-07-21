module Route.Guide.CheatSheet exposing (ActionData, Data, Model, Msg, route)

{-| Guide · Cheat sheet (`/guide/cheat-sheet`): the return-worthy tables in one
place — the layers, the three forms, the strictness dial, and where a
seam is allowed to live. Scannable reference, not narrative; the chapters teach
these, this is where you come back to look them up.
-}

import BackendTask
import Doc
import Head
import Head.Seo as Seo
import Kit
import Layout
import HtmlIr.Element exposing (Element)
import M3e.Kind
import M3e.Values as Value
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
        , description = "The Guide cheat sheet: the layers, the three forms, the strictness dial, and the seam allow-list — the return-worthy tables in one place."
        , locale = Nothing
        , title = "Cheat sheet · elm-m3e"
        }
        |> Seo.website


card : String -> List (Element { s | html : M3e.Kind.Brand } adm_ msg) -> Element { r | html : M3e.Kind.Brand } adm_ msg
card title items =
    Layout.section "space-y-3"
        (Kit.title Value.medium [ Kit.onSurface ] [ Kit.text title ] :: items)


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Cheat sheet · elm-m3e"
    , body =
        [ HtmlIr.Element.toNode
            (Doc.pane
                [ Layout.div "space-y-10"
                    [ Layout.section "space-y-4"
                        [ Doc.pageHeading "Cheat sheet"
                        , Layout.div "max-w-2xl text-on-surface-variant" [ Doc.markdown intro ]
                        , Doc.userlandNote
                        ]
                    , card "The the layers" [ Doc.markdown layers ]
                    , card "Barrel vs component module" [ Doc.markdown barrelVsSpecific, Doc.code_ Doc.Elm barrelVsSpecificCode ]
                    , card "The three forms" [ Doc.markdown shapes, Doc.code_ Doc.Elm shapesCode ]
                    , card "The strictness dial" [ Doc.markdown dial ]
                    , card "Where a seam may live" [ Doc.markdown seams ]
                    ]
                ]
            )
        ]
    }


intro : String
intro =
    """Look-up tables for the ideas the [Guide](/guide) teaches. Come back here; keep the chapters for the story."""


layers : String
layers =
    """From [the layer map](/guide/the-layers). You live on the top layer; descend, by name, only to escape.

| Layer | What it is | You reach for it |
| --- | --- | --- |
| **the top** | Typed, slot-safe, composes into other components. | Almost always — the default. |
| **typed attributes, raw children** | Attributes still checked; children are plain; returns raw HTML. | You're already outside the typed tree and want typed attrs. |
| **raw elm/html** | Bare tags and attributes; no checking. This is where the strings live. | A bare tag with zero ceremony — through a seam. |
| **the raw layer** | Opaque HTML. | Never directly; it's what the layers above stand on. |"""


barrelVsSpecific : String
barrelVsSpecific =
    """A third axis, orthogonal to the layers and the forms: *which import you reach through*. Same output either way; the [reference](/reference) documents both.

| Import | Statement | You get |
| --- | --- | --- |
| **barrel** | `import M3e` | One import for everything; the generic `variant*` / `slot*` / `attr*` vocabulary. The form the [Guide](/guide/the-layers) teaches. |
| **component module** | `import M3e.Button` | Component-scoped types — a token or slot child wrong for *this* component won't compile. |"""


barrelVsSpecificCode : String
barrelVsSpecificCode =
    """-- barrel — one import, generic vocabulary
M3e.button [ M3e.variantFilled ] [ M3e.slotIcon (M3e.icon [ M3e.attrName "save" ] []), Kit.text "Save" ]

-- component module — component-scoped, tighter types
M3e.Button.view [ M3e.Button.variant M3e.Values.filled ] [ Kit.text "Save" ]"""


shapes : String
shapes =
    """From [the strictness dial](/guide/strictness). All three render the *same* component; they differ only in what you may leave out. **Peers, not a ranking.**"""


shapesCode : String
shapesCode =
    """-- the standard form — everything optional; the tersest
M3e.button [ M3e.variantFilled ] [ Kit.text "Save" ]

-- required record — the compiler demands the parts it can't do without
M3e.Record.Button.view { content = …, action = … } [] []

-- pipeline — a one-only setter is unwritable twice; order-free
-- import M3e.Build.Button as Button
Button.button { content = …, action = … } |> Button.build"""


dial : String
dial =
    """The compiler always checks that kinds line up and only real tokens exist. Everything softer is opt-in, two ways — turn on either, or both:

| You add | How | Caught |
| --- | --- | --- |
| Invalid token for *this* component · empty required slot · foreign slot child · missing accessible name | run the **linter** in CI | project-wide |
| Required parts can't be forgotten | the **required-record** form | per call site |
| A one-only setter can't be written twice | the **pipeline** form | per call site |"""


seams : String
seams =
    """From [your own seam](/guide/seams). A seam — a crossing to raw HTML — is only allowed in a few blessed userland modules, so every escape is in a known, greppable place:

| Module | What it holds |
| --- | --- |
| **Layout** | Layout wrappers over raw HTML (rows, grids, spacing). |
| **Kit** | Your design-system vocabulary (typography, color roles, `text`). |
| **Native** | Typed native HTML elements (`input`, `label`, `select`, …). |
| **Doc / Shared** | App shell and doc-rendering crossings. |

Anywhere else, a raw escape is flagged — and the linter offers to lift it into one of these for you."""
