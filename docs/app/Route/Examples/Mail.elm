module Route.Examples.Mail exposing (ActionData, Data, Model, Msg, route)

{-| **Mail** — a full-viewport, responsive Material 3 email client screen built
almost entirely from `M3e.*` components. Tailwind is used only for layout
(flex/grid/gap/padding/positioning/responsive visibility); every visual token —
color, typography, surface, shape — comes through the `Kit` / `Kit.Surface` /
`Kit.Shape` seam.

Layout at a glance:

  - Adaptive navigation: an `M3e.NavRail` down the left on desktop (`hidden md:flex`)
    and an `M3e.NavBar` pinned to the bottom on mobile (`md:hidden`). A top
    `M3e.AppBar` holds the app name and an `M3e.SearchBar`.
  - A two-pane body that reflows: on `md:` the message `M3e.List` sits in a fixed
    `md:w-96` column beside a reading pane that fills the rest; below `md:` the
    list is full-width and the reading pane stacks beneath it.
  - Selecting a row (`SelectMessage`) repaints the reading pane and marks the row
    with a `surfaceContainer` background.
  - An `M3e.Fab` floats bottom-right to compose.

-}

import BackendTask
import Effect exposing (Effect)
import ExampleNav
import Head
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind
import Kit
import Kit.Avatar as Avatar
import Kit.Surface as Surface exposing (Surface)
import Layout
import M3e
import M3e.AppBar
import M3e.AssistChip
import M3e.Attributes
import M3e.Fab
import M3e.Kind
import M3e.ListItem
import M3e.NavItem
import M3e.SearchBar
import M3e.Values as Value
import Native
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatefulRoute)
import Shared
import TypedHtml.Aria as Aria
import TypedHtml.Attributes as TA
import UrlPath exposing (UrlPath)
import View exposing (View)


type alias Model =
    { selected : Int }


type Msg
    = SelectMessage Int


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
    ( { selected = 0 }, Effect.none )


update : App Data ActionData RouteParams -> Shared.Model -> Msg -> Model -> ( Model, Effect Msg )
update _ _ msg model =
    case msg of
        SelectMessage i ->
            ( { model | selected = i }, Effect.none )


subscriptions : RouteParams -> UrlPath -> Shared.Model -> Model -> Sub Msg
subscriptions _ _ _ _ =
    Sub.none


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    []



-- DATA ------------------------------------------------------------------------


type alias Message =
    { sender : String
    , initials : String
    , subject : String
    , snippet : String
    , body : List String
    , time : String
    , labels : List String
    }


inbox : List Message
inbox =
    [ { sender = "Ali Connors"
      , initials = "AC"
      , subject = "Weekend hiking plans — trail options"
      , snippet = "I mapped out three routes for Saturday. The ridge loop looks best if the weather holds…"
      , body =
            [ "I mapped out three routes for Saturday. The ridge loop looks best if the weather holds — it is about 11 km with a long exposed section near the summit, so bring layers."
            , "The valley trail is the safer fallback: shorter, mostly shaded, and the river crossings are low this time of year. Let me know which you prefer and I will book the trailhead parking."
            ]
      , time = "9:32 AM"
      , labels = [ "Personal", "Travel" ]
      }
    , { sender = "Design team"
      , initials = "DT"
      , subject = "M3 Expressive review notes"
      , snippet = "Great progress on the motion pass. A few notes on the nav rail expansion and FAB placement…"
      , body =
            [ "Great progress on the motion pass. A few notes on the nav rail expansion and FAB placement before we ship the beta."
            , "The rail feels right in compact mode, but the expanded label transition should ease out a touch slower. The compose FAB should stay anchored above the bottom bar on small screens."
            ]
      , time = "8:15 AM"
      , labels = [ "Work" ]
      }
    , { sender = "Ferry Ticketing"
      , initials = "FT"
      , subject = "Your booking is confirmed"
      , snippet = "Booking #48213 is confirmed for the 07:40 sailing. Your boarding pass is attached…"
      , body =
            [ "Booking #48213 is confirmed for the 07:40 sailing on Saturday. Please arrive at the terminal at least 30 minutes before departure."
            , "Your boarding pass is attached to this message. Vehicle deck access closes 10 minutes prior to sailing."
            ]
      , time = "Yesterday"
      , labels = [ "Travel" ]
      }
    , { sender = "Product updates"
      , initials = "PU"
      , subject = "What's new in @m3e/web 2.5"
      , snippet = "This release adds split panes, refreshed search, and expressive elevation tokens…"
      , body =
            [ "This release adds split panes, a refreshed search experience, and expressive elevation tokens across every layer/form role."
            , "Upgrade notes and the full changelog are on the release page. No breaking changes to component slots in this cycle."
            ]
      , time = "Mon"
      , labels = [ "Updates" ]
      }
    , { sender = "Trevor Hansen"
      , initials = "TH"
      , subject = "Re: Rally dashboard mockups"
      , snippet = "Attaching the revised board with the metric cards on top. Thoughts on the chart colors?"
      , body =
            [ "Attaching the revised board with the metric cards moved to the top row. I swapped the donut for a stacked bar so the trend reads at a glance."
            , "Thoughts on the chart colors? I leaned on the tertiary palette to keep the primary reserved for actions."
            ]
      , time = "Sun"
      , labels = [ "Work" ]
      }
    ]


