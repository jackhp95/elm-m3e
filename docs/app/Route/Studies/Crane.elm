module Route.Studies.Crane exposing (ActionData, Data, Model, Msg, route)

{-| Crane — an expressive Material 3 travel app, built as a composed study.

A tabbed travel browser (Fly / Sleep / Eat) with a real search form
(date/time pickers, passengers, a one-way/round-trip toggle, and a destination
search with autocomplete-style suggestions), a scrolling row of featured
destinations, a responsive grid of destination cards, a Plan-trip FAB menu, and
an itinerary bottom sheet. The whole surface is wrapped in its own expressive
"Crane purple" `<m3e-theme>` so it reads as a distinct product, not docs chrome.

This module owns local route state via `RouteBuilder.buildWithLocalState`. It is
the only file in the study — all interactivity (tab switching, trip-type toggle,
filtering, favoriting, fare search, itinerary sheet) lives here.

-}

import BackendTask exposing (BackendTask)
import Effect exposing (Effect)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (Html, div, p, section, span, text)
import Html.Attributes exposing (attribute, class)
import Html.Events
import M3e.Shape
import Pages.Url
import PagesMsg exposing (PagesMsg)
import Process
import RouteBuilder exposing (App, StatefulRoute)
import Set exposing (Set)
import Shared
import Task
import Ui.Badge as Badge
import Ui.BottomSheet as BottomSheet
import Ui.Button as Button
import Ui.Card as Card
import Ui.DatePicker as DatePicker
import Ui.Divider as Divider
import Ui.FabMenu as FabMenu
import Ui.Heading as Heading
import Ui.Icon as Icon
import Ui.IconButton as IconButton
import Ui.LoadingIndicator as LoadingIndicator
import Ui.SegmentedButton as SegmentedButton
import Ui.Select as Select
import Ui.Shape as Shape
import Ui.Tabs as Tabs
import Ui.Theme as Theme
import Ui.TimePicker as TimePicker
import Ui.Tooltip as Tooltip
import UrlPath
import View exposing (View)



-- DOMAIN


{-| The three product categories Crane organizes travel around.
-}
type Category
    = Fly
    | Sleep
    | Eat


categoryLabel : Category -> String
categoryLabel cat =
    case cat of
        Fly ->
            "Fly"

        Sleep ->
            "Sleep"

        Eat ->
            "Eat"


categoryIcon : Category -> String
categoryIcon cat =
    case cat of
        Fly ->
            "flight"

        Sleep ->
            "hotel"

        Eat ->
            "restaurant"


{-| Whether a trip is one-way or returns. Drives the return DatePicker.
-}
type TripType
    = OneWay
    | RoundTrip


{-| A bookable destination. `id` is stable for favoriting and keying.
-}
type alias Destination =
    { id : String
    , name : String
    , country : String
    , category : Category
    , rating : String
    , price : String
    , blurb : String
    , shape : Shape.Name
    , featured : Bool
    }


destinations : List Destination
destinations =
    [ { id = "den-pasar", name = "Denpasar", country = "Indonesia", category = Fly, rating = "4.8", price = "$680", blurb = "Direct flights to Bali's coast.", shape = M3e.Shape.Sunny, featured = True }
    , { id = "cordoba", name = "Córdoba", country = "Argentina", category = Fly, rating = "4.6", price = "$540", blurb = "Andean foothills and old-town plazas.", shape = M3e.Shape.Boom, featured = True }
    , { id = "khumbu", name = "Khumbu Valley", country = "Nepal", category = Fly, rating = "4.9", price = "$1,120", blurb = "Gateway to the high Himalaya.", shape = M3e.Shape.Pentagon, featured = True }
    , { id = "mali", name = "Mali", country = "West Africa", category = Fly, rating = "4.5", price = "$870", blurb = "Saharan trade routes and river towns.", shape = M3e.Shape.Diamond, featured = False }
    , { id = "ushuaia-lodge", name = "Ushuaia Lodge", country = "Argentina", category = Sleep, rating = "4.7", price = "$210/nt", blurb = "End-of-the-world cabins by the Beagle Channel.", shape = M3e.Shape.SoftBurst, featured = True }
    , { id = "kyoto-ryokan", name = "Kyoto Ryokan", country = "Japan", category = Sleep, rating = "4.9", price = "$340/nt", blurb = "Tatami rooms and a private onsen.", shape = M3e.Shape.Flower, featured = False }
    , { id = "tulum-bungalow", name = "Tulum Bungalow", country = "Mexico", category = Sleep, rating = "4.4", price = "$185/nt", blurb = "Palapa roofs steps from the reef.", shape = M3e.Shape.Semicircle, featured = False }
    , { id = "san-sebastian", name = "San Sebastián", country = "Spain", category = Eat, rating = "4.9", price = "Pintxos", blurb = "The world's densest cluster of stars.", shape = M3e.Shape.Burst, featured = True }
    , { id = "oaxaca", name = "Oaxaca", country = "Mexico", category = Eat, rating = "4.8", price = "Mole", blurb = "Seven moles and mezcal at dusk.", shape = M3e.Shape.Puffy, featured = False }
    , { id = "lyon", name = "Lyon", country = "France", category = Eat, rating = "4.7", price = "Bouchon", blurb = "Bouchons and the bistro tradition.", shape = M3e.Shape.Gem, featured = False }
    ]


