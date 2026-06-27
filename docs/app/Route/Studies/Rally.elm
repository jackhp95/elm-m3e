module Route.Studies.Rally exposing (ActionData, Data, Model, Msg, route)

{-| **Rally** — a Material 3 personal-finance dashboard study.

A dark-themed money surface that composes a large slice of the elm-m3e
library the way the catalogue intends:

  - `M3e.Theme` wraps the whole surface in a dark, expressive scheme.
  - `M3e.AppBar` carries a month `M3e.Select` and a refresh `M3e.IconButton`
    that spins a `M3e.LoadingIndicator` while "syncing".
  - `M3e.NavigationRail` mirrors the active section.
  - `M3e.Tabs` switches between **Accounts / Bills / Budgets**.
  - **Accounts** groups Checking / Savings / Credit in a
    `M3e.Disclosure` accordion with running totals, and lists recent
    transactions filtered by a `M3e.Search` bar — matches are marked with
    `M3e.TextHighlight` and paged with `M3e.Paginator`.
  - **Bills** pairs a `M3e.Calendar` of due dates with a due-soon `M3e.List`.
  - **Budgets** shows a per-category spend `M3e.Progress` ring + bars inside
    `M3e.Card`s; expanding a category reveals its line items.
  - `M3e.Tooltip`, `M3e.Divider`, `M3e.Heading`, `M3e.Icon`,
    `M3e.ScrollContainer`, and a `M3e.Snackbar` ("Budget updated") round it out.

All page interactivity is local state via `RouteBuilder.buildWithLocalState`.

-}

import BackendTask exposing (BackendTask)
import Effect exposing (Effect)
import Head
import Head.Seo as Seo
import Html exposing (div, span, text)
import Html.Attributes as Attr exposing (class)
import M3e.AppBar as AppBar
import M3e.Calendar as Calendar
import M3e.Card as Card
import M3e.Disclosure as Disclosure
import M3e.Divider as Divider
import M3e.Heading as Heading
import M3e.Icon as Icon
import M3e.IconButton as IconButton
import M3e.List as List_
import M3e.LoadingIndicator as LoadingIndicator
import M3e.NavigationRail as NavigationRail
import M3e.Node as Node exposing (Node)
import M3e.Paginator as Paginator
import M3e.Progress as Progress
import M3e.Element as Element exposing (Element, Supported)
import M3e.ScrollContainer as ScrollContainer
import M3e.Search as Search
import M3e.Select as Select
import M3e.Snackbar as Snackbar
import M3e.Tabs as Tabs
import M3e.TextHighlight as TextHighlight
import M3e.Theme as Theme
import M3e.Tooltip as Tooltip
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatefulRoute)
import Shared
import UrlPath
import View exposing (View)



-- ROUTE WIRING -----------------------------------------------------------


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
            , subscriptions = \_ _ _ _ -> Sub.none
            }


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-m3e"
        , image = { url = [ "favicon.ico" ] |> UrlPath.join |> Pages.Url.fromPath, alt = "elm-m3e", dimensions = Nothing, mimeType = Nothing }
        , description = "Rally — a Material 3 personal-finance dashboard study built with elm-m3e."
        , locale = Nothing
        , title = "Rally · Studies · elm-m3e"
        }
        |> Seo.website



-- MODEL ------------------------------------------------------------------


type Tab
    = Accounts
    | Bills
    | Budgets


type Month
    = January
    | February
    | March


type alias Model =
    { tab : Tab
    , month : Month
    , query : String
    , page : Int
    , syncing : Bool
    , snackbar : Maybe String
    }


init : App Data ActionData RouteParams -> Shared.Model -> ( Model, Effect Msg )
init _ _ =
    ( { tab = Budgets
      , month = March
      , query = ""
      , page = 0
      , syncing = False
      , snackbar = Nothing
      }
    , Effect.none
    )



-- UPDATE -----------------------------------------------------------------


