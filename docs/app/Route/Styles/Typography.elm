module Route.Styles.Typography exposing (ActionData, Data, Model, Msg, route)

import BackendTask
import Head
import Head.Seo as Seo
import Kit
import Layout
import M3e.Card as Card
import M3e.ContentPane as ContentPane
import M3e.Divider as Divider
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
        , image = { url = [ "favicon.ico" ] |> UrlPath.join |> Pages.Url.fromPath, alt = "elm-m3e", dimensions = Nothing, mimeType = Nothing }
        , description = "The M3 type scale, rendered live."
        , locale = Nothing
        , title = "Typography · elm-m3e"
        }
        |> Seo.website


{-| The 15 M3 type-scale roles, each as a live exhibit built from the matching
`Kit` typography primitive plus the Tailwind class it maps to (shown as the caption).
The demo dogfoods the primitives: the exhibit _is_ `Kit.display`/`headline`/… .
-}
scale : List ( Element { s | html : Supported } msg, String )
scale =
    [ ( Kit.display Value.large [ Kit.onSurface ] [ Kit.text "Display Large" ], "text-display-lg" )
    , ( Kit.display Value.medium [ Kit.onSurface ] [ Kit.text "Display Medium" ], "text-display-md" )
    , ( Kit.display Value.small [ Kit.onSurface ] [ Kit.text "Display Small" ], "text-display-sm" )
    , ( Kit.headline Value.large [ Kit.onSurface ] [ Kit.text "Headline Large" ], "text-headline-lg" )
    , ( Kit.headline Value.medium [ Kit.onSurface ] [ Kit.text "Headline Medium" ], "text-headline-md" )
    , ( Kit.headline Value.small [ Kit.onSurface ] [ Kit.text "Headline Small" ], "text-headline-sm" )
    , ( Kit.title Value.large [ Kit.onSurface ] [ Kit.text "Title Large" ], "text-title-lg" )
    , ( Kit.title Value.medium [ Kit.onSurface ] [ Kit.text "Title Medium" ], "text-title-md" )
    , ( Kit.title Value.small [ Kit.onSurface ] [ Kit.text "Title Small" ], "text-title-sm" )
    , ( Kit.body Value.large [ Kit.onSurface ] [ Kit.text "Body Large" ], "text-body-lg" )
    , ( Kit.body Value.medium [ Kit.onSurface ] [ Kit.text "Body Medium" ], "text-body-md" )
    , ( Kit.body Value.small [ Kit.onSurface ] [ Kit.text "Body Small" ], "text-body-sm" )
    , ( Kit.label Value.large [ Kit.onSurface ] [ Kit.text "Label Large" ], "text-label-lg" )
    , ( Kit.label Value.medium [ Kit.onSurface ] [ Kit.text "Label Medium" ], "text-label-md" )
    , ( Kit.label Value.small [ Kit.onSurface ] [ Kit.text "Label Small" ], "text-label-sm" )
    ]


row : ( Element { s | html : Supported } msg, String ) -> Element { s | html : Supported } msg
row ( exhibit, cls ) =
    Layout.div "flex flex-wrap items-baseline justify-between gap-2 py-3"
        [ exhibit
        , Kit.code Value.medium [ Kit.onSurfaceVariant ] [ Kit.text cls ]
        ]


pageHeading : Element { s | heading : Supported } msg
pageHeading =
    Heading.view { content = Kit.text "Typography" }
        [ Heading.variant Value.display, Heading.size Value.small, Heading.level 1 ]
        []


sectionHeading : String -> Element { s | heading : Supported } msg
sectionHeading label =
    Heading.view { content = Kit.text label }
        [ Heading.variant Value.headline, Heading.size Value.small, Heading.level 2 ]
        []


pane : List (Element { s | html : Supported } msg) -> Element { r | contentPane : Supported } msg
pane items =
    ContentPane.view [] (List.map ContentPane.child items)


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Typography · elm-m3e"
    , body =
        [ Element.toNode
            (pane
                [ Layout.section "space-y-3"
                    [ pageHeading
                    , Layout.div "max-w-2xl"
                        [ Kit.paragraph Value.large
                            [ Kit.onSurfaceVariant ]
                            [ Kit.text "The M3 type scale has 15 standard roles (display, headline, title, body, label — each large/medium/small), each encoding font-size, line-height, weight, and tracking via --md-sys-typescale-* tokens. The bridge maps every role to a Tailwind utility." ]
                        ]
                    ]
                , Layout.section "space-y-3"
                    [ sectionHeading "The scale, live"
                    , Card.view
                        [ Card.variant Value.outlined ]
                        [ Card.content
                            (Layout.div "flex flex-col px-2"
                                (List.intersperse (Divider.view [] []) (List.map row scale))
                            )
                        ]
                    ]
                ]
            )
        ]
    }
