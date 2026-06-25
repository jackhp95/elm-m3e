module Route.Studies.Rally exposing (ActionData, Data, Model, Msg, route)

{-| **Rally** — a Material 3 personal-finance dashboard study.

A dark-themed money surface that composes a large slice of the elm-m3e
library the way the catalogue intends:

  - `Ui.Theme` wraps the whole surface in a dark, expressive scheme.
  - `Ui.AppBar` carries a month `Ui.Select` and a refresh `Ui.IconButton`
    that spins a `Ui.LoadingIndicator` while "syncing".
  - `Ui.NavigationRail` mirrors the active section.
  - `Ui.Tabs` switches between **Accounts / Bills / Budgets**.
  - **Accounts** groups Checking / Savings / Credit in a
    `Ui.Disclosure.accordion` with running totals, and lists recent
    transactions filtered by a `Ui.Search` bar — matches are marked with
    `Ui.TextHighlight` and paged with `Ui.Paginator`.
  - **Bills** pairs a `Ui.Calendar` of due dates with a due-soon `Ui.List`.
  - **Budgets** shows a per-category spend `Ui.Progress` ring + bars inside
    `Ui.Card`s; expanding a category reveals its line items.
  - `Ui.Tooltip`, `Ui.Divider`, `Ui.Heading`, `Ui.Icon`,
    `Ui.ScrollContainer`, and a `Ui.Snackbar` ("Budget updated") round it out.

All page interactivity is local state via `RouteBuilder.buildWithLocalState`.

-}

import BackendTask exposing (BackendTask)
import Effect exposing (Effect)
import Head
import Head.Seo as Seo
import Html exposing (Html, div, span, text)
import Html.Attributes as Attr exposing (class)
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatefulRoute)
import Shared
import Ui.AppBar as AppBar
import Ui.Calendar as Calendar
import Ui.Card as Card
import Ui.Disclosure as Disclosure
import Ui.Divider as Divider
import Ui.Heading as Heading
import Ui.Icon as Icon
import Ui.IconButton as IconButton
import Ui.List as List_
import Ui.LoadingIndicator as LoadingIndicator
import Ui.NavigationRail as NavigationRail
import Ui.Paginator as Paginator
import Ui.Progress as Progress
import Ui.ScrollContainer as ScrollContainer
import Ui.Search as Search
import Ui.Select as Select
import Ui.Snackbar as Snackbar
import Ui.Tabs as Tabs
import Ui.TextHighlight as TextHighlight
import Ui.Theme as Theme
import Ui.Tooltip as Tooltip
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
        [ Theme.new
            |> Theme.withScheme Theme.Dark
            |> Theme.withVariant Theme.Expressive
            |> Theme.withSeedColor "#1EB980"
            |> Theme.withMotion Theme.MotionExpressive
            |> Theme.view
                [ div [ class "overflow-hidden rounded-md-corner-large bg-surface text-on-surface" ]
                    [ Html.map PagesMsg.fromMsg (dashboard model) ]
                ]
        ]
    }


dashboard : Model -> Html Msg
dashboard model =
    -- Below `md`, the `Ui.Tabs` row is the primary navigation, so the rail
    -- (which duplicates it) is hidden — that frees the full viewport width
    -- for the cards, transactions list, and Paginator on phones.
    div [ class "flex min-h-[40rem]" ]
        [ div [ class "hidden md:flex" ]
            [ rail model
            , Divider.new
                |> Divider.withOrientation Divider.Vertical
                |> Divider.view
            ]
        , div [ class "flex min-w-0 flex-1 flex-col" ]
            [ appBar model
            , div [ class "border-b border-outline-variant px-2 pt-2 sm:px-4" ]
                [ tabsBar model ]
            , ScrollContainer.new
                |> ScrollContainer.withThin True
                |> ScrollContainer.withDividers ScrollContainer.None
                |> ScrollContainer.view
                    [ div [ class "p-3 sm:p-6" ] [ tabPanel model ] ]
            , snackbarSlot model
            ]
        ]


rail : Model -> Html Msg
rail model =
    div [ class "shrink-0" ]
        [ NavigationRail.new
            { items =
                [ NavigationRail.item { value = Accounts, icon = Icon.material "account_balance_wallet" }
                    |> NavigationRail.withItemLabel "Accounts"
                , NavigationRail.item { value = Bills, icon = Icon.material "receipt_long" }
                    |> NavigationRail.withItemLabel "Bills"
                    |> NavigationRail.withItemBadge (String.fromInt (List.length bills))
                , NavigationRail.item { value = Budgets, icon = Icon.material "donut_small" }
                    |> NavigationRail.withItemLabel "Budgets"
                ]
            , selected = Just model.tab
            , onChange = TabSelected
            }
            |> NavigationRail.view
        ]