type Msg
    = TabSelected Tab
    | MonthSelected Month
    | QueryChanged String
    | PageChanged Int
    | RefreshClicked
    | BudgetAdjusted String


update : App Data ActionData RouteParams -> Shared.Model -> Msg -> Model -> ( Model, Effect Msg )
update _ _ msg model =
    case msg of
        TabSelected tab ->
            ( { model | tab = tab, snackbar = Nothing }, Effect.none )

        MonthSelected month ->
            ( { model | month = month, page = 0 }, Effect.none )

        QueryChanged query ->
            -- A new filter resets paging so matches are never hidden off-page.
            ( { model | query = query, page = 0 }, Effect.none )

        PageChanged page ->
            ( { model | page = page }, Effect.none )

        RefreshClicked ->
            -- Toggling reflects "start / finish sync" without a real port round-trip.
            ( { model | syncing = not model.syncing }, Effect.none )

        BudgetAdjusted category ->
            ( { model | snackbar = Just ("Budget updated · " ++ category) }, Effect.none )



-- DOMAIN: pure finance data + math --------------------------------------


type alias Account =
    { name : String
    , institution : String
    , cents : Int
    }


type alias AccountGroup =
    { id : String
    , label : String
    , icon : String
    , accounts : List Account
    }


type alias Transaction =
    { merchant : String
    , category : String
    , dateLabel : String
    , cents : Int
    }


type alias Bill =
    { payee : String
    , dueLabel : String
    , cents : Int
    , autopay : Bool
    }


type alias BudgetCategory =
    { id : String
    , label : String
    , icon : String
    , spentCents : Int
    , budgetCents : Int
    , lines : List ( String, Int )
    }


{-| Spend as an integer 0..100 percentage of the budget, clamped so an
overspent category never drives a progress bar past full.
-}
budgetPercent : BudgetCategory -> Int
budgetPercent c =
    if c.budgetCents <= 0 then
        0

    else
        clamp 0 100 (round (toFloat c.spentCents / toFloat c.budgetCents * 100))


{-| True when a category has spent more than its budget.
-}
isOverBudget : BudgetCategory -> Bool
isOverBudget c =
    c.spentCents > c.budgetCents


totalSpent : List BudgetCategory -> Int
totalSpent =
    List.foldl (\c acc -> acc + c.spentCents) 0


totalBudget : List BudgetCategory -> Int
totalBudget =
    List.foldl (\c acc -> acc + c.budgetCents) 0


{-| Overall spend ring percentage for the summary card.
-}
overallPercent : List BudgetCategory -> Int
overallPercent categories =
    let
        budget =
            totalBudget categories
    in
    if budget <= 0 then
        0

    else
        clamp 0 100 (round (toFloat (totalSpent categories) / toFloat budget * 100))


groupTotalCents : AccountGroup -> Int
groupTotalCents group =
    List.foldl (\a acc -> acc + a.cents) 0 group.accounts


{-| Format integer cents (possibly negative) as USD, e.g. `-123456 → "-$1,234.56"`.
-}
formatMoney : Int -> String
formatMoney cents =
    let
        sign =
            if cents < 0 then
                "-"

            else
                ""

        absCents =
            abs cents

        dollars =
            absCents // 100

        remainder =
            absCents |> modBy 100
    in
    sign ++ "$" ++ groupThousands dollars ++ "." ++ String.padLeft 2 '0' (String.fromInt remainder)


{-| Insert thousands separators into a non-negative integer's digits.
-}
groupThousands : Int -> String
groupThousands n =
    let
        chunk acc rest =
            if String.length rest <= 3 then
                rest :: acc

            else
                chunk (String.right 3 rest :: acc) (String.dropRight 3 rest)
    in
    chunk [] (String.fromInt n) |> String.join ","


pageSize : Int
pageSize =
    4


{-| Transactions whose merchant or category contains the query (case-insensitive).
-}
matchingTransactions : String -> List Transaction -> List Transaction
matchingTransactions query txns =
    let
        needle =
            String.toLower (String.trim query)
    in
    if needle == "" then
        txns

    else
        List.filter
            (\t ->
                String.contains needle (String.toLower t.merchant)
                    || String.contains needle (String.toLower t.category)
            )
            txns


