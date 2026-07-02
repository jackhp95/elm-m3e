module Route.Studies.Settings exposing (ActionData, Data, Model, Msg, route)

{-| **Settings** study — a Material 3 settings surface, re-authored on the new Vocab
API. It composes real m3e components in the reference's content-pane + card pattern:
sections are `M3e.Card`s, rows are `M3e.List`/`ListItem` with a leading `Icon`,
supporting text, and a trailing interactive `Switch`; appearance uses a
`SegmentedButton`. Custom layout is avoided — the components carry the structure.
-}

import BackendTask
import Effect exposing (Effect)
import EscapeHatch
import Head
import Kit
import M3e.Aria as Aria
import M3e.ButtonSegment as ButtonSegment
import M3e.Card as Card
import M3e.ContentPane as ContentPane
import M3e.Element as Element exposing (Element)
import M3e.Heading as Heading
import M3e.Icon as Icon
import M3e.List as List_
import M3e.ListItem as ListItem
import M3e.SegmentedButton as SegmentedButton
import M3e.Switch as Switch
import M3e.Value as Value exposing (Supported)
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatefulRoute)
import Shared
import UrlPath exposing (UrlPath)
import View exposing (View)


type alias Model =
    { push : Bool
    , email : Bool
    , sms : Bool
    , analytics : Bool
    , crashReports : Bool
    , theme : String
    }


type Toggle
    = Push
    | Email
    | Sms
    | Analytics
    | CrashReports


type Msg
    = Flip Toggle
    | SetTheme String


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
    ( { push = True
      , email = True
      , sms = False
      , analytics = False
      , crashReports = True
      , theme = "system"
      }
    , Effect.none
    )


update : App Data ActionData RouteParams -> Shared.Model -> Msg -> Model -> ( Model, Effect Msg )
update _ _ msg model =
    case msg of
        Flip Push ->
            ( { model | push = not model.push }, Effect.none )

        Flip Email ->
            ( { model | email = not model.email }, Effect.none )

        Flip Sms ->
            ( { model | sms = not model.sms }, Effect.none )

        Flip Analytics ->
            ( { model | analytics = not model.analytics }, Effect.none )

        Flip CrashReports ->
            ( { model | crashReports = not model.crashReports }, Effect.none )

        SetTheme t ->
            ( { model | theme = t }, Effect.none )


subscriptions : RouteParams -> UrlPath -> Shared.Model -> Model -> Sub Msg
subscriptions _ _ _ _ =
    Sub.none


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    []


view : App Data ActionData RouteParams -> Shared.Model -> Model -> View (PagesMsg Msg)
view _ _ model =
    { title = "Settings · elm-m3e"
    , body =
        [ Element.toNode
            (pane
                [ Heading.view { content = Kit.text "Settings" }
                    [ Heading.variant Value.display, Heading.size Value.small, Heading.level "1" ]
                    []
                , card "Account"
                    (List_.view []
                        (List_.children
                            [ personItem "person" "Jane Doe" "jane@example.com"
                            , personItem "workspace_premium" "Plan" "Pro — renews monthly"
                            ]
                        )
                    )
                , card "Notifications"
                    (List_.view []
                        (List_.children
                            [ switchRow "notifications" "Push notifications" model.push (Flip Push)
                            , switchRow "mail" "Email updates" model.email (Flip Email)
                            , switchRow "sms" "SMS alerts" model.sms (Flip Sms)
                            ]
                        )
                    )
                , card "Appearance"
                    (segmented
                        [ ( "light", "Light" ), ( "system", "System" ), ( "dark", "Dark" ) ]
                        model.theme
                        SetTheme
                    )
                , card "Privacy"
                    (List_.view []
                        (List_.children
                            [ switchRow "analytics" "Share usage analytics" model.analytics (Flip Analytics)
                            , switchRow "bug_report" "Send crash reports" model.crashReports (Flip CrashReports)
                            ]
                        )
                    )
                ]
            )
        ]
    }


pane : List (Element { s | html : Supported } msg) -> Element { r | contentPane : Supported } msg
pane items =
    ContentPane.view [] (List.map ContentPane.child items)


{-| A settings section: an outlined card with a title header and its content.
-}
card : String -> Element { s | html : Supported } msg -> Element { r | card : Supported } msg
card title content =
    Card.view [ Card.variant Value.outlined ]
        [ Card.header (Heading.view { content = Kit.text title } [ Heading.variant Value.title ] [])
        , Card.content content
        ]


{-| A static list row: leading icon, primary text, supporting text.
-}
personItem : String -> String -> String -> Element { s | listItem : Supported } msg
personItem icon primary supporting =
    ListItem.view []
        [ ListItem.leading (Icon.view [ Icon.name icon ] [])
        , ListItem.child (Kit.text primary)
        , ListItem.supportingText (Kit.text supporting)
        ]


{-| A toggle row: leading icon, label, and a trailing interactive Switch.
-}
switchRow : String -> String -> Bool -> Msg -> Element { s | listItem : Supported } (PagesMsg Msg)
switchRow icon label on toggle =
    ListItem.view []
        [ ListItem.leading (Icon.view [ Icon.name icon ] [])
        , ListItem.child (Kit.text label)
        , ListItem.trailing
            (EscapeHatch.asElement
                (Switch.view
                    [ Aria.label label, Switch.checked on, Switch.onClick (PagesMsg.fromMsg toggle) ]
                    []
                )
            )
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