{-| Pure filter: destinations matching the active category and a free-text
query over name and country. Case-insensitive; an empty query matches all.
-}
filterDestinations : Category -> String -> List Destination -> List Destination
filterDestinations cat query items =
    let
        needle =
            String.trim (String.toLower query)

        matchesQuery d =
            needle
                == ""
                || String.contains needle (String.toLower d.name)
                || String.contains needle (String.toLower d.country)
    in
    items
        |> List.filter (\d -> d.category == cat && matchesQuery d)


{-| Autocomplete-style suggestions: up to five name/country hits for the query,
across all categories. Empty query yields no suggestions (closed panel).
-}
suggestions : String -> List Destination -> List Destination
suggestions query items =
    let
        needle =
            String.trim (String.toLower query)
    in
    if needle == "" then
        []

    else
        items
            |> List.filter
                (\d ->
                    String.contains needle (String.toLower d.name)
                        || String.contains needle (String.toLower d.country)
                )
            |> List.take 5



-- MODEL


type alias Model =
    { category : Category
    , tripType : TripType
    , depart : String
    , return : String
    , time : String
    , passengers : Int
    , query : String
    , suggestionsOpen : Bool
    , searching : Bool
    , favorites : Set String
    , itineraryFor : Maybe String
    }


type Msg
    = SelectCategory Category
    | SetTripType TripType
    | SetDepart String
    | SetReturn String
    | SetTime String
    | SetPassengers Int
    | SetQuery String
    | SearchFares
    | FaresReady
    | ToggleFavorite String Bool
    | OpenItinerary String
    | CloseItinerary
    | PlanTrip Category


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
            { init = init
            , update = update
            , subscriptions = \_ _ _ _ -> Sub.none
            , view = view
            }


init : App Data ActionData RouteParams -> Shared.Model -> ( Model, Effect Msg )
init _ _ =
    ( { category = Fly
      , tripType = RoundTrip
      , depart = "2026-07-14"
      , return = "2026-07-28"
      , time = "09:30"
      , passengers = 1
      , query = ""
      , suggestionsOpen = False
      , searching = False
      , favorites = Set.fromList [ "khumbu" ]
      , itineraryFor = Nothing
      }
    , Effect.none
    )


