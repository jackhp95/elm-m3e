module Route.Examples.SupportingPane exposing (ActionData, Data, Model, Msg, route)

{-| **Supporting pane** — the canonical Material 3 adaptive supporting-pane pattern,
built as a project overview screen. It is the worked reference the
`composing-m3e-layouts` skill points at for this pattern.

The difference from list-detail: the two regions are not peers. A wide **primary**
region holds the focus content; a narrower **supporting** pane holds secondary,
related material (activity, quick stats) that _supports_ the primary without
competing. On expanded windows (`lg:`) they sit side by side, primary flexing and
supporting fixed at `lg:w-80`. Below `lg:` the supporting pane reflows to the bottom
of the primary column — it stays available but yields the top of the reading order to
the primary content (the standard compact behavior for supporting panes: reflow,
don't hide).

Navigation switches the usual way: `M3e.NavRail` on desktop, `M3e.NavBar` on mobile,
one destination list. Tailwind is layout only; every visual token comes through the
`Seam` / `Seam.Surface` / `Seam.Shape` seam.

-}

import BackendTask
import ExampleNav
import Head
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind
import M3e
import M3e.AppBar
import M3e.Attributes
import M3e.Card
import M3e.Kind
import M3e.ListItem
import M3e.NavItem
import M3e.Values as Value
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatelessRoute)
import Seam
import Seam.Avatar as Avatar
import Seam.Shape as Shape
import Seam.Surface as Surface
import Shared
import TypedHtml.Aria as Aria
import TypedHtml.Attributes as TA
import View exposing (View)



-- MODEL -----------------------------------------------------------------------


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


{-| The five navigation destinations, with their Material Symbols icon name.
-}
destinations : List { icon : String, label : String }
destinations =
    [ { icon = "dashboard", label = "Overview" }
    , { icon = "task", label = "Tasks" }
    , { icon = "forum", label = "Discussion" }
    , { icon = "folder", label = "Files" }
    , { icon = "settings", label = "Settings" }
    ]



-- VIEW ------------------------------------------------------------------------


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Supporting pane · elm-m3e"
    , body =
        [ HtmlIr.Element.toNode screen ]
    }


{-| The full-viewport shell: a desktop rail beside a column of AppBar + the
primary/supporting body, with a mobile bottom bar.
-}
screen : Element { s | html : M3e.Kind.Brand, sharedLink : HtmlIr.Kind.Shared } adm_ msg
screen =
    Surface.view Surface.surface
        [ Seam.class "flex h-screen w-full overflow-hidden" ]
        [ desktopRail
        , Seam.div "flex flex-1 flex-col min-w-0 overflow-hidden"
            [ appBar
            , Seam.div "flex-1 overflow-y-auto"
                [ body
                , exampleFooter
                ]
            ]
        , mobileBar
        ]


exampleFooter : Element { s | html : M3e.Kind.Brand, sharedLink : HtmlIr.Kind.Shared } adm_ msg
exampleFooter =
    ExampleNav.footer
        { builtFrom =
            [ ( "appbar", "AppBar" )
            , ( "navrail", "NavRail" )
            , ( "navbar", "NavBar" )
            , ( "card", "Card" )
            , ( "listitem", "ListItem" )
            , ( "divider", "Divider" )
            , ( "assistchip", "AssistChip" )
            ]
        , prev = Just ( "/examples/list-detail", "List-detail" )
        , next = Just ( "/examples/feed", "Feed" )
        }


appBar : Element { s | appBar : M3e.Kind.Brand } adm_ msg
appBar =
    M3e.appBar []
        [ M3e.AppBar.title (Seam.text "Rally redesign") ]



-- PRIMARY + SUPPORTING BODY ---------------------------------------------------


{-| The whole point of the pattern: `flex-col lg:flex-row` puts the supporting
pane BELOW the primary on compact and BESIDE it on expanded. `flex-1` lets the
primary grow; `lg:w-80 lg:shrink-0` fixes the supporting pane's width so it never
crowds the primary.
-}
body : Element { s | html : M3e.Kind.Brand } adm_ msg
body =
    Seam.div "mx-auto flex w-full max-w-6xl flex-col gap-6 p-4 pb-24 md:p-6 lg:flex-row"
        [ primary
        , supporting
        ]


{-| The primary region: the focus content. Flexes to fill the row.
-}
primary : Element { s | html : M3e.Kind.Brand } adm_ msg
primary =
    Seam.div "flex flex-1 flex-col gap-4 min-w-0"
        [ Seam.headline Value.small [ Seam.onSurface ] [ Seam.text "Project overview" ]
        , Seam.body Value.large
            [ Seam.onSurfaceVariant ]
            [ Seam.text "The Rally redesign moves the metric cards to the top row and swaps the donut for a stacked bar so the trend reads at a glance. This quarter's focus is the motion pass and the adaptive navigation." ]
        , summaryCard
        , milestonesCard
        ]