appBar : Model -> Html Msg
appBar model =
    AppBar.new
        |> AppBar.withTitle (Heading.title "Rally")
        |> AppBar.withLeadingHtmlElementEscapeHatch Html.span
            [ class "px-2 text-primary" ]
            [ Icon.view (Icon.material "savings" |> Icon.withFilled True) ]
        |> AppBar.withTrailingHtmlElementEscapeHatch Html.div [] [ monthSelect model ]
        |> AppBar.withTrailingHtmlElementEscapeHatch Html.div [] [ refreshButton model ]
        |> AppBar.view


monthSelect : Model -> Html Msg
monthSelect model =
    div [ class "min-w-[9rem]" ]
        [ Select.single
            { label = "Month"
            , options =
                [ Select.option { value = January, label = "January" }
                , Select.option { value = February, label = "February" }
                , Select.option { value = March, label = "March" }
                ]
            , selected = Just model.month
            , onChange = MonthSelected
            }
            |> Select.withId "rally-month"
            |> Select.view
        ]


refreshButton : Model -> Html Msg
refreshButton model =
    div [ class "flex items-center gap-1 pr-1" ]
        [ if model.syncing then
            span [ class "text-primary", Attr.attribute "aria-label" "Syncing" ]
                [ LoadingIndicator.new
                    |> LoadingIndicator.withVariant LoadingIndicator.Uncontained
                    |> LoadingIndicator.view
                ]

          else
            text ""
        , span [ Attr.id "rally-refresh-anchor" ]
            [ IconButton.new
                { icon = Icon.material "sync"
                , label =
                    if model.syncing then
                        "Stop sync"

                    else
                        "Sync accounts"
                , variant = IconButton.Standard
                }
                |> IconButton.withOnClick RefreshClicked
                |> IconButton.view
            ]
        , Tooltip.plain
            { anchorId = "rally-refresh-anchor"
            , label = "Refresh balances"
            }
            |> Tooltip.withPosition Tooltip.Below
            |> Tooltip.view
        ]


tabsBar : Model -> Html Msg
tabsBar model =
    Tabs.new
        { tabs =
            [ Tabs.tab { value = Accounts, label = "Accounts" }
                |> Tabs.withTabIcon (Icon.material "account_balance_wallet")
            , Tabs.tab { value = Bills, label = "Bills" }
                |> Tabs.withTabIcon (Icon.material "receipt_long")
                |> Tabs.withTabBadge (String.fromInt (List.length bills))
            , Tabs.tab { value = Budgets, label = "Budgets" }
                |> Tabs.withTabIcon (Icon.material "donut_small")
            ]
        , selected = model.tab
        , onChange = TabSelected
        }
        -- Stretch fills wide viewports, but on mobile we want the tabs row
        -- to scroll horizontally rather than crush three icon+label+badge
        -- tabs into a 343 px gutter. m3e-tabs handles overflow scrolling.
        |> Tabs.view


tabPanel : Model -> Html Msg
tabPanel model =
    case model.tab of
        Accounts ->
            accountsPanel model

        Bills ->
            billsPanel

        Budgets ->
            budgetsPanel model



-- ACCOUNTS PANEL ---------------------------------------------------------


accountsPanel : Model -> Html Msg
accountsPanel model =
    div [ class "space-y-6" ]
        [ sectionHeading "Accounts" "Balances across your linked institutions."
        , Disclosure.accordion "rally-accounts"
            (List.indexedMap accountSection accountGroups)
            |> Disclosure.view
        , Divider.new |> Divider.view
        , transactionsSection model
        ]


accountSection : Int -> AccountGroup -> Disclosure.Section Msg
accountSection index group =
    Disclosure.section group.id
        (div [ class "flex w-full items-center gap-3" ]
            [ Icon.view (Icon.material group.icon)
            , span [ class "text-title-md font-medium" ] [ text group.label ]
            , span [ class "ml-auto text-title-md tabular-nums text-on-surface-variant" ]
                [ text (formatMoney (groupTotalCents group)) ]
            ]
        )
        [ List_.new (List.map accountRow group.accounts)
            |> List_.view
        ]
        -- Open the first group by default so the panel doesn't read as empty.
        |> Disclosure.withSectionOpen (index == 0)


accountRow : Account -> List_.Item Msg
accountRow account =
    List_.item account.name
        |> List_.withItemOverline account.institution
        |> List_.withItemSupporting (formatMoney account.cents)
        |> List_.withItemLeadingIcon (Icon.material "account_circle")