update : App Data ActionData RouteParams -> Shared.Model -> Msg -> Model -> ( Model, Effect Msg )
update _ _ msg model =
    case msg of
        SelectCategory cat ->
            ( { model | category = cat, itineraryFor = Nothing }, Effect.none )

        SetTripType t ->
            ( { model | tripType = t }, Effect.none )

        SetDepart d ->
            ( { model | depart = d }, Effect.none )

        SetReturn d ->
            ( { model | return = d }, Effect.none )

        SetTime t ->
            ( { model | time = t }, Effect.none )

        SetPassengers n ->
            ( { model | passengers = n }, Effect.none )

        SetQuery q ->
            ( { model | query = q, suggestionsOpen = String.trim q /= "" }, Effect.none )

        SearchFares ->
            ( { model | searching = True, suggestionsOpen = False }
            , Effect.fromCmd (Task.perform (\() -> FaresReady) (Process.sleep 900))
            )

        FaresReady ->
            ( { model | searching = False }, Effect.none )

        ToggleFavorite id favorited ->
            ( { model
                | favorites =
                    if favorited then
                        Set.insert id model.favorites

                    else
                        Set.remove id model.favorites
              }
            , Effect.none
            )

        OpenItinerary id ->
            ( { model | itineraryFor = Just id }, Effect.none )

        CloseItinerary ->
            ( { model | itineraryFor = Nothing }, Effect.none )

        PlanTrip cat ->
            ( { model | category = cat, itineraryFor = Nothing }, Effect.none )


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-m3e"
        , image = { url = [ "favicon.ico" ] |> UrlPath.join |> Pages.Url.fromPath, alt = "elm-m3e", dimensions = Nothing, mimeType = Nothing }
        , description = "Crane — an expressive Material 3 travel app built with elm-m3e."
        , locale = Nothing
        , title = "Crane · Studies · elm-m3e"
        }
        |> Seo.website



-- VIEW


view : App Data ActionData RouteParams -> Shared.Model -> Model -> View (PagesMsg Msg)
view _ _ model =
    { title = "Crane · Studies · elm-m3e"
    , body =
        [ Html.map PagesMsg.fromMsg (page model) ]
    }


page : Model -> Html Msg
page model =
    div [ class "mx-auto max-w-5xl space-y-6 px-4 py-6 sm:px-6 sm:py-8" ]
        [ intro
        , craneApp model
        ]


intro : Html Msg
intro =
    section [ class "space-y-3" ]
        [ p [ class "text-label-large uppercase tracking-wide text-primary" ] [ text "Studies" ]
        , Heading.new
            |> Heading.withVariant Heading.Display
            |> Heading.withSize Heading.Small
            |> Heading.withLevel 1
            |> Heading.withContent (text "Crane")
            |> Heading.view
        , p [ class "max-w-2xl text-body-large text-on-surface-variant" ]
            [ text "An expressive travel app: switch between Fly, Sleep, and Eat, set your trip, search fares, and browse a scrolling row of featured destinations — all composed from elm-m3e components under their own Crane-purple theme." ]
        ]


{-| The whole product surface, wrapped in its own expressive theme so the Crane
palette is scoped to the demo and doesn't leak into the docs chrome.
-}
craneApp : Model -> Html Msg
craneApp model =
    Theme.new
        |> Theme.withSeedColor "#5D3FD3"
        |> Theme.withVariant Theme.Expressive
        |> Theme.withMotion Theme.MotionExpressive
        |> Theme.view
            [ div [ class "overflow-hidden rounded-md-corner-large border border-outline-variant bg-surface" ]
                [ appHeader model
                , div [ class "space-y-6 p-4 sm:space-y-8 sm:p-6" ]
                    [ searchForm model
                    , featuredCarousel model
                    , resultsSection model
                    ]
                , itinerarySheet model
                ]
            ]


appHeader : Model -> Html Msg
appHeader model =
    div [ class "flex flex-col gap-3 bg-surface-container-low p-4 sm:gap-4 sm:p-6" ]
        [ div [ class "flex flex-wrap items-center justify-between gap-3" ]
            [ div [ class "flex min-w-0 items-center gap-2" ]
                [ Shape.new
                    |> Shape.withName M3e.Shape.Sunny
                    |> Shape.withClass "size-8 shrink-0 bg-primary text-on-primary grid place-items-center"
                    |> Shape.withContent [ Icon.view (Icon.material "explore") ]
                    |> Shape.view
                , Heading.new
                    |> Heading.withVariant Heading.Title
                    |> Heading.withSize Heading.Large
                    |> Heading.withLevel 2
                    |> Heading.withContent (text "Crane")
                    |> Heading.view
                ]
            , planTripMenu model
            ]
        , div [ class "-mx-4 overflow-x-auto px-4 sm:mx-0 sm:px-0" ]
            [ categoryTabs model ]
        ]


categoryTabs : Model -> Html Msg
categoryTabs model =
    let
        toTab cat =
            Tabs.tab { value = cat, label = categoryLabel cat }
                |> Tabs.withTabIcon (Icon.material (categoryIcon cat))
    in
    Tabs.new
        { tabs = List.map toTab [ Fly, Sleep, Eat ]
        , selected = model.category
        , onChange = SelectCategory
        }
        |> Tabs.withId "crane-tabs"
        |> Tabs.withStretch True
        |> Tabs.view