{-| The five navigation destinations, with their Material Symbols icon name.
-}
destinations : List { icon : String, label : String }
destinations =
    [ { icon = "inbox", label = "Inbox" }
    , { icon = "star", label = "Starred" }
    , { icon = "send", label = "Sent" }
    , { icon = "draft", label = "Drafts" }
    , { icon = "report", label = "Spam" }
    ]



-- VIEW ------------------------------------------------------------------------


view : App Data ActionData RouteParams -> Shared.Model -> Model -> View (PagesMsg Msg)
view _ _ model =
    { title = "Mail · elm-m3e"
    , body =
        [ HtmlIr.Element.toNode (HtmlIr.Element.map PagesMsg.fromMsg (screen model)) ]
    }


{-| The whole screen: full-viewport shell painted onto the base `surface`, with
the nav rail beside a column of AppBar + two-pane body, plus the mobile bottom
bar and the floating compose FAB.
-}
screen : Model -> Element { s | html : M3e.Kind.Brand, sharedLink : HtmlIr.Kind.Shared } adm_ Msg
screen model =
    Surface.view Surface.surface
        [ Layout.class "relative flex h-screen w-full overflow-hidden" ]
        [ navRail
        , Layout.colWith "flex flex-1 flex-col min-w-0"
            [ topBar
            , body model
            , exampleFooter
            ]
        , bottomBar
        , composeFab
        ]


{-| The shared "Built from" + prev/next strip.
-}
exampleFooter : Element { s | html : M3e.Kind.Brand, sharedLink : HtmlIr.Kind.Shared } adm_ msg
exampleFooter =
    ExampleNav.footer
        { builtFrom =
            [ ( "appbar", "AppBar" )
            , ( "navrail", "NavRail" )
            , ( "navbar", "NavBar" )
            , ( "searchbar", "SearchBar" )
            , ( "list", "List" )
            , ( "listitem", "ListItem" )
            , ( "divider", "Divider" )
            , ( "fab", "Fab" )
            ]
        , prev = Just ( "/examples/shop", "Shop" )
        , next = Just ( "/examples/travel", "Travel" )
        }



-- NAVIGATION ------------------------------------------------------------------


{-| Desktop navigation rail (hidden below `md:`).
-}
navRail : Element { s | html : M3e.Kind.Brand } adm_ Msg
navRail =
    Layout.nav "hidden md:flex"
        [ M3e.navRail [ M3e.Attributes.mode Value.expanded ]
            (List.indexedMap railItem destinations)
        ]


railItem : Int -> { icon : String, label : String } -> Element { s | navItem : M3e.Kind.Brand } adm_ Msg
railItem index d =
    M3e.navItem
        [ M3e.Attributes.selected (index == 0) ]
        [ M3e.NavItem.icon (M3e.icon [ TA.name d.icon ] [])
        , Kit.text d.label
        ]


{-| Mobile bottom navigation bar (hidden at `md:` and up).
-}
bottomBar : Element { s | html : M3e.Kind.Brand } adm_ Msg
bottomBar =
    Layout.nav "md:hidden fixed inset-x-0 bottom-0"
        [ M3e.navBar []
            (List.indexedMap barItem destinations)
        ]


barItem : Int -> { icon : String, label : String } -> Element { s | navItem : M3e.Kind.Brand } adm_ Msg
barItem index d =
    M3e.navItem
        [ M3e.Attributes.selected (index == 0) ]
        [ M3e.NavItem.icon (M3e.icon [ TA.name d.icon ] [])
        , Kit.text d.label
        ]



-- TOP BAR ---------------------------------------------------------------------


topBar : Element { s | appBar : M3e.Kind.Brand } adm_ Msg
topBar =
    M3e.appBar [ M3e.Attributes.size Value.medium ]
        [ M3e.AppBar.leading (M3e.icon [ TA.name "menu" ] [])
        , M3e.AppBar.title (Kit.text "Mail")
        , M3e.AppBar.trailing searchBar
        ]


searchBar : Element { s | searchBar : M3e.Kind.Brand } adm_ Msg
searchBar =
    M3e.searchBar
        []
        [ M3e.SearchBar.input
            (Native.node "input"
                [ Native.attribute "placeholder" "Search mail"
                , Native.attribute "type" "search"
                ]
                []
            )
        , M3e.SearchBar.leading (M3e.icon [ TA.name "search" ] [])
        ]