monthFromString : String -> Maybe Month
monthFromString s =
    case s of
        "january" ->
            Just January

        "february" ->
            Just February

        "march" ->
            Just March

        _ ->
            Nothing



-- SAMPLE DATA ------------------------------------------------------------


accountGroups : List AccountGroup
accountGroups =
    [ { id = "rally-grp-checking"
      , label = "Checking"
      , icon = "account_balance"
      , accounts =
            [ { name = "Everyday Checking", institution = "Rally Bank", cents = 482311 }
            , { name = "Joint Checking", institution = "Rally Bank", cents = 213890 }
            ]
      }
    , { id = "rally-grp-savings"
      , label = "Savings"
      , icon = "savings"
      , accounts =
            [ { name = "Emergency Fund", institution = "Rally Bank", cents = 1204500 }
            , { name = "Vacation", institution = "Rally Bank", cents = 318000 }
            ]
      }
    , { id = "rally-grp-credit"
      , label = "Credit"
      , icon = "credit_card"
      , accounts =
            [ { name = "Rally Rewards Card", institution = "Rally Bank", cents = -94215 }
            , { name = "Travel Card", institution = "Rally Bank", cents = -31200 }
            ]
      }
    ]


transactions : List Transaction
transactions =
    [ { merchant = "Whole Foods Market", category = "Groceries", dateLabel = "Mar 18", cents = -8432 }
    , { merchant = "Shell", category = "Transport", dateLabel = "Mar 17", cents = -5210 }
    , { merchant = "Payroll Deposit", category = "Income", dateLabel = "Mar 15", cents = 428900 }
    , { merchant = "Netflix", category = "Entertainment", dateLabel = "Mar 14", cents = -1599 }
    , { merchant = "Trader Joe's", category = "Groceries", dateLabel = "Mar 13", cents = -6218 }
    , { merchant = "Uber", category = "Transport", dateLabel = "Mar 12", cents = -2340 }
    , { merchant = "Spotify", category = "Entertainment", dateLabel = "Mar 11", cents = -1099 }
    , { merchant = "Electric Co.", category = "Utilities", dateLabel = "Mar 10", cents = -11240 }
    , { merchant = "Costco", category = "Groceries", dateLabel = "Mar 09", cents = -15877 }
    , { merchant = "Lyft", category = "Transport", dateLabel = "Mar 08", cents = -1820 }
    ]


bills : List Bill
bills =
    [ { payee = "Rent", dueLabel = "Apr 1", cents = -185000, autopay = True }
    , { payee = "Electric Co.", dueLabel = "Apr 4", cents = -11240, autopay = True }
    , { payee = "Internet", dueLabel = "Apr 7", cents = -7999, autopay = False }
    , { payee = "Phone", dueLabel = "Apr 12", cents = -6500, autopay = True }
    , { payee = "Gym", dueLabel = "Apr 15", cents = -3500, autopay = False }
    ]


budgetCategories : List BudgetCategory
budgetCategories =
    [ { id = "rally-bud-groceries"
      , label = "Groceries"
      , icon = "shopping_cart"
      , spentCents = 30527
      , budgetCents = 50000
      , lines = [ ( "Whole Foods Market", 8432 ), ( "Trader Joe's", 6218 ), ( "Costco", 15877 ) ]
      }
    , { id = "rally-bud-transport"
      , label = "Transport"
      , icon = "directions_car"
      , spentCents = 9370
      , budgetCents = 12000
      , lines = [ ( "Shell", 5210 ), ( "Uber", 2340 ), ( "Lyft", 1820 ) ]
      }
    , { id = "rally-bud-entertainment"
      , label = "Entertainment"
      , icon = "movie"
      , spentCents = 4297
      , budgetCents = 4000
      , lines = [ ( "Netflix", 1599 ), ( "Spotify", 1099 ), ( "Theatre", 1599 ) ]
      }
    , { id = "rally-bud-utilities"
      , label = "Utilities"
      , icon = "bolt"
      , spentCents = 11240
      , budgetCents = 20000
      , lines = [ ( "Electric Co.", 11240 ) ]
      }
    ]



