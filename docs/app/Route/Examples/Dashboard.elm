module Route.Examples.Dashboard exposing (ActionData, Data, Model, Msg, route)

{-| **Aperture Analytics** — a full-viewport Material 3 analytics dashboard screen,
authored on the M3e API and the userland `Kit`. It carries its own nav chrome:
an `AppBar` header, a `NavRail` on desktop and a bottom `NavBar` on mobile (same
five destinations), a KPI stat-card row, an Accounts card grid, a Budgets card
whose rows pair a category with a `Progress.linear` meter, a Recent-activity data
table built from `ListItem` rows separated by `Divider`, and a `Fab` primary
action.

Everything visual (color, type scale, surface, shape) goes through `Kit` /
`Kit.Surface` / `Kit.Shape`; Tailwind is used only for layout and responsive
visibility. Static screen (no local state).

-}

import BackendTask
import Effect exposing (Effect)
import ExampleNav
import Head
import Kit exposing (TextColor)
import Kit.Shape as Shape
import Kit.Surface as Surface
import Layout
import M3e
import HtmlIr.Kind
import HtmlIr.Element exposing (Element)
import M3e.Kind
import M3e.Values as Value
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatefulRoute)
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



-- DATA ------------------------------------------------------------------------


type alias Destination =
    { icon : String, name : String, selected : Bool }


destinations : List Destination
destinations =
    [ { icon = "dashboard", name = "Overview", selected = True }
    , { icon = "insights", name = "Reports", selected = False }
    , { icon = "receipt_long", name = "Transactions", selected = False }
    , { icon = "savings", name = "Budgets", selected = False }
    , { icon = "settings", name = "Settings", selected = False }
    ]


{-| Direction of a trend delta, which drives the icon + color role.
-}
type Trend
    = Up
    | Down


type alias Kpi =
    { label : String, value : String, delta : String, trend : Trend }


kpis : List Kpi
kpis =
    [ { label = "Total Revenue", value = "$48,290", delta = "+12.4%", trend = Up }
    , { label = "Active Users", value = "9,381", delta = "+3.1%", trend = Up }
    , { label = "Conversion", value = "4.7%", delta = "-0.6%", trend = Down }
    , { label = "Avg. Session", value = "5m 12s", delta = "+8.9%", trend = Up }
    ]


type alias Account =
    { icon : String, name : String, balance : String }


accounts : List Account
accounts =
    [ { icon = "account_balance", name = "Operating", balance = "$21,904.18" }
    , { icon = "savings", name = "Reserve", balance = "$62,890.55" }
    , { icon = "payments", name = "Payouts", balance = "$8,120.00" }
    , { icon = "credit_card", name = "Card", balance = "-$1,204.32" }
    ]


type alias Budget =
    { category : String, amount : String, used : Float, max : Float }


budgets : List Budget
budgets =
    [ { category = "Marketing", amount = "$3,200 / $4,000", used = 3200, max = 4000 }
    , { category = "Infrastructure", amount = "$1,050 / $2,500", used = 1050, max = 2500 }
    , { category = "Payroll", amount = "$18,400 / $20,000", used = 18400, max = 20000 }
    , { category = "Travel", amount = "$980 / $900", used = 980, max = 900 }
    ]


type alias Activity =
    { date : String, description : String, amount : String, incoming : Bool }


activity : List Activity
activity =
    [ { date = "Jul 02", description = "Stripe payout", amount = "+$4,120.00", incoming = True }
    , { date = "Jul 01", description = "AWS invoice", amount = "-$842.19", incoming = False }
    , { date = "Jun 30", description = "New subscription — Acme Co.", amount = "+$299.00", incoming = True }
    , { date = "Jun 29", description = "Figma seats", amount = "-$180.00", incoming = False }
    , { date = "Jun 28", description = "Refund — order #10482", amount = "-$59.00", incoming = False }
    ]



-- VIEW ------------------------------------------------------------------------


view : App Data ActionData RouteParams -> Shared.Model -> Model -> View (PagesMsg Msg)
view _ _ _ =
    { title = "Aperture Analytics · elm-m3e"
    , body =
        [ HtmlIr.Element.toNode
            (Surface.view Surface.surface
                [ Layout.class "flex flex-col min-h-screen w-full" ]
                [ appBar
                , Layout.div "flex flex-1"
                    [ desktopRail
                    , mainContent
                    ]
                , exampleFooter
                , mobileBar
                , fab
                ]
            )
        ]
    }


