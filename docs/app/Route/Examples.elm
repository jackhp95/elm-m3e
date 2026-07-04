module Route.Examples exposing (ActionData, Data, Model, Msg, route)

{-| Landing page for the Examples area — composed, real-world app screens showing
many `M3e.*` components working together. The five examples are responsive routes
that the sidebar links to; this page is the gallery.
-}

import BackendTask
import Head
import Head.Seo as Seo
import Kit
import Layout
import M3e.Action as Action
import M3e.Card as Card
import M3e.ContentPane as ContentPane
import M3e.Element as Element exposing (Element)
import M3e.Record.Button as Button
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
    ]


pageHeading : Element { s | heading : Supported } msg
pageHeading =
    Heading.view { content = Kit.text "Examples" }
        [ Heading.variant Value.display, Heading.size Value.small, Heading.level "1" ]
        []


exampleCard : ( String, String, String ) -> Element { s | card : Supported } msg
exampleCard ( slug, title, body ) =
    let
        exampleHref : String
        exampleHref =
            "/examples/" ++ slug
    in
    Card.view
        [ Card.variant Value.elevated ]
        [ Card.header (Heading.view { content = Kit.text title } [ Heading.variant Value.title ] [])
        , Card.content (Kit.paragraph Value.large [ Kit.onSurfaceVariant ] [ Kit.text body ])
        , Card.actions
            (Button.view
                { content = Kit.text ("Open " ++ title)
                , action =
                    Action.linkWith
                        { href = exampleHref
                        , target = Just "_blank"
                        , rel = Just "noreferrer noopener"
                        , download = Nothing
                        }
                }
                [ Button.variant Value.filled ]
                []
            )
        ]


pane : List (Element { s | html : Supported } msg) -> Element { r | contentPane : Supported } msg
pane items =
    ContentPane.view [] (List.map ContentPane.child items)


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Examples · elm-m3e"
    , body =
        [ Element.toNode
            (pane
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