-- VIEW -------------------------------------------------------------------


view : App Data ActionData RouteParams -> Shared.Model -> Model -> View (PagesMsg Msg)
view _ _ model =
    { title = "Rally · Studies · elm-m3e"
    , body =
        [ Theme.view
            { content =
                [ Element.fromNode
                    (Node.element "div" [ Node.rawAttr (class "overflow-hidden rounded-md-corner-large bg-surface text-on-surface") ]
                        [ Node.map PagesMsg.fromMsg (dashboard model) ]
                    )
                ]
            }
            [ Theme.scheme Theme.Dark
            , Theme.variant Theme.Expressive
            , Theme.seedColor "#1EB980"
            , Theme.motion Theme.MotionExpressive
            ]
            |> Element.toNode
        ]
    }


dashboard : Model -> Node Msg
dashboard model =
    -- Below `md`, the `M3e.Tabs` row is the primary navigation, so the rail
    -- (which duplicates it) is hidden — that frees the full viewport width
    -- for the cards, transactions list, and Paginator on phones.
    Node.element "div" [ Node.rawAttr (class "flex min-h-[40rem]") ]
        [ Node.element "div" [ Node.rawAttr (class "hidden md:flex") ]
            [ rail model
            , Divider.view [ Divider.vertical True ] |> Element.toNode
            ]
        , Node.element "div" [ Node.rawAttr (class "flex min-w-0 flex-1 flex-col") ]
            [ appBar model
            , Node.element "div" [ Node.rawAttr (class "border-b border-outline-variant px-2 pt-2 sm:px-4") ]
                [ tabsBar model ]
            , ScrollContainer.view
                { content = [ Element.fromNode (Node.element "div" [ Node.rawAttr (class "p-3 sm:p-6") ] [ tabPanel model ]) ] }
                [ ScrollContainer.thin True
                , ScrollContainer.dividers ScrollContainer.None
                ]
                |> Element.toNode
            , snackbarSlot model
            ]
        ]


rail : Model -> Node Msg
rail model =
    Node.element "div" [ Node.rawAttr (class "shrink-0") ]
        [ NavigationRail.view
            { items =
                [ NavigationRail.item { icon = Icon.view { name = "account_balance_wallet" }, label = "Accounts" }
                    [ NavigationRail.itemSelected (model.tab == Accounts)
                    , NavigationRail.itemOnClick (TabSelected Accounts)
                    ]
                , NavigationRail.item { icon = Icon.view { name = "receipt_long" }, label = "Bills" }
                    [ NavigationRail.itemSelected (model.tab == Bills)
                    , NavigationRail.itemOnClick (TabSelected Bills)
                    , NavigationRail.itemBadge (String.fromInt (List.length bills))
                    ]
                , NavigationRail.item { icon = Icon.view { name = "donut_small" }, label = "Budgets" }
                    [ NavigationRail.itemSelected (model.tab == Budgets)
                    , NavigationRail.itemOnClick (TabSelected Budgets)
                    ]
                ]
            }
            []
            |> Element.toNode
        ]


appBar : Model -> Node Msg
appBar model =
    AppBar.view
        [ AppBar.title (Heading.view { label = "Rally", variant = Heading.Title } [])
        , AppBar.leading
            (Element.element { tag = "span" }
                [ Node.rawAttr (Attr.class "px-2 text-primary") ]
                [ Element.toNode (Icon.view { name = "savings" }) ]
            )
        , AppBar.trailing
            [ Element.element { tag = "div" } [] [ monthSelect model ]
            , Element.element { tag = "div" } [] [ refreshButton model ]
            ]
        ]
        |> Element.toNode


