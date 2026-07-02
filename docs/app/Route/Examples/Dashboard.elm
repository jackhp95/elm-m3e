module Route.Examples.Dashboard exposing (ActionData, Data, Model, Msg, route)

{-| **Rally** study — a Material 3 personal-finance dashboard, re-authored on the new
Vocab API (opus, Settings-style). Real components in the content-pane + card pattern:
a grid of account-summary `Card`s, and a budget `Card` whose `List`/`ListItem` rows each
pair a category + amount with a `Progress.linear` bar showing budget usage. Static
dashboard (no local state); custom layout is only a Tailwind grid.
-}

import BackendTask
import Effect exposing (Effect)
import EscapeHatch
import Head
import Html.Attributes as Attr
import Kit
import M3e.Card as Card
import M3e.ContentPane as ContentPane
import M3e.Element as Element exposing (Element)
import M3e.Heading as Heading
import M3e.Icon as Icon
import M3e.List as List_
import M3e.ListItem as ListItem
import M3e.Progress as Progress
import M3e.Value as Value exposing (Supported)
import Native
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatefulRoute)
import Seam
import Shared
import UrlPath exposing (UrlPath)
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
    ( {}, Effect.none )


update : App Data ActionData RouteParams -> Shared.Model -> Msg -> Model -> ( Model, Effect Msg )
update _ _ _ model =
    ( model, Effect.none )


subscriptions : RouteParams -> UrlPath -> Shared.Model -> Model -> Sub Msg
subscriptions _ _ _ _ =
    Sub.none


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    []


accounts : List ( String, String, String )
accounts =
    [ ( "account_balance", "Checking", "$2,340.18" )
    , ( "savings", "Savings", "$12,890.55" )
    , ( "credit_card", "Credit", "-$1,204.32" )
    ]


budgets : List ( String, String, Float )
budgets =
    [ ( "Dining", "$320 / $400", 0.8 )
    , ( "Groceries", "$210 / $500", 0.42 )
    , ( "Transport", "$95 / $150", 0.63 )
    , ( "Shopping", "$480 / $450", 1.0 )
    ]


view : App Data ActionData RouteParams -> Shared.Model -> Model -> View (PagesMsg Msg)
view _ _ _ =
    { title = "Rally · elm-m3e"
    , body =
        [ Element.toNode
            (pane
                [ Heading.view { content = Kit.text "Rally" }
                    [ Heading.variant Value.display, Heading.size Value.small, Heading.level "1" ]
                    []
                , Native.div
                    [ Seam.asAttribute (Attr.class "grid grid-cols-1 gap-4 sm:grid-cols-3") ]
                    (List.map accountCard accounts)
                , card "Budgets"
                    (List_.view [] (List_.children (List.map budgetRow budgets)))
                ]
            )
        ]
    }


pane : List (Element { s | html : Supported } msg) -> Element { r | contentPane : Supported } msg
pane items =
    ContentPane.view [] (List.map ContentPane.child items)


card : String -> Element { s | html : Supported } msg -> Element { r | card : Supported } msg
card title content =
    Card.view [ Card.variant Value.outlined ]
        [ Card.header (Heading.view { content = Kit.text title } [ Heading.variant Value.title ] [])
        , Card.content content
        ]


{-| An account summary: icon + name + balance.
-}
accountCard : ( String, String, String ) -> Element { s | card : Supported } msg
accountCard ( icon, name, balance ) =
    Card.view [ Card.variant Value.elevated ]
        [ Card.header
            (Native.div [ Seam.asAttribute (Attr.class "flex items-center gap-2") ]
                [ Icon.view [ Icon.name icon ] [], Kit.text name ]
            )
        , Card.content
            (Kit.headline Value.small [] [ Kit.text balance ])
        ]


{-| A budget row: category, amount, and a linear progress bar of usage.
-}
budgetRow : ( String, String, Float ) -> Element { s | listItem : Supported } msg
budgetRow ( category, amount, used ) =
    ListItem.view []
        [ ListItem.child (Kit.text category)
        , ListItem.supportingText (Kit.text amount)
        , ListItem.trailing
            (EscapeHatch.asElement
                (Native.div [ Seam.asAttribute (Attr.class "w-32") ]
                    [ Progress.linear [ Progress.value used, Progress.max 1 ] [] ]
                )
            )
        ]