planTripMenu : Model -> Html Msg
planTripMenu _ =
    FabMenu.new
        { triggerIcon = Icon.material "add"
        , triggerLabel = "Plan trip"
        , variant = FabMenu.Primary
        , items =
            [ FabMenu.item { icon = Icon.material "flight", label = "Flights", onClick = PlanTrip Fly }
            , FabMenu.item { icon = Icon.material "hotel", label = "Hotels", onClick = PlanTrip Sleep }
            , FabMenu.item { icon = Icon.material "restaurant", label = "Restaurants", onClick = PlanTrip Eat }
            ]
        }
        |> FabMenu.withId "crane-plan-trip"
        |> FabMenu.view



-- SEARCH FORM


searchForm : Model -> Html Msg
searchForm model =
    section [ class "space-y-4 rounded-md-corner-large bg-surface-container-lowest p-4 sm:p-5" ]
        [ div [ class "flex flex-wrap items-center justify-between gap-3" ]
            [ Heading.new
                |> Heading.withVariant Heading.Title
                |> Heading.withSize Heading.Medium
                |> Heading.withLevel 3
                |> Heading.withContent (text "Find your trip")
                |> Heading.view
            , div [ class "-mx-1 overflow-x-auto px-1" ]
                [ tripTypeToggle model ]
            ]
        , div [ class "grid gap-4 sm:grid-cols-2 lg:grid-cols-4" ]
            [ destinationField model
            , passengersField model
            , departField model
            , returnOrTimeField model
            ]
        , div [ class "flex flex-wrap items-center gap-3" ]
            [ searchButton model
            , if model.searching then
                searchingIndicator

              else
                text ""
            ]
        ]


tripTypeToggle : Model -> Html Msg
tripTypeToggle model =
    SegmentedButton.single
        { label = "Trip type"
        , segments =
            [ SegmentedButton.segment { value = RoundTrip, label = "Round-trip" }
            , SegmentedButton.segment { value = OneWay, label = "One-way" }
            ]
        , selected = Just model.tripType
        , onChange = SetTripType
        }
        |> SegmentedButton.withId "crane-trip-type"
        |> SegmentedButton.view


destinationField : Model -> Html Msg
destinationField model =
    let
        hits =
            suggestions model.query destinations

        suggestionRow d =
            Html.button
                [ class "flex w-full items-center gap-3 px-3 py-2 text-left hover:bg-surface-container-high"
                , attribute "type" "button"
                , Html.Events.onClick (SetQuery d.name)
                ]
                [ Icon.view (Icon.material (categoryIcon d.category))
                , span [ class "flex flex-col" ]
                    [ span [ class "text-body-medium text-on-surface" ] [ text d.name ]
                    , span [ class "text-body-small text-on-surface-variant" ] [ text d.country ]
                    ]
                ]
    in
    div [ class "relative flex min-w-0 flex-col gap-1.5" ]
        [ span [ class "text-label-medium text-on-surface-variant" ] [ text "Where to" ]
        , div [ class "flex min-h-12 items-center gap-2 rounded-md-corner-full bg-surface-container px-3 py-2.5" ]
            [ Icon.view (Icon.material "search")
            , Html.input
                [ class "min-w-0 flex-1 bg-transparent text-body-large text-on-surface outline-none placeholder:text-on-surface-variant"
                , attribute "placeholder" "Search destinations"
                , Html.Attributes.value model.query
                , attribute "aria-label" "Search destinations"
                , Html.Events.onInput SetQuery
                ]
                []
            , if model.query /= "" then
                IconButton.new
                    { icon = Icon.material "close"
                    , label = "Clear search"
                    , variant = IconButton.Standard
                    }
                    |> IconButton.withSize IconButton.ExtraSmall
                    |> IconButton.withOnClick (SetQuery "")
                    |> IconButton.view

              else
                text ""
            ]
        , if model.suggestionsOpen && not (List.isEmpty hits) then
            div
                [ class "absolute left-0 right-0 top-full z-10 mt-1 overflow-hidden rounded-md-corner-medium border border-outline-variant bg-surface-container shadow-lg"
                , attribute "role" "listbox"
                ]
                (List.map suggestionRow hits)

          else
            text ""
        ]


