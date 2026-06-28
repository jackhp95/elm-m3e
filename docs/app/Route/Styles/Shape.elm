module Route.Styles.Shape exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import Cem.M3e.Shape as CemShape
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (p, text)
import Html.Attributes exposing (class, style)
import Layout
import M3e.Card as Card
import M3e.Divider as Divider
import M3e.Element as Element
import M3e.Heading as Heading
import M3e.Node as Node exposing (Node)
import M3e.Shape as Shape
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
        , description = "The M3 shape scale, rendered live with M3e.Shape."
        , locale = Nothing
        , title = "Shape · elm-m3e"
        }
        |> Seo.website


steps : List ( String, String )
steps =
    [ ( "rounded-md-corner-none", "None" )
    , ( "rounded-md-corner-extra-small", "Extra small" )
    , ( "rounded-md-corner-small", "Small" )
    , ( "rounded-md-corner-medium", "Medium" )
    , ( "rounded-md-corner-large", "Large" )
    , ( "rounded-md-corner-extra-large", "Extra large" )
    , ( "rounded-full", "Full" )
    ]


swatch : ( String, String ) -> Node msg
swatch ( cls, label ) =
    Layout.div "flex flex-col items-center gap-2 text-label-sm text-on-surface-variant"
        [ Layout.div ("block w-16 h-16 bg-primary-container " ++ cls) []
        , Node.text label
        ]


pageHeading : Node msg
pageHeading =
    Heading.view { label = "Shape", variant = Value.display }
        [ Heading.size Value.small, Heading.level 1 ]
        |> Element.toNode


m3eShapeSwatch : ( CemShape.Name, String ) -> Node msg
m3eShapeSwatch ( shapeName, label ) =
    Layout.div "flex flex-col items-center gap-2 text-label-sm text-on-surface-variant"
        [ Shape.view
            { content =
                [ Element.fromNode
                    (Layout.div "w-full h-full bg-primary-container" [])
                ]
            }
            [ Shape.name shapeName
            , Shape.attributes [ Node.rawAttr (style "width" "4rem"), Node.rawAttr (style "height" "4rem") ]
            ]
            |> Element.toNode
        , Node.text label
        ]


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Shape · elm-m3e"
    , body =
        [ Layout.container
            [ Layout.section "space-y-3"
                [ pageHeading
                , Node.raw
                    (p [ class "max-w-2xl text-body-lg text-on-surface-variant" ]
                        [ text "Material 3 defines a corner-radius scale from none through full. Each step is a --md-sys-shape-corner-* token, mapped to a rounded-md-corner-* Tailwind utility. M3e.Shape renders a decorative <m3e-shape> surface that respects it." ]
                    )
                ]
            , Divider.view [] |> Element.toNode
            , Card.view
                [ Card.variant Value.outlined
                , Card.headline (Heading.view { label = "M3e.Shape — named shapes", variant = Value.title } [])
                , Card.body
                    [ Element.fromNode
                        (Layout.div "flex flex-wrap items-end gap-6"
                            (List.map m3eShapeSwatch
                                [ ( CemShape.Circle, "Circle" )
                                , ( CemShape.Flower, "Flower" )
                                , ( CemShape.Heart, "Heart" )
                                , ( CemShape.Pill, "Pill" )
                                , ( CemShape.PixelCircle, "Pixel" )
                                ]
                            )
                        )
                    ]
                ]
                |> Element.toNode
            , Divider.view [] |> Element.toNode
            , Card.view
                [ Card.variant Value.outlined
                , Card.headline (Heading.view { label = "Corner scale", variant = Value.title } [])
                , Card.body
                    [ Element.fromNode
                        (Layout.div "flex flex-wrap items-end gap-6"
                            (List.map swatch steps)
                        )
                    ]
                ]
                |> Element.toNode
            ]
        ]
    }
