module Route.Studies.Reply exposing (ActionData, Data, Model, Msg, route)

{-| **Reply** study — a Material 3 email inbox, re-authored on the new Vocab API (opus,
Settings-style). Real components in the content-pane + card pattern: a compose `Button`
and an inbox `List` whose `ListItem` rows carry a leading `Icon`, sender, subject
(supporting text), and a trailing timestamp. Static list; no custom layout.
-}

import BackendTask exposing (BackendTask)
import Effect exposing (Effect)
import Head
import Html.Attributes as Attr
import Kit
import M3e.Button as Button
import M3e.Card as Card
import M3e.ContentPane as ContentPane
import M3e.Element as Element exposing (Element)
import M3e.Heading as Heading
import M3e.Icon as Icon
import M3e.List as List_
import M3e.ListItem as ListItem
import M3e.Value as Value exposing (Supported)
import Native
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatefulRoute)
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


subscriptions : RouteParams -> UrlPath.UrlPath -> Shared.Model -> Model -> Sub Msg
subscriptions _ _ _ _ =
    Sub.none


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    []


type alias Mail =
    { icon : String, sender : String, subject : String, time : String }


inbox : List Mail
inbox =
    [ { icon = "person", sender = "Ali Connors", subject = "Weekend hiking plans — trail options", time = "9:32 AM" }
    , { icon = "group", sender = "Design team", subject = "M3 Expressive review notes", time = "8:15 AM" }
    , { icon = "receipt_long", sender = "Ferry Ticketing", subject = "Your booking is confirmed", time = "Yesterday" }
    , { icon = "campaign", sender = "Product updates", subject = "What's new in @m3e/web 2.5", time = "Mon" }
    , { icon = "person", sender = "Trevor Hansen", subject = "Re: Rally dashboard mockups", time = "Sun" }
    ]


view : App Data ActionData RouteParams -> Shared.Model -> Model -> View (PagesMsg Msg)
view _ _ _ =
    { title = "Reply · elm-m3e"
    , body =
        List.map Element.toNode
            [ pane
                [ Native.div
                    [ Seam.asAttribute (Attr.class "flex items-center justify-between") ]
                    [ Heading.view { content = Kit.text "Inbox" }
                        [ Heading.variant Value.display, Heading.size Value.small, Heading.level "1" ]
                        []
                    , Button.view [ Button.variant Value.filled ] [ Button.child (Kit.text "Compose") ]
                    ]
                , Card.view [ Card.variant Value.outlined ]
                    [ Card.content (List_.view [] (List_.children (List.map mailRow inbox))) ]
                ]
            ]
    }


pane : List (Element { s | html : Supported } msg) -> Element { r | contentPane : Supported } msg
pane items =
    ContentPane.view [] (List.map ContentPane.child items)


{-| An inbox row: leading icon, sender, subject (supporting), trailing time.
-}
mailRow : Mail -> Element { s | listItem : Supported } msg
mailRow m =
    ListItem.view []
        [ ListItem.leading (Icon.view [ Icon.name m.icon ] [])
        , ListItem.child (Kit.text m.sender)
        , ListItem.supportingText (Kit.text m.subject)
        , ListItem.trailing (Kit.text m.time)
        ]
