module Route.Guide.FirstComponent exposing (ActionData, Data, Model, Msg, route)

{-| Guide (`/guide/first-component`): the happy path — import a
component and put it on screen. Starts the running "Account settings" example
with a card, a title, and a Save button, genuinely constructed and shown beside
their exact source. Written in the one-import barrel, options-list form
(`M3e.<name> [ attributes ] [ children ]`).
-}

import BackendTask
import Doc
import Head
import Head.Seo as Seo
import Kit
import Layout
import M3e
import M3e.Element as Element exposing (Element)
import M3e.Token exposing (Supported)
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
        , description = "Import a component and put it on screen — the start of the running settings example in the elm-m3e Guide."
        , locale = Nothing
        , title = "Your first component · elm-m3e"
        }
        |> Seo.website


{-| The running example, step 1: an Account settings card with a title and a
Save button, in the one-import barrel, options-list form. Genuinely constructed —
this is the value rendered on the page and printed in the source block below, so
the two can never drift.
-}
settingsCard : Element { s | card : Supported } msg
settingsCard =
    M3e.card [ M3e.variantOutlined ]
        [ M3e.slotHeader
            (M3e.heading [ M3e.variantTitle, M3e.attrLevel 2 ] [ Kit.text "Account settings" ])
        , M3e.slotContent
            (M3e.button [ M3e.variantFilled ] [ Kit.text "Save" ])
        ]


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Your first component · elm-m3e"
    , body =
        [ Element.toNode
            (Doc.pane
                [ Layout.div "space-y-12"
                    [ Layout.section "space-y-4"
                        [ Doc.pageHeading "Your first component"
                        , Layout.div "max-w-2xl text-on-surface-variant" [ Doc.markdown intro ]
                        ]
                    , Layout.section "space-y-4"
                        [ Doc.markdown body
                        , settingsCard
                        , Doc.code_ Doc.Elm source
                        , Doc.userlandNote
                        ]
                    , Doc.recapBox recap
                    ]
                ]
            )
        ]
    }


intro : String
intro =
    """This guide builds one real thing — an account settings panel — a small step at a time, and every step teaches the idea behind it. Start here: get a single component on screen. Everything after this builds on it."""


body : String
body =
    """Every component is a typed Elm value. Import the one-import `M3e` barrel, build a value in the shape `M3e.<name> [ attributes ] [ children ]`, and hand it to `Element.toNode` at your app's root. Here is the start of our panel: an outlined card, a title, and a **Save** button.

Look at the shape. Attributes like `M3e.variantFilled` go in the first list; content goes in the second. That is the whole API — one import, one shape, every component.

(One deliberate choice: the Guide writes the generic setters — `M3e.slotHeader`, not `M3e.cardSlotHeader` — because in [the tooling chapter](/guide/tooling-refactors) you'll watch the linter upgrade exactly this code to the component-precise form, for you.)"""


source : String
source =
    """import Kit
import M3e


settingsCard =
    M3e.card [ M3e.variantOutlined ]
        [ M3e.slotHeader
            (M3e.heading [ M3e.variantTitle, M3e.attrLevel 2 ] [ Kit.text "Account settings" ])
        , M3e.slotContent
            (M3e.button [ M3e.variantFilled ] [ Kit.text "Save" ])
        ]"""


recap : String
recap =
    """- Every component is `M3e.<name> [ attributes ] [ children ]`, from the one-import `M3e` barrel.
- `Element.toNode` renders your composed value at your app's root.
- **Next: [Invalid states don't compile](/guide/invalid-states) →** we compose the *wrong* thing on purpose — and watch the compiler refuse it."""