passengersField : Model -> Html Msg
passengersField model =
    Select.single
        { label = "Passengers"
        , options =
            List.map
                (\n ->
                    Select.option
                        { value = n
                        , label =
                            String.fromInt n
                                ++ (if n == 1 then
                                        " traveler"

                                    else
                                        " travelers"
                                   )
                        }
                )
                [ 1, 2, 3, 4, 5, 6 ]
        , selected = Just model.passengers
        , onChange = SetPassengers
        }
        |> Select.withId "crane-passengers"
        |> Select.view


departField : Model -> Html Msg
departField model =
    div [ class "flex min-w-0 flex-col gap-1.5" ]
        [ span [ class "text-label-medium text-on-surface-variant" ] [ text "Depart" ]
        , dateTrigger
            { targetId = "crane-depart"
            , label = "Depart"
            , value = model.depart
            , icon = "flight_takeoff"
            }
        , DatePicker.new SetDepart
            |> DatePicker.withId "crane-depart"
            |> DatePicker.withLabel "Depart"
            |> DatePicker.withClearable False
            |> DatePicker.view
        ]


returnOrTimeField : Model -> Html Msg
returnOrTimeField model =
    case model.tripType of
        RoundTrip ->
            div [ class "flex min-w-0 flex-col gap-1.5" ]
                [ span [ class "text-label-medium text-on-surface-variant" ] [ text "Return" ]
                , dateTrigger
                    { targetId = "crane-return"
                    , label = "Return"
                    , value = model.return
                    , icon = "event"
                    }
                , DatePicker.new SetReturn
                    |> DatePicker.withId "crane-return"
                    |> DatePicker.withLabel "Return"
                    |> DatePicker.withMin model.depart
                    |> DatePicker.withClearable True
                    |> DatePicker.view
                ]

        OneWay ->
            div [ class "flex min-w-0 flex-col gap-1.5" ]
                [ span [ class "text-label-medium text-on-surface-variant" ] [ text "Departure time" ]
                , TimePicker.new
                    { label = "Preferred departure time"
                    , value = model.time
                    , onChange = SetTime
                    }
                    |> TimePicker.withId "crane-time"
                    |> TimePicker.withStep 300
                    |> TimePicker.view
                ]


{-| A visible, tappable trigger that opens the linked `m3e-datepicker` popover.

The DatePicker primitive in this codebase renders the picker as a popover-only
element that has no in-flow size of its own; on narrow viewports the field
would otherwise look empty. This button gives the user a visible 48px-tall
target that displays the current ISO value and opens the picker using the
standard HTML popover invoker pattern (`popovertarget`).

-}
dateTrigger : { targetId : String, label : String, value : String, icon : String } -> Html Msg
dateTrigger { targetId, label, value, icon } =
    Html.button
        [ class "flex min-h-12 w-full items-center gap-2 rounded-md-corner-medium border border-outline-variant bg-surface-container px-3 py-2 text-left text-body-large text-on-surface hover:bg-surface-container-high"
        , attribute "type" "button"
        , attribute "popovertarget" targetId
        , attribute "aria-label" (label ++ " " ++ value)
        ]
        [ Icon.view (Icon.material icon)
        , span [ class "min-w-0 flex-1 truncate" ] [ text value ]
        , Icon.view (Icon.material "expand_more")
        ]


searchButton : Model -> Html Msg
searchButton model =
    Button.new { label = "Search fares", variant = Button.Filled }
        |> Button.withSize Button.Large
        |> Button.withLeadingIcon (Icon.material "travel_explore")
        |> Button.withDisabled
            (if model.searching then
                Button.Disabled

             else
                Button.Enabled
            )
        |> Button.withOnClick SearchFares
        |> Button.view


searchingIndicator : Html Msg
searchingIndicator =
    div [ class "flex items-center gap-2 text-body-medium text-on-surface-variant" ]
        [ span [ class "inline-block size-6" ]
            [ LoadingIndicator.new
                |> LoadingIndicator.withVariant LoadingIndicator.Uncontained
                |> LoadingIndicator.view
            ]
        , text "Searching fares…"
        ]