transactionsSection : Model -> Html Msg
transactionsSection model =
    let
        matches =
            matchingTransactions model.query transactions

        paged =
            matches
                |> List.drop (model.page * pageSize)
                |> List.take pageSize
    in
    div [ class "space-y-4" ]
        [ div [ class "flex flex-wrap items-center justify-between gap-3" ]
            [ span [ class "text-title-md font-medium" ] [ text "Recent transactions" ]
            , div [ class "w-full min-w-0 flex-1 sm:w-auto sm:min-w-[16rem] sm:max-w-sm" ]
                [ Search.bar
                    |> Search.withId "rally-txn-search"
                    |> Search.withQuery model.query QueryChanged
                    |> Search.withPlaceholder "Filter by merchant or category"
                    |> Search.withClearable True
                    |> Search.view
                ]
            ]
        , if List.isEmpty matches then
            div [ class "rounded-md-corner-medium bg-surface-container px-4 py-8 text-center text-body-md text-on-surface-variant" ]
                [ text ("No transactions match \"" ++ model.query ++ "\".") ]

          else
            div [ class "space-y-3" ]
                [ div [ class "overflow-hidden rounded-md-corner-medium border border-outline-variant" ]
                    (paged
                        |> List.map (transactionRow model.query)
                        |> List.intersperse (Divider.new |> Divider.view)
                    )
                , div [ class "flex justify-end" ]
                    [ Paginator.new
                        |> Paginator.withId "rally-txn-paginator"
                        |> Paginator.withLength (List.length matches)
                        |> Paginator.withHidePageSize True
                        |> Paginator.withExplicitPageState PageChanged model.page
                        |> Paginator.view
                    ]
                ]
        ]


{-| A transaction row. The merchant name is wrapped in `Ui.TextHighlight`
so the active filter term is marked inside the matched text.
-}
transactionRow : String -> Transaction -> Html Msg
transactionRow query txn =
    div [ class "flex items-center gap-3 bg-surface-container-low px-4 py-3" ]
        [ span [ class "text-on-surface-variant" ] [ Icon.view (categoryIcon txn.category) ]
        , div [ class "min-w-0 flex-1" ]
            [ div [ class "truncate text-body-lg" ]
                [ TextHighlight.new
                    |> TextHighlight.withTerm query
                    |> TextHighlight.view [ text txn.merchant ]
                ]
            , span [ class "block text-body-sm text-on-surface-variant" ]
                [ text (txn.dateLabel ++ " · " ++ txn.category) ]
            ]
        , span
            [ class
                (if txn.cents >= 0 then
                    "shrink-0 tabular-nums text-tertiary"

                 else
                    "shrink-0 tabular-nums text-on-surface"
                )
            ]
            [ text (formatMoney txn.cents) ]
        ]


categoryIcon : String -> Icon.Icon msg
categoryIcon category =
    Icon.material <|
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


billsPanel : Html Msg
billsPanel =
    div [ class "grid gap-6 lg:grid-cols-2" ]
        [ div [ class "space-y-4" ]
            [ sectionHeading "Upcoming bills" "Due dates for the next billing cycle."
            , List_.new (List.map billRow bills)
                |> List_.view
            ]
        , div [ class "space-y-4" ]
            [ span [ class "text-title-md font-medium" ] [ text "Due-date calendar" ]
            , div [ class "rounded-md-corner-large bg-surface-container p-2" ]
                [ Calendar.new
                    |> Calendar.withId "rally-bill-calendar"
                    |> Calendar.withDate "2024-04-01"
                    |> Calendar.withMinDate "2024-04-01"
                    |> Calendar.withMaxDate "2024-04-30"
                    |> Calendar.view
                ]
            ]
        ]


billRow : Bill -> List_.Item Msg
billRow bill =
    List_.item bill.payee
        |> List_.withItemOverline ("Due " ++ bill.dueLabel)
        |> List_.withItemSupporting
            (formatMoney bill.cents
                ++ (if bill.autopay then
                        " · Autopay on"

                    else
                        " · Manual"
                   )
            )
        |> List_.withItemLeadingIcon
            (Icon.material
                (if bill.autopay then
                    "event_repeat"

                 else
                    "event"
                )
            )



-- BUDGETS PANEL ----------------------------------------------------------


budgetsPanel : Model -> Html Msg
budgetsPanel model =
    div [ class "space-y-6" ]
        [ sectionHeading "Budgets" "How this month's spending tracks against plan."
        , overviewCard
        , div [ class "grid gap-4 sm:grid-cols-2 lg:grid-cols-3" ]
            (List.map budgetCard budgetCategories)
        , Divider.new |> Divider.view
        , categoryDetail
        , div [ class "flex justify-end" ]
            [ adjustButton model ]
        ]


