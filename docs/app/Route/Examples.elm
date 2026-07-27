module Route.Examples exposing (ActionData, Data, Model, Msg, route)

{-| Landing page for the Examples area — composed, real-world app screens showing
many `M3e.*` components working together. The five examples are responsive routes
that the sidebar links to; this page is the gallery.
-}

import BackendTask
import Doc
import Head
import Head.Seo as Seo
import HtmlIr.Element as Element exposing (Element)
import Kit
import Layout
import M3e
import M3e.Attributes
import M3e.Button
import M3e.Card
import M3e.Heading
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
        , image = { url = [ "favicon.ico" ] |> UrlPath.join |> Pages.Url.fromPath, alt = "elm-m3e", dimensions = Nothing, mimeType = Nothing }
        , description = "Composed, real-world app screens built with elm-m3e."
        , locale = Nothing
        , title = "Examples · elm-m3e"
        }
        |> Seo.website


examples : List ( String, String, String )
examples =
    [ ( "dashboard", "Dashboard", "An analytics dashboard — adaptive navigation, KPI stat cards with trend deltas, budget meters via progress indicators, and a recent-activity data table." )
    , ( "shop", "Shop", "An e-commerce storefront — filter chips, a responsive product-card grid with shape-clipped media, a cart badge in the app bar, and quick actions." )
    , ( "mail", "Mail", "An email client — adaptive navigation, a message list beside a reading pane that stacks on mobile, labels as chips, and a compose FAB." )
    , ( "travel", "Travel", "A trip-planning app — a search hero, horizontally scrolling destination rails, category tabs, and richly-composed destination cards." )
    , ( "settings", "Settings", "A system settings surface — sectioned preference groups built from list items, switches, radios, sliders, and dividers." )
    , ( "list-detail", "List-detail", "The canonical adaptive list-detail pattern — a contacts list beside a detail pane on desktop that reflows to a single column on mobile, with nav-rail↔nav-bar switching." )
    , ( "supporting-pane", "Supporting pane", "The adaptive supporting-pane pattern — a wide primary region with a narrower supporting pane that sits beside it on expanded windows and reflows beneath on compact." )
    , ( "feed", "Feed", "The adaptive feed pattern — a responsive card grid whose column count grows with the window size class, driven by a filter-chip toolbar." )
    ]


pageHeading : Element { s | heading : M3e.Kind.Brand } admittedBy msg
pageHeading =
    M3e.heading
        [ M3e.Heading.variant Value.display
        , M3e.Heading.size Value.small
        , M3e.Attributes.level 1
        ]
        [ M3e.text "Examples" ]


exampleCard : ( String, String, String ) -> Element { s | card : M3e.Kind.Brand } admittedBy msg
exampleCard ( slug, cardTitle, cardBody ) =
    let
        exampleHref : String
        exampleHref =
            "/examples/" ++ slug
    in
    M3e.card
        [ M3e.Card.variant Value.elevated ]
        [ M3e.Card.header (M3e.heading [ M3e.Heading.variant Value.title ] [ M3e.text cardTitle ])
        , M3e.Card.content (Kit.paragraph Value.large [ Kit.onSurfaceVariant ] [ Kit.text cardBody ])
        , M3e.Card.actions
            (M3e.button
                [ M3e.Button.variant Value.filled, M3e.Button.href exampleHref ]
                [ Kit.text ("Open " ++ cardTitle) ]
            )
        ]


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Examples · elm-m3e"
    , body =
        [ Element.toNode
            (Doc.pane
                [ Layout.section "space-y-3"
                    [ pageHeading
                    , Layout.div "max-w-2xl"
                        [ Kit.paragraph Value.large
                            [ Kit.onSurfaceVariant ]
                            [ Kit.text "Examples are composed, real-world app screens that show many elm-m3e components working together — the way the library is meant to be used. Each one is a real, responsive route, not a screenshot." ]
                        ]
                    ]
                , Layout.section "grid gap-4 sm:grid-cols-2"
                    (List.map exampleCard examples)
                ]
            )
        ]
    }