summaryCard : Element { s | card : M3e.Kind.Brand } adm_ msg
summaryCard =
    M3e.card [ M3e.Attributes.variant Value.elevated ]
        [ M3e.Card.header (Seam.title Value.large [ Seam.onSurface ] [ Seam.text "This sprint" ])
        , M3e.Card.content
            (Seam.div "flex flex-wrap gap-6 pt-1"
                [ metric "12" "Tasks done"
                , metric "3" "In review"
                , metric "88%" "On track"
                ]
            )
        ]


metric : String -> String -> Element { s | html : M3e.Kind.Brand } adm_ msg
metric value label =
    Seam.div "flex flex-col"
        [ Seam.headline Value.medium [ Seam.primary ] [ Seam.text value ]
        , Seam.labelText Value.large [ Seam.onSurfaceVariant ] [ Seam.text label ]
        ]


milestonesCard : Element { s | card : M3e.Kind.Brand } adm_ msg
milestonesCard =
    M3e.card [ M3e.Attributes.variant Value.filled ]
        [ M3e.Card.header (Seam.title Value.large [ Seam.onSurface ] [ Seam.text "Milestones" ])
        , M3e.Card.content
            (M3e.list []
                (List.intersperse (M3e.divider [ M3e.Attributes.inset True ] [])
                    [ milestoneRow "check_circle" "Motion tokens" "Shipped"
                    , milestoneRow "pending" "Adaptive nav" "In progress"
                    , milestoneRow "radio_button_unchecked" "A11y pass" "Not started"
                    ]
                )
            )
        ]


milestoneRow : String -> String -> String -> Element { s | listItem : M3e.Kind.Brand } adm_ msg
milestoneRow iconName label status =
    M3e.listItem []
        [ M3e.ListItem.leading (M3e.icon [ TA.name iconName ] [])
        , Seam.text label
        , M3e.ListItem.trailing
            (Seam.labelText Value.large [ Seam.onSurfaceVariant ] [ Seam.text status ])
        ]


{-| The supporting pane: secondary, related material. Fixed width beside the
primary on `lg:`, reflowed beneath it on compact.
-}
supporting : Element { s | html : M3e.Kind.Brand } adm_ msg
supporting =
    Seam.div "shrink-0 lg:w-80"
        [ Surface.view Surface.surfaceContainer
            [ Shape.corner Shape.large, Seam.class "flex flex-col gap-4 p-4" ]
            [ Seam.title Value.medium [ Seam.onSurface ] [ Seam.text "Recent activity" ]
            , Seam.div "flex flex-col gap-3"
                (List.map activityRow activity)
            , M3e.divider [] []
            , Seam.title Value.medium [ Seam.onSurface ] [ Seam.text "Tags" ]
            , M3e.chipSet [ Aria.label "Tags" ]
                (List.map tag [ "design", "motion", "a11y", "beta" ])
            ]
        ]


type alias Activity =
    { initials : String, who : String, what : String }


activity : List Activity
activity =
    [ { initials = "AC", who = "Ali", what = "commented on Motion tokens" }
    , { initials = "TH", who = "Trevor", what = "updated the trend chart" }
    , { initials = "SA", who = "Sandra", what = "approved the nav PR" }
    ]


activityRow : Activity -> Element { s | html : M3e.Kind.Brand } adm_ msg
activityRow a =
    Seam.div "flex items-start gap-3"
        [ Avatar.initials a.initials
        , Seam.div "flex flex-col"
            [ Seam.body Value.medium [ Seam.onSurface ] [ Seam.text a.who ]
            , Seam.body Value.small [ Seam.onSurfaceVariant ] [ Seam.text a.what ]
            ]
        ]


tag : String -> Element { s | assistChip : M3e.Kind.Brand } adm_ msg
tag label =
    M3e.assistChip [] [ Seam.text label ]



-- NAVIGATION ------------------------------------------------------------------


desktopRail : Element { s | navRail : M3e.Kind.Brand } adm_ msg
desktopRail =
    M3e.navRail [ Seam.class "hidden md:flex shrink-0" ]
        (List.map navItem destinations)


mobileBar : Element { s | navBar : M3e.Kind.Brand } adm_ msg
mobileBar =
    M3e.navBar [ Seam.class "md:hidden fixed inset-x-0 bottom-0" ]
        (List.map navItem destinations)


navItem : { icon : String, label : String } -> Element { s | navItem : M3e.Kind.Brand } adm_ msg
navItem d =
    M3e.navItem
        [ M3e.Attributes.selected (d.label == "Overview") ]
        [ M3e.NavItem.icon (M3e.icon [ TA.name d.icon ] [])
        , Seam.text d.label
        ]