-- BODY: TWO-PANE --------------------------------------------------------------


{-| The reflowing two-pane body. On `md:` the list is a fixed-width column beside
a filling reading pane; below `md:` they stack (list first, reading pane under).
-}
body : Model -> Element { s | html : M3e.Kind.Brand } adm_ Msg
body model =
    Layout.colWith "flex flex-1 flex-col md:flex-row min-h-0 overflow-hidden"
        [ Layout.section "w-full md:w-96 md:shrink-0 overflow-y-auto md:border-r md:border-outline-variant"
            [ messageList model ]
        , Layout.section "flex-1 overflow-y-auto"
            [ readingPane (selectedMessage model) ]
        ]


selectedMessage : Model -> Message
selectedMessage model =
    inbox
        |> List.drop model.selected
        |> List.head
        |> Maybe.withDefault (Maybe.withDefault emptyMessage (List.head inbox))


emptyMessage : Message
emptyMessage =
    { sender = "", initials = "", subject = "", snippet = "", body = [], time = "", labels = [] }


{-| The inbox list: one `ListItem` per message with an avatar, sender, subject,
snippet (supporting text) and timestamp, separated by dividers. The selected row
is painted with a `surfaceContainer` background.
-}
messageList : Model -> Element { s | list : M3e.Kind.Brand } adm_ Msg
messageList model =
    M3e.list []
        (List.intersperse divider
            (List.indexedMap (messageRow model.selected) inbox)
        )


divider : Element { s | divider : M3e.Kind.Brand } adm_ msg
divider =
    M3e.divider [ M3e.Attributes.inset True ] []


messageRow : Int -> Int -> Message -> Element { s | listItem : M3e.Kind.Brand } adm_ Msg
messageRow selected index message =
    let
        rowSurface : Surface
        rowSurface =
            if index == selected then
                Surface.surfaceContainer

            else
                Surface.surface
    in
    M3e.listItem
        [ Surface.asAttribute rowSurface
        , Layout.class "cursor-pointer"
        , Native.attribute "role" "button"
        , Native.onClick (SelectMessage index)
        ]
        [ M3e.ListItem.leading (Avatar.initials message.initials)
        , Kit.text message.sender
        , M3e.ListItem.supportingText
            (Layout.span "block"
                [ Kit.body Value.medium [ Kit.onSurface ] [ Kit.text message.subject ]
                , Layout.span "block"
                    [ Kit.body Value.small [ Kit.onSurfaceVariant ] [ Kit.text message.snippet ] ]
                ]
            )
        , M3e.ListItem.trailing
            (Kit.labelText Value.small [ Kit.onSurfaceVariant ] [ Kit.text message.time ])
        ]



-- READING PANE ----------------------------------------------------------------


{-| The reading pane for the selected message: subject heading, sender row with
avatar and timestamp, label chips, and the body paragraphs via `Kit`.
-}
readingPane : Message -> Element { s | html : M3e.Kind.Brand } adm_ msg
readingPane message =
    Layout.colWith "flex flex-col gap-6 p-6"
        [ Kit.headline Value.small [ Kit.onSurface ] [ Kit.text message.subject ]
        , Layout.rowWith "flex items-center gap-3"
            [ Avatar.initials message.initials
            , Layout.colWith "flex flex-col"
                [ Kit.title Value.medium [ Kit.onSurface ] [ Kit.text message.sender ]
                , Kit.labelText Value.small [ Kit.onSurfaceVariant ] [ Kit.text ("to me · " ++ message.time) ]
                ]
            ]
        , Layout.rowWith "flex flex-wrap gap-2"
            (List.map labelChip message.labels)
        , Layout.colWith "flex flex-col gap-4"
            (List.map (\p -> Kit.paragraph Value.medium [ Kit.onSurfaceVariant ] [ Kit.text p ]) message.body)
        ]


labelChip : String -> Element { s | assistChip : M3e.Kind.Brand } adm_ msg
labelChip name =
    M3e.assistChip
        []
        [ M3e.text name
        , M3e.AssistChip.icon (M3e.icon [ TA.name "label" ] [])
        ]



-- FAB -------------------------------------------------------------------------


{-| Floating compose action, anchored bottom-right (kept above the mobile bar).
-}
composeFab : Element { s | html : M3e.Kind.Brand } adm_ msg
composeFab =
    Layout.div "absolute bottom-20 right-6 md:bottom-6"
        [ M3e.fab
            [ M3e.Attributes.variant Value.primaryContainer
            , M3e.Attributes.extended True
            , Aria.label "Compose"
            ]
            [ M3e.icon [ TA.name "edit" ] []
            , M3e.Fab.label (Kit.text "Compose")
            ]
        ]
