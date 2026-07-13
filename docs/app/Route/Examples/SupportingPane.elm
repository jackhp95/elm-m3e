module Route.Examples.SupportingPane exposing (ActionData, Data, Model, Msg, route)

{-| **Supporting pane** — the canonical Material 3 adaptive supporting-pane pattern,
built as a project overview screen. It is the worked reference the
`composing-m3e-layouts` skill points at for this pattern.

The difference from list-detail: the two regions are not peers. A wide **primary**
region holds the focus content; a narrower **supporting** pane holds secondary,
related material (activity, quick stats) that *supports* the primary without
competing. On expanded windows (`lg:`) they sit side by side, primary flexing and
supporting fixed at `lg:w-80`. Below `lg:` the supporting pane reflows to the bottom
of the primary column — it stays available but yields the top of the reading order to
the primary content (the standard compact behavior for supporting panes: reflow,
don't hide).

Navigation switches the usual way: `M3e.NavRail` on desktop, `M3e.NavBar` on mobile,
one destination list. Tailwind is layout only; every visual token comes through the
`Kit` / `Kit.Surface` / `Kit.Shape` seam.

-}

import BackendTask
import ExampleNav
import Head
import Kit
import Kit.Avatar as Avatar
import Kit.Shape as Shape
import Kit.Surface as Surface
import Layout
import M3e
import Markup.Kind
import Markup.Element as Element exposing (Element)
import M3e.Kind
import M3e.Token as Value
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatelessRoute)
import Shared
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
        [ Element.toNode screen ]
    }


{-| The full-viewport shell: a desktop rail beside a column of AppBar + the
primary/supporting body, with a mobile bottom bar.
-}
screen : Element { s | html : M3e.Kind.Brand, link : Markup.Kind.Shared } msg
screen =
    Surface.view Surface.surface
        [ Layout.class "flex h-screen w-full overflow-hidden" ]
        [ desktopRail
        , Layout.colWith "flex flex-1 flex-col min-w-0 overflow-hidden"
            [ appBar
            , Layout.div "flex-1 overflow-y-auto"
                [ body
                , exampleFooter
                ]
            ]
        , mobileBar
        ]


exampleFooter : Element { s | html : M3e.Kind.Brand, link : Markup.Kind.Shared } msg
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


appBar : Element { s | appBar : M3e.Kind.Brand } msg
appBar =
    M3e.appBar []
        [ M3e.appBarSlotTitle (Kit.text "Rally redesign") ]



-- PRIMARY + SUPPORTING BODY ---------------------------------------------------


{-| The whole point of the pattern: `flex-col lg:flex-row` puts the supporting
pane BELOW the primary on compact and BESIDE it on expanded. `flex-1` lets the
primary grow; `lg:w-80 lg:shrink-0` fixes the supporting pane's width so it never
crowds the primary.
-}
body : Element { s | html : M3e.Kind.Brand } msg
body =
    Layout.div "mx-auto flex w-full max-w-6xl flex-col gap-6 p-4 pb-24 md:p-6 lg:flex-row"
        [ primary
        , supporting
        ]


{-| The primary region: the focus content. Flexes to fill the row.
-}
primary : Element { s | html : M3e.Kind.Brand } msg
primary =
    Layout.colWith "flex flex-1 flex-col gap-4 min-w-0"
        [ Kit.headline Value.small [ Kit.onSurface ] [ Kit.text "Project overview" ]
        , Kit.body Value.large [ Kit.onSurfaceVariant ]
            [ Kit.text "The Rally redesign moves the metric cards to the top row and swaps the donut for a stacked bar so the trend reads at a glance. This quarter's focus is the motion pass and the adaptive navigation." ]
        , summaryCard
        , milestonesCard
        ]


