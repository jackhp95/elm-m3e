module Route.Styles.Density exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (p, text)
import Html.Attributes exposing (class, style)
import Layout
import M3e.Button as Button
import M3e.Card as Card
import M3e.Divider as Divider
import M3e.Element as Element
import M3e.Heading as Heading
import M3e.Node as Node exposing (Node)
import M3e.Value as Value
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
        , description = "The M3 density axis and how it scales component sizing."
        , locale = Nothing
        , title = "Density · elm-m3e"
        }
        |> Seo.website


demoBar : Int -> Node msg
demoBar scaleValue =
    Layout.div "space-y-2"
        [ Node.raw
            (p [ class "text-label-lg text-on-surface-variant" ]
                [ text ("density scale " ++ String.fromInt scaleValue) ]
            )
        , Node.element "div"
            [ Node.rawAttr (style "--md-sys-density-scale" (String.fromInt scaleValue))
            , Node.rawAttr (class "flex flex-wrap gap-2")
            ]
            (List.range 1 4
                |> List.map
                    (\_ ->
                        Button.view { label = "Action", variant = Value.filled } [] |> Element.toNode
                    )
            )
        ]


pageHeading : Node msg
pageHeading =
    Heading.view { label = "Density", variant = Value.display }
        [ Heading.size Value.small, Heading.level 1 ]
        |> Element.toNode


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Density · elm-m3e"
    , body =
        [ Layout.container
            [ Layout.section "space-y-3"
                [ pageHeading
                , Node.raw
                    (p [ class "max-w-2xl text-body-lg text-on-surface-variant" ]
                        [ text "Density compacts components for information-dense UIs. The --md-sys-density-scale token runs 0 (default, comfortable) through negative values (more compact). Set it globally via the app bar Density control, or scope it to a subtree with an inline style." ]
                    )
                ]
            , Divider.view [] |> Element.toNode
            , Card.view
                [ Card.variant Value.outlined
                , Card.headline (Heading.view { label = "Density scale, 0 to -3", variant = Value.title } [])
                , Card.body
                    [ Element.fromNode
                        (Layout.div "space-y-6"
                            [ demoBar 0
                            , demoBar -1
                            , demoBar -2
                            , demoBar -3
                            ]
                        )
                    ]
                ]
                |> Element.toNode
            ]
        ]
    }
