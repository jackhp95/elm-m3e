module Route.Styles.Shape exposing (ActionData, Data, Model, Msg, route)

{-| **Shape** — the M3 Expressive named-shape scale, re-authored on the new Vocab API
(opus). Renders a grid of real `M3e.Shape` surfaces (each clipping a filled tile to a
named shape via `Shape.name` Value tokens), in the content-pane + card pattern. Replaces
the old `Cem.M3e.Shape`/`Shape.attributes` passthrough with the token-driven API.
-}

import BackendTask
import Head
import Kit
import Layout
import M3e.Card as Card
import M3e.ContentPane as ContentPane
import M3e.Element as Element exposing (Element)
import M3e.Record.Heading as Heading
import M3e.Shape as Shape
import M3e.Value as Value exposing (Supported)
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatelessRoute)
import Shared
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
    []


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Shape · elm-m3e"
    , body =
        [ Element.toNode
            (pane
                [ Heading.view { content = Kit.text "Shape" }
                    [ Heading.variant Value.display, Heading.size Value.small, Heading.level 1 ]
                    []
                , Card.view [ Card.variant Value.outlined ]
                    [ Card.content
                        (Layout.div "grid grid-cols-3 gap-6 sm:grid-cols-4 lg:grid-cols-6"
                            (List.map
                                (\( token, label ) ->
                                    Layout.div "flex flex-col items-center gap-2"
                                        [ Shape.view [ Shape.name token ] []
                                        , Kit.text label
                                        ]
                                )
                                [ ( Value.circle, "Circle" )
                                , ( Value.flower, "Flower" )
                                , ( Value.heart, "Heart" )
                                , ( Value.pill, "Pill" )
                                , ( Value.diamond, "Diamond" )
                                , ( Value.gem, "Gem" )
                                , ( Value.sunny, "Sunny" )
                                , ( Value.burst, "Burst" )
                                , ( Value.hexagon, "Hexagon" )
                                , ( Value.triangle, "Triangle" )
                                , ( Value.oval, "Oval" )
                                , ( Value.arch, "Arch" )
                                ]
                            )
                        )
                    ]
                ]
            )
        ]
    }


pane : List (Element { s | html : Supported } msg) -> Element { r | contentPane : Supported } msg
pane items =
    ContentPane.view [] items