monthSelect : Model -> Node Msg
monthSelect model =
    Node.element "div" [ Node.rawAttr (class "min-w-[9rem]") ]
        [ Select.view { label = "Month" }
            [ Select.id "rally-month"
            , Select.options
                [ Select.option { value = "january", label = "January" }
                    [ Select.optionSelected (model.month == January) ]
                , Select.option { value = "february", label = "February" }
                    [ Select.optionSelected (model.month == February) ]
                , Select.option { value = "march", label = "March" }
                    [ Select.optionSelected (model.month == March) ]
                ]
            , Select.onChange
                (\s -> MonthSelected (monthFromString s |> Maybe.withDefault model.month))
            ]
            |> Element.toNode
        ]


refreshButton : Model -> Node Msg
refreshButton model =
    Node.element "div" [ Node.rawAttr (class "flex items-center gap-1 pr-1") ]
        [ if model.syncing then
            Node.element "span" [ Node.rawAttr (class "text-primary"), Node.rawAttr (Attr.attribute "aria-label" "Syncing") ]
                [ LoadingIndicator.view [ LoadingIndicator.variant LoadingIndicator.Uncontained ]
                    |> Element.toNode
                ]

          else
            Node.text ""
        , Node.element "span" [ Node.rawAttr (Attr.id "rally-refresh-anchor") ]
            [ IconButton.view
                { icon = "sync"
                , name =
                    if model.syncing then
                        "Stop sync"

                    else
                        "Sync accounts"
                }
                [ IconButton.onClick RefreshClicked ]
                |> Element.toNode
            ]
        , Tooltip.plain
            { anchorId = "rally-refresh-anchor"
            , label = "Refresh balances"
            }
            [ Tooltip.plainPosition Tooltip.PlainBelow ]
            |> Element.toNode
        ]


tabsBar : Model -> Node Msg
tabsBar model =
    Tabs.view
        { tabs =
            [ Tabs.tab { label = "Accounts" }
                [ Tabs.tabSelected (model.tab == Accounts)
                , Tabs.tabOnClick (TabSelected Accounts)
                ]
            , Tabs.tab { label = "Bills" }
                [ Tabs.tabSelected (model.tab == Bills)
                , Tabs.tabOnClick (TabSelected Bills)
                ]
            , Tabs.tab { label = "Budgets" }
                [ Tabs.tabSelected (model.tab == Budgets)
                , Tabs.tabOnClick (TabSelected Budgets)
                ]
            ]
        , panels = []
        }
        []
        |> Element.toNode


tabPanel : Model -> Node Msg
tabPanel model =
    case model.tab of
        Accounts ->
            accountsPanel model

        Bills ->
            billsPanel

        Budgets ->
            budgetsPanel model



-- ACCOUNTS PANEL ---------------------------------------------------------


accountsPanel : Model -> Node Msg
accountsPanel model =
    Node.element "div" [ Node.rawAttr (class "space-y-6") ]
        [ sectionHeading "Accounts" "Balances across your linked institutions."
        , Disclosure.view
            { sections = List.indexedMap accountSection accountGroups }
            []
            |> Element.toNode
        , Divider.view [] |> Element.toNode
        , transactionsSection model
        ]


accountSection : Int -> AccountGroup -> Element { section : Supported } Msg
accountSection index group =
    Disclosure.section
        { header = group.label ++ " · " ++ formatMoney (groupTotalCents group)
        , content =
            [ List_.view { items = List.map accountRow group.accounts } [] ]
        }
        [ Disclosure.sectionOpen (index == 0) ]


accountRow : Account -> Element { listItem : Supported } Msg
accountRow account =
    List_.item { headline = account.name }
        [ List_.staticOverline account.institution
        , List_.staticSupporting (formatMoney account.cents)
        , List_.staticLeading
            (Element.element { tag = "span" }
                []
                [ Element.toNode (Icon.view { name = "account_circle" }) ]
            )
        ]