{-| The shared "Built from" + prev/next strip. Dashboard is the first example,
so it has no previous screen.
-}
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
            , ( "progress", "Progress" )
            , ( "fab", "Fab" )
            , ( "iconbutton", "IconButton" )
            ]
        , prev = Nothing
        , next = Just ( "/examples/shop", "Shop" )
        }



-- CHROME ----------------------------------------------------------------------


appBar : Element { s | appBar : M3e.Kind.Brand } adm_ msg
appBar =
    M3e.appBar [ M3e.sizeSmall ]
        [ M3e.appBarSlotLeading (M3e.icon [ M3e.attrName "analytics" ] [])
        , M3e.appBarSlotTitle (Kit.title Value.large [] [ Kit.text "Aperture Analytics" ])
        , M3e.appBarSlotTrailing
            (Layout.div "flex items-center gap-1"
                [ iconAction "search"
                , iconAction "notifications"
                , iconAction "account_circle"
                ]
            )
        ]


iconAction : String -> Element { s | iconButton : M3e.Kind.Brand } adm_ msg
iconAction name =
    M3e.iconButton
        [ M3e.variantStandard, M3e.ariaLabel name ]
        [ M3e.icon [ M3e.attrName name ] [] ]


{-| The desktop side rail. Hidden on mobile via `hidden md:flex`.
-}
desktopRail : Element { s | html : M3e.Kind.Brand } adm_ msg
desktopRail =
    Layout.div "hidden md:flex sticky top-0 self-start"
        [ M3e.navRail []
            (List.map railItem destinations)
        ]


railItem : Destination -> Element { s | navItem : M3e.Kind.Brand } adm_ msg
railItem d =
    M3e.navItem
        [ M3e.attrHref "#", M3e.attrSelected d.selected ]
        [ M3e.navItemSlotIcon (M3e.icon [ M3e.attrName d.icon ] [])
        , Kit.text d.name
        ]


{-| The mobile bottom bar. Hidden on desktop via `md:hidden`.
-}
mobileBar : Element { s | html : M3e.Kind.Brand } adm_ msg
mobileBar =
    Layout.div "md:hidden sticky bottom-0 z-10"
        [ M3e.navBar []
            (List.map barItem destinations)
        ]


barItem : Destination -> Element { s | navItem : M3e.Kind.Brand } adm_ msg
barItem d =
    M3e.navItem
        [ M3e.attrHref "#", M3e.attrSelected d.selected ]
        [ M3e.navItemSlotIcon (M3e.icon [ M3e.attrName d.icon ] [])
        , Kit.text d.name
        ]


fab : Element { s | html : M3e.Kind.Brand } adm_ msg
fab =
    Layout.div "fixed bottom-20 right-4 md:bottom-6 md:right-6 z-20"
        [ M3e.fab
            [ M3e.variantPrimary, M3e.attrExtended True, M3e.ariaLabel "Add" ]
            [ M3e.icon [ M3e.attrName "add" ] []
            , M3e.fabSlotLabel (Kit.text "New report")
            ]
        ]



-- MAIN CONTENT ----------------------------------------------------------------


mainContent : Element { s | html : M3e.Kind.Brand } adm_ msg
mainContent =
    Layout.section "flex-1 min-w-0 flex flex-col gap-6 p-4 md:p-6 pb-28 md:pb-6"
        [ pageHeader
        , kpiRow
        , Layout.div "grid grid-cols-1 gap-6 lg:grid-cols-3"
            [ Layout.div "lg:col-span-2 flex flex-col gap-6"
                [ accountsSection
                , activitySection
                ]
            , budgetsSection
            ]
        ]


pageHeader : Element { s | html : M3e.Kind.Brand } adm_ msg
pageHeader =
    Layout.div "flex flex-col gap-1"
        [ Kit.overline [ Kit.onSurfaceVariant ] [ Kit.text "Overview" ]
        , Kit.display Value.small [] [ Kit.text "Good morning, Jack" ]
        , Kit.body Value.medium [ Kit.onSurfaceVariant ] [ Kit.text "Here is how your business is doing today." ]
        ]



-- KPI ROW ---------------------------------------------------------------------


