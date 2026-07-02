module Route.Studies.Shrine exposing (ActionData, Data, Model, Msg, route)

{-| **Shrine** study — a Material 3 e-commerce boutique, re-authored on the new Vocab
API (opus, Settings-style). Real components in the content-pane + card pattern: a
`SegmentedButton` category filter driving a grid of product `Card`s, each with a name
header, price content, and an "Add" `Button` in the actions slot. Interactive local
state (the selected category); custom layout is only a Tailwind grid.
-}

import BackendTask exposing (BackendTask)
import Effect exposing (Effect)
import Head
import Html.Attributes as Attr
import Kit
import M3e.Button as Button
import M3e.ButtonSegment as ButtonSegment
import M3e.Card as Card
import M3e.ContentPane as ContentPane
import M3e.Element as Element exposing (Element)
import M3e.Heading as Heading
import M3e.SegmentedButton as SegmentedButton
import M3e.Value as Value exposing (Supported)
import Native
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatefulRoute)
import Seam
import Shared
import UrlPath
import View exposing (View)


type alias Model =
    { category : String }


type Msg
    = SetCategory String


type alias RouteParams =
    {}


type alias Data =
    {}


type alias ActionData =
    {}


route : StatefulRoute RouteParams Data ActionData Model Msg
route =
    RouteBuilder.single { head = head, data = BackendTask.succeed {} }
        |> RouteBuilder.buildWithLocalState
            { view = view
            , init = init
            , update = update
            , subscriptions = subscriptions
            }


init : App Data ActionData RouteParams -> Shared.Model -> ( Model, Effect Msg )
init _ _ =
    ( { category = "all" }, Effect.none )


update : App Data ActionData RouteParams -> Shared.Model -> Msg -> Model -> ( Model, Effect Msg )
update _ _ (SetCategory c) model =
    ( { model | category = c }, Effect.none )


subscriptions : RouteParams -> UrlPath.UrlPath -> Shared.Model -> Model -> Sub Msg
subscriptions _ _ _ _ =
    Sub.none


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    []


type alias Product =
    { name : String, price : String, category : String }


products : List Product
products =
    [ { name = "Vagabond sack", price = "$120", category = "accessories" }
    , { name = "Stella sunglasses", price = "$58", category = "accessories" }
    , { name = "Whitney belt", price = "$35", category = "accessories" }
    , { name = "Gilt desk trio", price = "$58", category = "home" }
    , { name = "Copper wire rack", price = "$44", category = "home" }
    , { name = "Chambray shirt", price = "$70", category = "clothing" }
    , { name = "Seabreeze sweater", price = "$95", category = "clothing" }
    , { name = "Gatsby hat", price = "$40", category = "clothing" }
    ]


view : App Data ActionData RouteParams -> Shared.Model -> Model -> View (PagesMsg Msg)
view _ _ model =
    let
        shown =
            if model.category == "all" then
                products

            else
                List.filter (\p -> p.category == model.category) products
    in
    { title = "Shrine · elm-m3e"
    , body =
        List.map Element.toNode
            [ pane
                [ Heading.view { content = Kit.text "Shrine" }
                    [ Heading.variant Value.display, Heading.size Value.small, Heading.level "1" ]
                    []
                , segmented
                    [ ( "all", "All" ), ( "clothing", "Clothing" ), ( "accessories", "Accessories" ), ( "home", "Home" ) ]
                    model.category
                , Native.div
                    [ Seam.asAttribute (Attr.class "grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-4") ]
                    (List.map productCard shown)
                ]
            ]
    }


pane : List (Element { s | html : Supported } msg) -> Element { r | contentPane : Supported } msg
pane items =
    ContentPane.view [] (List.map ContentPane.child items)


{-| A product card: name header, price, and an Add-to-cart action.
-}
productCard : Product -> Element { s | card : Supported } (PagesMsg Msg)
productCard product =
    Card.view [ Card.variant Value.elevated ]
        [ Card.header (Heading.view { content = Kit.text product.name } [ Heading.variant Value.title ] [])
        , Card.content (Kit.text product.price)
        , Card.actions (Button.view [ Button.variant Value.text ] [ Button.child (Kit.text "Add to cart") ])
        ]


{-| The category filter.
-}
segmented : List ( String, String ) -> String -> Element { s | segmentedButton : Supported } (PagesMsg Msg)
segmented options current =
    SegmentedButton.view []
        (List.map
            (\( v, l ) ->
                SegmentedButton.child
                    (ButtonSegment.view
                        [ ButtonSegment.checked (v == current)
                        , ButtonSegment.onClick (PagesMsg.fromMsg (SetCategory v))
                        ]
                        [ ButtonSegment.child (Kit.text l) ]
                    )
            )
            options
        )