transactionsSection : Model -> Node Msg
transactionsSection model =
    let
        matches =
            matchingTransactions model.query transactions

        paged =
            matches
                |> List.drop (model.page * pageSize)
                |> List.take pageSize
    in
    Node.element "div" [ Node.rawAttr (class "space-y-4") ]
        [ Node.element "div" [ Node.rawAttr (class "flex flex-wrap items-center justify-between gap-3") ]
            [ Node.raw (span [ class "text-title-md font-medium" ] [ text "Recent transactions" ])
            , Node.element "div" [ Node.rawAttr (class "w-full min-w-0 flex-1 sm:w-auto sm:min-w-[16rem] sm:max-w-sm") ]
                [ Search.view { placeholder = "Filter by merchant or category" }
                    [ Search.value model.query
                    , Search.onInput QueryChanged
                    , Search.clearable True
                    ]
                    |> Element.toNode
                ]
            ]
        , if List.isEmpty matches then
            Node.raw (div [ class "rounded-md-corner-medium bg-surface-container px-4 py-8 text-center text-body-md text-on-surface-variant" ]
                [ text ("No transactions match \"" ++ model.query ++ "\".") ])

          else
            Node.element "div" [ Node.rawAttr (class "space-y-3") ]
                [ Node.element "div" [ Node.rawAttr (class "overflow-hidden rounded-md-corner-medium border border-outline-variant") ]
                    (paged
                        |> List.map (transactionRow model.query)
                        |> List.intersperse (Divider.view [] |> Element.toNode)
                    )
                , Node.element "div" [ Node.rawAttr (class "flex justify-end") ]
                    [ Paginator.view { length = List.length matches }
                        [ Paginator.hidePageSize True
                        , Paginator.pageIndex model.page
                        , Paginator.onPage PageChanged
                        ]
                        |> Element.toNode
                    ]
                ]
        ]


{-| A transaction row. The merchant name is wrapped in `M3e.TextHighlight`
so the active filter term is marked inside the matched text.
-}
transactionRow : String -> Transaction -> Node Msg
transactionRow query txn =
    Node.element "div" [ Node.rawAttr (class "flex items-center gap-3 bg-surface-container-low px-4 py-3") ]
        [ Node.element "span" [ Node.rawAttr (class "text-on-surface-variant") ]
            [ Icon.view { name = categoryIcon txn.category } |> Element.toNode ]
        , Node.element "div" [ Node.rawAttr (class "min-w-0 flex-1") ]
            [ Node.element "div" [ Node.rawAttr (class "truncate text-body-lg") ]
                [ TextHighlight.view
                    { content = [ Element.fromNode (Node.text txn.merchant) ] }
                    [ TextHighlight.term query ]
                    |> Element.toNode
                ]
            , Node.raw (span [ class "block text-body-sm text-on-surface-variant" ]
                [ text (txn.dateLabel ++ " · " ++ txn.category) ])
            ]
        , Node.raw (span
            [ class
                (if txn.cents >= 0 then
                    "shrink-0 tabular-nums text-tertiary"

                 else
                    "shrink-0 tabular-nums text-on-surface"
                )
            ]
            [ text (formatMoney txn.cents) ])
        ]


categoryIcon : String -> String
categoryIcon category =
    case category of
        "Groceries" ->
            "shopping_cart"

        "Transport" ->
            "directions_car"

        "Entertainment" ->
            "movie"

        "Utilities" ->
            "bolt"

        "Income" ->
            "payments"

        _ ->
            "receipt_long"



-- BILLS PANEL ------------------------------------------------------------


