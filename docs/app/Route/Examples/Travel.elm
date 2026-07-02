module Route.Examples.Travel exposing (ActionData, Data, Model, Msg, route)

{-| **Crane** study — an expressive Material 3 travel browser, re-authored on the new
Vocab API (opus, Settings-style; the 9B/14B ornith couldn't converge on the original
937-line version). Real components in the reference's content-pane + card pattern: a
"find a trip" `Card` with a `SegmentedButton` trip-type toggle and a search `Button`; a
`SegmentedButton` category switch (Fly / Sleep / Eat) driving a grid of destination
`Card`s. Local state drives the toggles; custom layout is only a Tailwind grid.
-}

import BackendTask
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
import M3e.Icon as Icon
import M3e.SegmentedButton as SegmentedButton
import M3e.Value as Value exposing (Supported)
import Native
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatefulRoute)
import Seam
import Shared
import UrlPath exposing (UrlPath)
import View exposing (View)


type alias Model =
    { category : String
    , tripType : String
    }


type Msg
    = SetCategory String
    | SetTripType String


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
    ( { category = "fly", tripType = "round" }, Effect.none )


update : App Data ActionData RouteParams -> Shared.Model -> Msg -> Model -> ( Model, Effect Msg )
update _ _ msg model =
    case msg of
        SetCategory c ->
            ( { model | category = c }, Effect.none )

        SetTripType t ->
            ( { model | tripType = t }, Effect.none )


subscriptions : RouteParams -> UrlPath -> Shared.Model -> Model -> Sub Msg
subscriptions _ _ _ _ =
    Sub.none


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    []


{-| (place, blurb) per category.
-}
destinations : String -> List ( String, String )
destinations category =
    case category of
        "sleep" ->
            [ ( "Kyoto", "Ryokan stays beneath the temples" )
            , ( "Reykjavík", "Glass cabins under the aurora" )
            , ( "Santorini", "Cliffside caldera suites" )
            ]

        "eat" ->
            [ ( "Oaxaca", "Mole, mezcal, and market stalls" )
            , ( "Bologna", "The pasta capital of Emilia" )
            , ( "Osaka", "Street food along Dōtonbori" )
            ]

        _ ->
            [ ( "Lisbon", "Tram rides and pastéis de nata" )
            , ( "Marrakesh", "Souks, riads, and desert light" )
            , ( "Queenstown", "Alpine lakes and adventure" )
            ]


view : App Data ActionData RouteParams -> Shared.Model -> Model -> View (PagesMsg Msg)
view _ _ model =
    { title = "Crane · elm-m3e"
    , body =
        [ Element.toNode
            (pane
                [ Heading.view { content = Kit.text "Crane" }
                    [ Heading.variant Value.display, Heading.size Value.small, Heading.level "1" ]
                    []
                , card "Find a trip"
                    (Native.div [ Seam.asAttribute (Attr.class "flex flex-col gap-4") ]
                        [ segmented
                            [ ( "round", "Round trip" ), ( "oneway", "One way" ) ]
                            model.tripType
                            SetTripType
                        , Button.view
                            [ Button.variant Value.filled ]
                            [ Button.child (Kit.text "Search flights") ]
                        ]
                    )
                , segmented
                    [ ( "fly", "Fly" ), ( "sleep", "Sleep" ), ( "eat", "Eat" ) ]
                    model.category
                    SetCategory
                , Native.div
                    [ Seam.asAttribute (Attr.class "grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3") ]
                    (List.map destinationCard (destinations model.category))
                ]
            )
        ]
    }


pane : List (Element { s | html : Supported } msg) -> Element { r | contentPane : Supported } msg
pane items =
    ContentPane.view [] (List.map ContentPane.child items)


{-| A titled outlined card wrapping arbitrary content.
-}
card : String -> Element { s | html : Supported } msg -> Element { r | card : Supported } msg
card title content =
    Card.view [ Card.variant Value.outlined ]
        [ Card.header (Heading.view { content = Kit.text title } [ Heading.variant Value.title ] [])
        , Card.content content
        ]


{-| A destination card: a place heading + a one-line blurb.
-}
destinationCard : ( String, String ) -> Element { s | card : Supported } msg
destinationCard ( place, blurb ) =
    Card.view [ Card.variant Value.elevated ]
        [ Card.header
            (Native.div [ Seam.asAttribute (Attr.class "flex items-center gap-2") ]
                [ Icon.view [ Icon.name "place" ] [], Kit.text place ]
            )
        , Card.content (Kit.text blurb)
        ]


{-| A segmented control bound to a String choice.
-}
segmented : List ( String, String ) -> String -> (String -> Msg) -> Element { s | segmentedButton : Supported } (PagesMsg Msg)
segmented options current set =
    SegmentedButton.view []
        (List.map
            (\( v, l ) ->
                SegmentedButton.child
                    (ButtonSegment.view
                        [ ButtonSegment.checked (v == current)
                        , ButtonSegment.onClick (PagesMsg.fromMsg (set v))
                        ]
                        [ ButtonSegment.child (Kit.text l) ]
                    )
            )
            options
        )