overviewCard : Html Msg
overviewCard =
    let
        percent =
            overallPercent budgetCategories

        spent =
            totalSpent budgetCategories

        budget =
            totalBudget budgetCategories
    in
    Card.new Card.Filled
        |> Card.withHeadline (Heading.title "March overview")
        |> Card.withSubhead (Heading.label (formatMoney spent ++ " of " ++ formatMoney budget ++ " spent"))
        |> Card.withBody
            (div [ class "flex flex-col items-start gap-4 sm:flex-row sm:items-center sm:gap-6" ]
                [ div [ class "relative grid place-items-center self-center sm:self-auto" ]
                    [ span [ class "text-primary" ]
                        [ Progress.circular percent
                            |> Progress.withId "rally-overview-ring"
                            |> Progress.view
                        ]
                    , span [ class "absolute text-title-lg font-medium tabular-nums" ]
                        [ text (String.fromInt percent ++ "%") ]
                    ]
                , div [ class "min-w-0 flex-1 space-y-1" ]
                    [ span [ class "block text-body-md text-on-surface-variant" ]
                        [ text "Remaining this month" ]
                    , span [ class "block text-headline-sm font-medium tabular-nums" ]
                        [ text (formatMoney (budget - spent)) ]
                    ]
                ]
            )
        |> Card.view


budgetCard : BudgetCategory -> Html Msg
budgetCard category =
    let
        percent =
            budgetPercent category

        over =
            isOverBudget category
    in
    Card.new Card.Outlined
        |> Card.withHeadline (Heading.title category.label)
        |> Card.withSubhead
            (Heading.label (formatMoney category.spentCents ++ " of " ++ formatMoney category.budgetCents))
        |> Card.withBody
            (div [ class "space-y-2" ]
                [ div [ class "flex items-center gap-2" ]
                    [ Icon.view (Icon.material category.icon)
                    , span [ class "ml-auto text-label-lg tabular-nums" ]
                        [ text (String.fromInt percent ++ "%") ]
                    ]
                , span
                    [ class
                        (if over then
                            "block text-error"

                         else
                            "block text-primary"
                        )
                    ]
                    [ Progress.linear percent
                        |> Progress.withId ("rally-bar-" ++ category.id)
                        |> Progress.view
                    ]
                , if over then
                    span [ class "block text-label-md text-error" ]
                        [ text ("Over by " ++ formatMoney (category.spentCents - category.budgetCents)) ]

                  else
                    text ""
                ]
            )
        |> Card.view


categoryDetail : Html Msg
categoryDetail =
    div [ class "space-y-3" ]
        [ span [ class "text-title-md font-medium" ] [ text "Category detail" ]
        , Disclosure.accordion "rally-budget-detail"
            (List.map budgetDetailSection budgetCategories)
            |> Disclosure.view
        ]


budgetDetailSection : BudgetCategory -> Disclosure.Section Msg
budgetDetailSection category =
    Disclosure.section ("rally-detail-" ++ category.id)
        (div [ class "flex w-full items-center gap-3" ]
            [ Icon.view (Icon.material category.icon)
            , span [ class "text-title-sm font-medium" ] [ text category.label ]
            , span [ class "ml-auto text-label-lg tabular-nums text-on-surface-variant" ]
                [ text (String.fromInt (budgetPercent category) ++ "%") ]
            ]
        )
        [ List_.new (List.map budgetLineRow category.lines)
            |> List_.view
        ]


budgetLineRow : ( String, Int ) -> List_.Item Msg
budgetLineRow ( label, cents ) =
    List_.item label
        |> List_.withItemSupporting (formatMoney (negate cents))
        |> List_.withItemLeadingIcon (Icon.material "subdirectory_arrow_right")


adjustButton : Model -> Html Msg
adjustButton model =
    span [ Attr.id "rally-adjust-anchor" ]
        [ IconButton.new
            { icon = Icon.material "tune"
            , label = "Adjust budgets"
            , variant = IconButton.Tonal
            }
            |> IconButton.withOnClick (BudgetAdjusted (monthLabel model.month))
            |> IconButton.view
        , Tooltip.plain
            { anchorId = "rally-adjust-anchor"
            , label = "Adjust this month's budgets"
            }
            |> Tooltip.withPosition Tooltip.Above
            |> Tooltip.view
        ]



-- SNACKBAR ---------------------------------------------------------------


snackbarSlot : Model -> Html Msg
snackbarSlot model =
    case model.snackbar of
        Nothing ->
            text ""

        Just message ->
            Snackbar.new message
                |> Snackbar.withId ("rally-snackbar-" ++ message)
                |> Snackbar.withDismissible True
                |> Snackbar.withDuration 4000
                |> Snackbar.view



-- SHARED VIEW HELPERS ----------------------------------------------------


sectionHeading : String -> String -> Html Msg
sectionHeading title subtitle =
    div [ class "space-y-1" ]
        [ Heading.new
            |> Heading.withVariant Heading.Headline
            |> Heading.withSize Heading.Small
            |> Heading.withLevel 2
            |> Heading.withContent (text title)
            |> Heading.view
        , span [ class "block text-body-md text-on-surface-variant" ] [ text subtitle ]
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