billsPanel : Node Msg
billsPanel =
    Node.element "div" [ Node.rawAttr (class "grid gap-6 lg:grid-cols-2") ]
        [ Node.element "div" [ Node.rawAttr (class "space-y-4") ]
            [ sectionHeading "Upcoming bills" "Due dates for the next billing cycle."
            , List_.view { items = List.map billRow bills } [] |> Element.toNode
            ]
        , Node.element "div" [ Node.rawAttr (class "space-y-4") ]
            [ Node.raw (span [ class "text-title-md font-medium" ] [ text "Due-date calendar" ])
            , Node.element "div" [ Node.rawAttr (class "rounded-md-corner-large bg-surface-container p-2") ]
                [ Calendar.view
                    [ Calendar.id "rally-bill-calendar"
                    , Calendar.date "2024-04-01"
                    , Calendar.minDate "2024-04-01"
                    , Calendar.maxDate "2024-04-30"
                    ]
                    |> Element.toNode
                ]
            ]
        ]


billRow : Bill -> Element { listItem : Supported } Msg
billRow bill =
    List_.item { headline = bill.payee }
        [ List_.staticOverline ("Due " ++ bill.dueLabel)
        , List_.staticSupporting
            (formatMoney bill.cents
                ++ (if bill.autopay then
                        " · Autopay on"

                    else
                        " · Manual"
                   )
            )
        , List_.staticLeading
            (Element.element { tag = "span" }
                []
                [ Element.toNode
                    (Icon.view
                        { name =
                            if bill.autopay then
                                "event_repeat"

                            else
                                "event"
                        }
                    )
                ]
            )
        ]



-- BUDGETS PANEL ----------------------------------------------------------


budgetsPanel : Model -> Node Msg
budgetsPanel model =
    Node.element "div" [ Node.rawAttr (class "space-y-6") ]
        [ sectionHeading "Budgets" "How this month's spending tracks against plan."
        , overviewCard
        , Node.element "div" [ Node.rawAttr (class "grid gap-4 sm:grid-cols-2 lg:grid-cols-3") ]
            (List.map budgetCard budgetCategories)
        , Divider.view [] |> Element.toNode
        , categoryDetail
        , Node.element "div" [ Node.rawAttr (class "flex justify-end") ]
            [ adjustButton model ]
        ]


overviewCard : Node Msg
overviewCard =
    let
        percent =
            overallPercent budgetCategories

        spent =
            totalSpent budgetCategories

        budget =
            totalBudget budgetCategories
    in
    Card.view
        [ Card.variant Card.Filled
        , Card.headline (Heading.view { label = "March overview", variant = Heading.Title } [])
        , Card.subhead
            (Heading.view
                { label = formatMoney spent ++ " of " ++ formatMoney budget ++ " spent"
                , variant = Heading.Label
                }
                []
            )
        , Card.body
            [ Element.fromNode
                (Node.element "div" [ Node.rawAttr (class "flex flex-col items-start gap-4 sm:flex-row sm:items-center sm:gap-6") ]
                    [ Node.element "div" [ Node.rawAttr (class "relative grid place-items-center self-center sm:self-auto") ]
                        [ Node.element "span" [ Node.rawAttr (Attr.style "--m3e-progress-indicator-color" "var(--md-sys-color-primary)") ]
                            [ Progress.view { shape = Progress.Circular } [ Progress.value percent ]
                                |> Element.toNode
                            ]
                        , Node.raw (span [ class "absolute text-title-lg font-medium tabular-nums" ]
                            [ text (String.fromInt percent ++ "%") ])
                        ]
                    , Node.element "div" [ Node.rawAttr (class "min-w-0 flex-1 space-y-1") ]
                        [ Node.raw (span [ class "block text-body-md text-on-surface-variant" ]
                            [ text "Remaining this month" ])
                        , Node.raw (span [ class "block text-headline-sm font-medium tabular-nums" ]
                            [ text (formatMoney (budget - spent)) ])
                        ]
                    ]
                )
            ]
        ]
        |> Element.toNode