-- FEATURED CAROUSEL


featuredCarousel : Model -> Html Msg
featuredCarousel model =
    let
        featured =
            List.filter .featured destinations
    in
    section [ class "space-y-3" ]
        [ Heading.new
            |> Heading.withVariant Heading.Title
            |> Heading.withSize Heading.Medium
            |> Heading.withLevel 3
            |> Heading.withContent (text "Featured destinations")
            |> Heading.view
        , div [ class "-mx-4 flex snap-x snap-mandatory gap-3 overflow-x-auto px-4 pb-2 sm:mx-0 sm:gap-4 sm:px-0", attribute "aria-label" "Featured destinations carousel" ]
            (List.map (featuredSlide model) featured)
        ]


featuredSlide : Model -> Destination -> Html Msg
featuredSlide model d =
    let
        favorited =
            Set.member d.id model.favorites
    in
    div [ class "relative flex h-44 w-56 shrink-0 snap-start flex-col justify-end overflow-hidden rounded-md-corner-large bg-primary-container p-4 text-on-primary-container sm:w-64" ]
        [ div [ class "absolute -right-6 -top-6 opacity-60" ]
            [ Shape.new
                |> Shape.withName d.shape
                |> Shape.withClass "size-28 bg-primary/30"
                |> Shape.view
            ]
        , div [ class "absolute right-2 top-2" ] [ favoriteButton d favorited ]
        , span [ class "relative text-label-medium uppercase tracking-wide" ] [ text d.country ]
        , span [ class "relative text-title-large font-medium" ] [ text d.name ]
        , span [ class "relative text-body-small" ] [ text (d.price ++ " · ★ " ++ d.rating) ]
        ]



-- RESULTS


resultsSection : Model -> Html Msg
resultsSection model =
    let
        results =
            filterDestinations model.category model.query destinations
    in
    section [ class "space-y-4" ]
        [ div [ class "flex items-center justify-between gap-3" ]
            [ Heading.new
                |> Heading.withVariant Heading.Title
                |> Heading.withSize Heading.Medium
                |> Heading.withLevel 3
                |> Heading.withContent (text (categoryLabel model.category ++ " — " ++ String.fromInt (List.length results) ++ " places"))
                |> Heading.view
            ]
        , Divider.new |> Divider.view
        , if List.isEmpty results then
            emptyState model

          else
            div [ class "grid gap-4 sm:grid-cols-2 lg:grid-cols-3" ]
                (List.map (destinationCard model) results)
        ]


emptyState : Model -> Html Msg
emptyState model =
    div [ class "grid place-items-center rounded-md-corner-large border border-dashed border-outline-variant p-10 text-center" ]
        [ div [ class "space-y-2" ]
            [ Icon.view (Icon.material "search_off")
            , p [ class "text-body-medium text-on-surface-variant" ]
                [ text ("No " ++ categoryLabel model.category ++ " results for “" ++ model.query ++ "”.") ]
            , Button.new { label = "Clear search", variant = Button.Text }
                |> Button.withOnClick (SetQuery "")
                |> Button.view
            ]
        ]


destinationCard : Model -> Destination -> Html Msg
destinationCard model d =
    let
        favorited =
            Set.member d.id model.favorites

        media =
            div [ class "relative grid h-32 place-items-center bg-secondary-container" ]
                [ Shape.new
                    |> Shape.withName d.shape
                    |> Shape.withClass "size-20 bg-primary text-on-primary grid place-items-center"
                    |> Shape.withContent [ Icon.view (Icon.material (categoryIcon d.category)) ]
                    |> Shape.view
                , div [ class "absolute left-2 top-2 flex items-center gap-1" ]
                    [ span [ attribute "id" (badgeAnchor d), class "rounded-md-corner-full bg-surface px-2 py-0.5 text-label-small text-on-surface" ]
                        [ text ("★ " ++ d.rating) ]
                    , Badge.label "Top rated"
                        |> Badge.withFor (badgeAnchor d)
                        |> Badge.view
                    ]
                , div [ class "absolute right-2 top-2" ] [ favoriteButton d favorited ]
                ]
    in
    Card.new Card.Elevated
        |> Card.withMedia media
        |> Card.withHeadline (Heading.title d.name)
        |> Card.withSubhead (Heading.label (d.country ++ " · " ++ d.price))
        |> Card.withBody (p [ class "text-body-medium text-on-surface-variant" ] [ text d.blurb ])
        |> Card.withActions
            [ Button.new { label = "Itinerary", variant = Button.Text }
                |> Button.withOnClick (OpenItinerary d.id)
            , Button.new { label = "Select", variant = Button.Filled }
                |> Button.withOnClick (OpenItinerary d.id)
            ]
        |> Card.view


