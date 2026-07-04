module Route.Styles.Density exposing (ActionData, Data, Model, Msg, route)

import BackendTask
import Head
import Head.Seo as Seo
import Html
import Html.Attributes exposing (class, style)
import Kit
import Layout
import M3e.Action as Action
import M3e.Card as Card
import M3e.ContentPane as ContentPane
import M3e.Element as Element exposing (Element)
import M3e.Record.Button as Button
import M3e.Record.Heading as Heading
import M3e.Value as Value exposing (Supported)
import Native
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatelessRoute)
import Seam
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
        , description = "The M3 density axis and how it scales component sizing."
        , locale = Nothing
        , title = "Density · elm-m3e"
        }
        |> Seo.website


demoBar : Int -> Element { s | html : Supported } msg
demoBar scaleValue =
    Layout.div "space-y-2"
        [ Kit.label Value.large
            [ Kit.onSurfaceVariant ]
            [ Kit.text ("density scale " ++ String.fromInt scaleValue) ]
        , Native.node (Html.node "div")
            [ Seam.asAttribute (style "--md-sys-density-scale" (String.fromInt scaleValue))
            , Seam.asAttribute (class "flex flex-wrap gap-2")
            ]
            (List.range 1 4
                |> List.map
                    (\_ ->
                        Button.view { content = Kit.text "Action", action = Action.none } [ Button.variant Value.filled ] []
                    )
            )
        ]


pageHeading : Element { s | heading : Supported } msg
pageHeading =
    Heading.view { content = Kit.text "Density" }
        [ Heading.variant Value.display, Heading.size Value.small, Heading.level "1" ]
        []


pane : List (Element { s | html : Supported } msg) -> Element { r | contentPane : Supported } msg
pane items =
    ContentPane.view [] (List.map ContentPane.child items)


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Density · elm-m3e"
    , body =
        [ Element.toNode
            (pane
                [ Layout.section "space-y-3"
                    [ pageHeading
                    , Layout.div "max-w-2xl"
                        [ Kit.paragraph Value.large
                            [ Kit.onSurfaceVariant ]
                            [ Kit.text "Density compacts components for information-dense UIs. The --md-sys-density-scale token runs 0 (default, comfortable) through negative values (more compact). Set it globally via the app bar Density control, or scope it to a subtree with an inline style." ]
                        ]
                    ]
                , Card.view
                    [ Card.variant Value.outlined ]
                    [ Card.header (Heading.view { content = Kit.text "Density scale, 0 to -3" } [ Heading.variant Value.title ] [])
                    , Card.content
                        (Layout.div "space-y-6"
                            [ demoBar 0
                            , demoBar -1
                            , demoBar -2
                            , demoBar -3
                            ]
                        )
                    ]
                ]
            )
        ]
    }