budgetCard : BudgetCategory -> Node Msg
budgetCard category =
    let
        percent =
            budgetPercent category

        over =
            isOverBudget category
    in
    Card.view
        [ Card.variant Card.Outlined
        , Card.headline (Heading.view { label = category.label, variant = Heading.Title } [])
        , Card.subhead
            (Heading.view
                { label = formatMoney category.spentCents ++ " of " ++ formatMoney category.budgetCents
                , variant = Heading.Label
                }
                []
            )
        , Card.body
            [ Element.fromNode
                (Node.element "div" [ Node.rawAttr (class "space-y-2") ]
                    [ Node.element "div" [ Node.rawAttr (class "flex items-center gap-2") ]
                        [ Icon.view { name = category.icon } |> Element.toNode
                        , Node.raw (span [ class "ml-auto text-label-lg tabular-nums" ]
                            [ text (String.fromInt percent ++ "%") ])
                        ]
                    , Node.element "span"
                        [ Node.rawAttr (class "block")
                        , Node.rawAttr (Attr.style "--m3e-progress-indicator-color"
                            (if over then
                                "var(--md-sys-color-error)"

                             else
                                "var(--md-sys-color-primary)"
                            ))
                        ]
                        [ Progress.view { shape = Progress.Linear } [ Progress.value percent ]
                            |> Element.toNode
                        ]
                    , if over then
                        Node.raw (span [ class "block text-label-md text-error" ]
                            [ text ("Over by " ++ formatMoney (category.spentCents - category.budgetCents)) ])

                      else
                        Node.text ""
                    ]
                )
            ]
        ]
        |> Element.toNode


categoryDetail : Node Msg
categoryDetail =
    Node.element "div" [ Node.rawAttr (class "space-y-3") ]
        [ Node.raw (span [ class "text-title-md font-medium" ] [ text "Category detail" ])
        , Disclosure.view
            { sections = List.map budgetDetailSection budgetCategories }
            []
            |> Element.toNode
        ]


budgetDetailSection : BudgetCategory -> Element { section : Supported } Msg
budgetDetailSection category =
    Disclosure.section
        { header = category.label ++ " · " ++ String.fromInt (budgetPercent category) ++ "%"
        , content =
            [ List_.view { items = List.map budgetLineRow category.lines } [] ]
        }
        []


budgetLineRow : ( String, Int ) -> Element { listItem : Supported } Msg
budgetLineRow ( label, cents ) =
    List_.item { headline = label }
        [ List_.staticSupporting (formatMoney (negate cents))
        , List_.staticLeading
            (Element.element { tag = "span" }
                []
                [ Element.toNode (Icon.view { name = "subdirectory_arrow_right" }) ]
            )
        ]


adjustButton : Model -> Node Msg
adjustButton model =
    Node.element "span" [ Node.rawAttr (Attr.id "rally-adjust-anchor") ]
        [ IconButton.view
            { icon = "tune", name = "Adjust budgets" }
            [ IconButton.variant IconButton.Tonal
            , IconButton.onClick (BudgetAdjusted (monthLabel model.month))
            ]
            |> Element.toNode
        , Tooltip.plain
            { anchorId = "rally-adjust-anchor"
            , label = "Adjust this month's budgets"
            }
            [ Tooltip.plainPosition Tooltip.PlainAbove ]
            |> Element.toNode
        ]



-- SNACKBAR ---------------------------------------------------------------


snackbarSlot : Model -> Node Msg
snackbarSlot model =
    case model.snackbar of
        Nothing ->
            Node.text ""

        Just message ->
            Snackbar.view { message = message }
                [ Snackbar.id ("rally-snackbar-" ++ message)
                , Snackbar.dismissible True
                , Snackbar.duration 4000
                ]
                |> Element.toNode



-- SHARED VIEW HELPERS ----------------------------------------------------


sectionHeading : String -> String -> Node Msg
sectionHeading title subtitle =
    Node.element "div" [ Node.rawAttr (class "space-y-1") ]
        [ Heading.view { label = title, variant = Heading.Headline }
            [ Heading.size Heading.Small
            , Heading.level 2
            ]
            |> Element.toNode
        , Node.raw (span [ class "block text-body-md text-on-surface-variant" ] [ text subtitle ])
        ]


monthLabel : Month -> String
monthLabel month =
    case month of
        January ->
            "January"

        February ->
            "February"

        March ->
            "March"