summaryCard : Element { s | card : M3e.Kind.Brand } msg
summaryCard =
    M3e.card [ M3e.variantElevated ]
        [ M3e.cardSlotHeader (Kit.title Value.large [ Kit.onSurface ] [ Kit.text "This sprint" ])
        , M3e.cardSlotContent
            (Layout.div "flex flex-wrap gap-6 pt-1"
                [ metric "12" "Tasks done"
                , metric "3" "In review"
                , metric "88%" "On track"
                ]
            )
        ]


metric : String -> String -> Element { s | html : M3e.Kind.Brand } msg
metric value label =
    Layout.colWith "flex flex-col"
        [ Kit.headline Value.medium [ Kit.primary ] [ Kit.text value ]
        , Kit.labelText Value.large [ Kit.onSurfaceVariant ] [ Kit.text label ]
        ]


milestonesCard : Element { s | card : M3e.Kind.Brand } msg
milestonesCard =
    M3e.card [ M3e.variantFilled ]
        [ M3e.cardSlotHeader (Kit.title Value.large [ Kit.onSurface ] [ Kit.text "Milestones" ])
        , M3e.cardSlotContent
            (Layout.div "flex flex-col"
                (List.intersperse (M3e.divider [ M3e.attrInset True ] [])
                    [ milestoneRow "check_circle" "Motion tokens" "Shipped"
                    , milestoneRow "pending" "Adaptive nav" "In progress"
                    , milestoneRow "radio_button_unchecked" "A11y pass" "Not started"
                    ]
                )
            )
        ]


milestoneRow : String -> String -> String -> Element { s | listItem : M3e.Kind.Brand } msg
milestoneRow iconName label status =
    M3e.listItem []
        [ M3e.listItemSlotLeading (M3e.icon [ M3e.attrName iconName ] [])
        , Kit.text label
        , M3e.listItemSlotTrailing
            (Kit.labelText Value.large [ Kit.onSurfaceVariant ] [ Kit.text status ])
        ]


{-| The supporting pane: secondary, related material. Fixed width beside the
primary on `lg:`, reflowed beneath it on compact.
-}
supporting : Element { s | html : M3e.Kind.Brand } msg
supporting =
    Layout.div "shrink-0 lg:w-80"
        [ Surface.view Surface.surfaceContainer
            [ Shape.corner Shape.large, Layout.class "flex flex-col gap-4 p-4" ]
            [ Kit.title Value.medium [ Kit.onSurface ] [ Kit.text "Recent activity" ]
            , Layout.colWith "flex flex-col gap-3"
                (List.map activityRow activity)
            , M3e.divider [] []
            , Kit.title Value.medium [ Kit.onSurface ] [ Kit.text "Tags" ]
            , Layout.div "flex flex-wrap gap-2"
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


activityRow : Activity -> Element { s | html : M3e.Kind.Brand } msg
activityRow a =
    Layout.rowWith "flex items-start gap-3"
        [ Avatar.initials a.initials
        , Layout.colWith "flex flex-col"
            [ Kit.body Value.medium [ Kit.onSurface ] [ Kit.text a.who ]
            , Kit.body Value.small [ Kit.onSurfaceVariant ] [ Kit.text a.what ]
            ]
        ]


tag : String -> Element { s | assistChip : M3e.Kind.Brand } msg
tag label =
    M3e.assistChip [] [ Kit.text label ]



-- NAVIGATION ------------------------------------------------------------------


desktopRail : Element { s | navRail : M3e.Kind.Brand } msg
desktopRail =
    M3e.navRail [ Layout.class "hidden md:flex shrink-0" ]
        (List.map navItem destinations)


mobileBar : Element { s | navBar : M3e.Kind.Brand } msg
mobileBar =
    M3e.navBar [ Layout.class "md:hidden fixed inset-x-0 bottom-0" ]
        (List.map navItem destinations)


navItem : { icon : String, label : String } -> Element { s | navItem : M3e.Kind.Brand } msg
navItem d =
    M3e.navItem
        [ M3e.attrSelected (d.label == "Overview") ]
        [ M3e.navItemSlotIcon (M3e.icon [ M3e.attrName d.icon ] [])
        , Kit.text d.label
        ]