badgeAnchor : Destination -> String
badgeAnchor d =
    "crane-rating-" ++ d.id


favoriteButton : Destination -> Bool -> Html Msg
favoriteButton d favorited =
    let
        anchorId =
            "crane-fav-" ++ d.id
    in
    span []
        [ span [ attribute "id" anchorId ]
            [ IconButton.new
                { icon = Icon.material "favorite_border"
                , label =
                    if favorited then
                        "Remove " ++ d.name ++ " from favorites"

                    else
                        "Add " ++ d.name ++ " to favorites"
                , variant = IconButton.Filled
                }
                |> IconButton.withSize IconButton.Small
                |> IconButton.withToggle
                    { selected = favorited
                    , onChange = ToggleFavorite d.id
                    , selectedIcon = Just (Icon.material "favorite")
                    }
                |> IconButton.view
            ]
        , Tooltip.plain { anchorId = anchorId, label = "Save to favorites" }
            |> Tooltip.view
        ]



-- ITINERARY BOTTOM SHEET


itinerarySheet : Model -> Html Msg
itinerarySheet model =
    let
        maybeDest =
            model.itineraryFor
                |> Maybe.andThen (\id -> List.head (List.filter (\d -> d.id == id) destinations))

        header dest =
            div [ class "flex items-center gap-3" ]
                [ Shape.new
                    |> Shape.withName dest.shape
                    |> Shape.withClass "size-10 bg-primary text-on-primary grid place-items-center"
                    |> Shape.withContent [ Icon.view (Icon.material (categoryIcon dest.category)) ]
                    |> Shape.view
                , div [ class "flex flex-col" ]
                    [ span [ class "text-title-large text-on-surface" ] [ text dest.name ]
                    , span [ class "text-body-medium text-on-surface-variant" ] [ text (dest.country ++ " · " ++ dest.price) ]
                    ]
                ]

        timelineRow icon title detail =
            div [ class "flex items-start gap-3 py-2" ]
                [ Icon.view (Icon.material icon)
                , div [ class "flex flex-col" ]
                    [ span [ class "text-body-large text-on-surface" ] [ text title ]
                    , span [ class "text-body-small text-on-surface-variant" ] [ text detail ]
                    ]
                ]

        body dest =
            div [ class "flex flex-col gap-1 pt-2" ]
                [ timelineRow "flight_takeoff" "Depart" (model.depart ++ " · " ++ model.time)
                , Divider.new |> Divider.withInset True |> Divider.view
                , timelineRow (categoryIcon dest.category) ("Arrive in " ++ dest.name) dest.blurb
                , Divider.new |> Divider.withInset True |> Divider.view
                , timelineRow "flight_land"
                    (case model.tripType of
                        RoundTrip ->
                            "Return"

                        OneWay ->
                            "One-way trip"
                    )
                    (case model.tripType of
                        RoundTrip ->
                            model.return

                        OneWay ->
                            "No return booked"
                    )
                ]
    in
    case maybeDest of
        Just dest ->
            BottomSheet.new { open = True, onClose = CloseItinerary }
                |> BottomSheet.withId "crane-itinerary"
                |> BottomSheet.withModal True
                |> BottomSheet.withHandle True
                |> BottomSheet.withHeader (header dest)
                |> BottomSheet.withBody (body dest)
                |> BottomSheet.withActions
                    [ Button.new { label = "Close", variant = Button.Text }
                        |> Button.withOnClick CloseItinerary
                    , Button.new { label = "Book trip", variant = Button.Filled }
                        |> Button.withOnClick CloseItinerary
                    ]
                |> BottomSheet.view

        Nothing ->
            BottomSheet.new { open = False, onClose = CloseItinerary }
                |> BottomSheet.withId "crane-itinerary"
                |> BottomSheet.withModal True
                |> BottomSheet.view