kpiRow : Element { s | html : M3e.Kind.Brand } adm_ msg
kpiRow =
    Layout.div "grid grid-cols-1 gap-4 sm:grid-cols-2 xl:grid-cols-4"
        (List.map kpiCard kpis)


kpiCard : Kpi -> Element { s | card : M3e.Kind.Brand } adm_ msg
kpiCard k =
    M3e.card [ M3e.variantFilled ]
        [ M3e.cardSlotContent
            (Layout.div "flex flex-col gap-2 p-4"
                [ Kit.labelText Value.large [ Kit.onSurfaceVariant ] [ Kit.text k.label ]
                , Kit.display Value.small [] [ Kit.text k.value ]
                , trendDelta k.trend k.delta
                ]
            )
        ]


trendDelta : Trend -> String -> Element { s | html : M3e.Kind.Brand } adm_ msg
trendDelta trend delta =
    let
        ( iconName, role ) =
            case trend of
                Up ->
                    ( "trending_up", Kit.primary )

                Down ->
                    ( "trending_down", Kit.error )
    in
    Layout.div "flex items-center gap-1"
        [ Kit.colored [ role ] [ M3e.icon [ M3e.attrName iconName ] [] ]
        , Kit.labelText Value.large [ role ] [ Kit.text delta ]
        ]



-- ACCOUNTS --------------------------------------------------------------------


accountsSection : Element { s | card : M3e.Kind.Brand } adm_ msg
accountsSection =
    sectionCard "Accounts"
        (Layout.div "grid grid-cols-1 gap-3 sm:grid-cols-2"
            (List.map accountRow accounts)
        )


accountRow : Account -> Element { s | html : M3e.Kind.Brand } adm_ msg
accountRow a =
    Surface.view Surface.surfaceContainerHigh
        [ Shape.corner Shape.large, Layout.class "flex items-center gap-3 p-3" ]
        [ Surface.view Surface.secondaryContainer
            [ Shape.corner Shape.full, Layout.class "flex items-center justify-center p-2" ]
            [ M3e.icon [ M3e.attrName a.icon ] [] ]
        , Layout.div "flex flex-col min-w-0"
            [ Kit.body Value.medium [] [ Kit.text a.name ]
            , Kit.title Value.medium [] [ Kit.text a.balance ]
            ]
        ]



-- BUDGETS ---------------------------------------------------------------------


budgetsSection : Element { s | card : M3e.Kind.Brand } adm_ msg
budgetsSection =
    sectionCard "Budgets"
        (Layout.div "flex flex-col gap-5"
            (List.map budgetRow budgets)
        )


budgetRow : Budget -> Element { s | html : M3e.Kind.Brand } adm_ msg
budgetRow b =
    Layout.div "flex flex-col gap-2"
        [ Layout.div "flex items-center justify-between gap-2"
            [ Kit.body Value.medium [] [ Kit.text b.category ]
            , Kit.labelText Value.large [ Kit.onSurfaceVariant ] [ Kit.text b.amount ]
            ]
        , M3e.linear
            [ M3e.attrValueFloat b.used, M3e.attrMax b.max ]
            []
        ]



-- RECENT ACTIVITY -------------------------------------------------------------


activitySection : Element { s | card : M3e.Kind.Brand } adm_ msg
activitySection =
    sectionCard "Recent activity"
        (Layout.div "flex flex-col"
            (List.intersperse (M3e.divider [] [])
                (List.map activityRow activity)
            )
        )


activityRow : Activity -> Element { s | listItem : M3e.Kind.Brand } adm_ msg
activityRow a =
    let
        role : TextColor
        role =
            if a.incoming then
                Kit.primary

            else
                Kit.onSurface
    in
    M3e.listItem []
        [ M3e.listItemSlotLeading
            (Kit.labelText Value.large [ Kit.onSurfaceVariant ] [ Kit.text a.date ])
        , Kit.text a.description
        , M3e.listItemSlotTrailing
            (Kit.title Value.medium [ role ] [ Kit.text a.amount ])
        ]



-- SHARED SECTION CARD ---------------------------------------------------------


sectionCard : String -> Element any adm_ msg -> Element { r | card : M3e.Kind.Brand } adm_ msg
sectionCard heading content =
    M3e.card [ M3e.variantElevated ]
        [ M3e.cardSlotHeader
            (Kit.title Value.large [] [ Kit.text heading ])
        , M3e.cardSlotContent content
        ]
