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
import Cem.M3e.Shape
import M3e.Badge as Badge
import M3e.BottomSheet as BottomSheet
import M3e.Button as Button
import M3e.Card as Card
import M3e.DatePicker as DatePicker
import M3e.Divider as Divider
import M3e.FabMenu as FabMenu
import M3e.Heading as Heading
import M3e.Icon as Icon
import M3e.IconButton as IconButton
import M3e.LoadingIndicator as LoadingIndicator
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)
import M3e.SegmentedButton as SegmentedButton
import M3e.Select as Select
import M3e.Shape as Shape
import M3e.Tabs as Tabs
import M3e.Theme as Theme
import M3e.TimePicker as TimePicker
import M3e.Tooltip as Tooltip
import Pages.Url
import PagesMsg exposing (PagesMsg)
import Process
import RouteBuilder exposing (App, StatefulRoute)
import Set exposing (Set)
import Shared
import Task
import UrlPath
import View exposing (View)


toHtml : Renderable any Msg -> Html Msg
toHtml r =
    r |> Renderable.toNode |> Node.toHtml



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
    , shape : Cem.M3e.Shape.Name
    , featured : Bool
    }


destinations : List Destination
destinations =
    [ { id = "den-pasar", name = "Denpasar", country = "Indonesia", category = Fly, rating = "4.8", price = "$680", blurb = "Direct flights to Bali's coast.", shape = Cem.M3e.Shape.Sunny, featured = True }
    , { id = "cordoba", name = "Córdoba", country = "Argentina", category = Fly, rating = "4.6", price = "$540", blurb = "Andean foothills and old-town plazas.", shape = Cem.M3e.Shape.Boom, featured = True }
    , { id = "khumbu", name = "Khumbu Valley", country = "Nepal", category = Fly, rating = "4.9", price = "$1,120", blurb = "Gateway to the high Himalaya.", shape = Cem.M3e.Shape.Pentagon, featured = True }
    , { id = "mali", name = "Mali", country = "West Africa", category = Fly, rating = "4.5", price = "$870", blurb = "Saharan trade routes and river towns.", shape = Cem.M3e.Shape.Diamond, featured = False }
    , { id = "ushuaia-lodge", name = "Ushuaia Lodge", country = "Argentina", category = Sleep, rating = "4.7", price = "$210/nt", blurb = "End-of-the-world cabins by the Beagle Channel.", shape = Cem.M3e.Shape.SoftBurst, featured = True }
    , { id = "kyoto-ryokan", name = "Kyoto Ryokan", country = "Japan", category = Sleep, rating = "4.9", price = "$340/nt", blurb = "Tatami rooms and a private onsen.", shape = Cem.M3e.Shape.Flower, featured = False }
    , { id = "tulum-bungalow", name = "Tulum Bungalow", country = "Mexico", category = Sleep, rating = "4.4", price = "$185/nt", blurb = "Palapa roofs steps from the reef.", shape = Cem.M3e.Shape.Semicircle, featured = False }
    , { id = "san-sebastian", name = "San Sebastián", country = "Spain", category = Eat, rating = "4.9", price = "Pintxos", blurb = "The world's densest cluster of stars.", shape = Cem.M3e.Shape.Burst, featured = True }
    , { id = "oaxaca", name = "Oaxaca", country = "Mexico", category = Eat, rating = "4.8", price = "Mole", blurb = "Seven moles and mezcal at dusk.", shape = Cem.M3e.Shape.Puffy, featured = False }
    , { id = "lyon", name = "Lyon", country = "France", category = Eat, rating = "4.7", price = "Bouchon", blurb = "Bouchons and the bistro tradition.", shape = Cem.M3e.Shape.Gem, featured = False }
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
        [ p [ class "text-label-lg uppercase tracking-wide text-primary" ] [ text "Studies" ]
        , Heading.view { label = "Crane", variant = Heading.Display }
            [ Heading.size Heading.Small
            , Heading.level 1
            ]
            |> toHtml
        , p [ class "max-w-2xl text-body-lg text-on-surface-variant" ]
            [ text "An expressive travel app: switch between Fly, Sleep, and Eat, set your trip, search fares, and browse a scrolling row of featured destinations — all composed from elm-m3e components under their own Crane-purple theme." ]
        ]


{-| The whole product surface, wrapped in its own expressive theme so the Crane
palette is scoped to the demo and doesn't leak into the docs chrome.
-}
craneApp : Model -> Html Msg
craneApp model =
    Theme.view
        { content =
            [ Renderable.html
                (div [ class "overflow-hidden rounded-md-corner-large border border-outline-variant bg-surface" ]
                    [ appHeader model
                    , div [ class "space-y-6 p-4 sm:space-y-8 sm:p-6" ]
                        [ searchForm model
                        , featuredCarousel model
                        , resultsSection model
                        ]
                    , itinerarySheet model
                    ]
                )
            ]
        }
        [ Theme.seedColor "#5D3FD3"
        , Theme.variant Theme.Expressive
        , Theme.motion Theme.MotionExpressive
        ]
        |> toHtml


appHeader : Model -> Html Msg
appHeader model =
    div [ class "flex flex-col gap-3 bg-surface-container-low p-4 sm:gap-4 sm:p-6" ]
        [ div [ class "flex flex-wrap items-center justify-between gap-3" ]
            [ div [ class "flex min-w-0 items-center gap-2" ]
                [ Shape.view
                    { content =
                        [ Renderable.html
                            (div [ class "size-8 shrink-0 bg-primary text-on-primary grid place-items-center" ]
                                [ Icon.view { name = "explore" } |> toHtml ]
                            )
                        ]
                    }
                    [ Shape.name Cem.M3e.Shape.Sunny ]
                    |> toHtml
                , Heading.view { label = "Crane", variant = Heading.Title }
                    [ Heading.size Heading.Large
                    , Heading.level 2
                    ]
                    |> toHtml
                ]
            , planTripMenu model
            ]
        , div [ class "-mx-4 overflow-x-auto px-4 sm:mx-0 sm:px-0" ]
            [ categoryTabs model ]
        ]


categoryTabs : Model -> Html Msg
categoryTabs model =
    Tabs.view
        { tabs =
            List.map
                (\cat ->
                    -- Note: tab icons (old Tabs.withTabIcon) have no equivalent
                    -- in M3e.Tabs — the icon option has been dropped.
                    Tabs.tab { label = categoryLabel cat }
                        [ Tabs.tabSelected (cat == model.category)
                        , Tabs.tabOnClick (SelectCategory cat)
                        ]
                )
                [ Fly, Sleep, Eat ]
        , panels = []
        }
        [ Tabs.stretch True ]
        |> toHtml


planTripMenu : Model -> Html Msg
planTripMenu _ =
    FabMenu.view
        { triggerIcon = "add"
        , name = "Plan trip"
        , items =
            [ FabMenu.item { icon = "flight", label = "Flights", onClick = PlanTrip Fly }
            , FabMenu.item { icon = "hotel", label = "Hotels", onClick = PlanTrip Sleep }
            , FabMenu.item { icon = "restaurant", label = "Restaurants", onClick = PlanTrip Eat }
            ]
        }
        [ FabMenu.variant FabMenu.Primary
        , FabMenu.menuId "crane-plan-trip"
        ]
        |> toHtml



-- SEARCH FORM


searchForm : Model -> Html Msg
searchForm model =
    section [ class "space-y-4 rounded-md-corner-large bg-surface-container-lowest p-4 sm:p-5" ]
        [ div [ class "flex flex-wrap items-center justify-between gap-3" ]
            [ Heading.view { label = "Find your trip", variant = Heading.Title }
                [ Heading.size Heading.Medium
                , Heading.level 3
                ]
                |> toHtml
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
    SegmentedButton.view
        { segments =
            [ SegmentedButton.segment { label = "Round-trip", checked = model.tripType == RoundTrip }
                [ SegmentedButton.segmentOnClick (SetTripType RoundTrip) ]
            , SegmentedButton.segment { label = "One-way", checked = model.tripType == OneWay }
                [ SegmentedButton.segmentOnClick (SetTripType OneWay) ]
            ]
        }
        []
        |> toHtml


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
                [ Icon.view { name = categoryIcon d.category } |> toHtml
                , span [ class "flex flex-col" ]
                    [ span [ class "text-body-md text-on-surface" ] [ text d.name ]
                    , span [ class "text-body-sm text-on-surface-variant" ] [ text d.country ]
                    ]
                ]
    in
    div [ class "relative flex min-w-0 flex-col gap-1.5" ]
        [ span [ class "text-label-md text-on-surface-variant" ] [ text "Where to" ]
        , div [ class "flex min-h-12 items-center gap-2 rounded-md-corner-full bg-surface-container px-3 py-2.5" ]
            [ Icon.view { name = "search" } |> toHtml
            , Html.input
                [ class "min-w-0 flex-1 bg-transparent text-body-lg text-on-surface outline-none placeholder:text-on-surface-variant"
                , attribute "placeholder" "Search destinations"
                , Html.Attributes.value model.query
                , attribute "aria-label" "Search destinations"
                , Html.Events.onInput SetQuery
                ]
                []
            , if model.query /= "" then
                IconButton.view { icon = "close", name = "Clear search" }
                    [ IconButton.size IconButton.ExtraSmall
                    , IconButton.onClick (SetQuery "")
                    ]
                    |> toHtml

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
    Select.view { label = "Passengers" }
        [ Select.withId "crane-passengers"
        , Select.withOptions
            (List.map
                (\n ->
                    Select.option
                        { value = String.fromInt n
                        , label =
                            String.fromInt n
                                ++ (if n == 1 then
                                        " traveler"

                                    else
                                        " travelers"
                                   )
                        }
                        [ Select.optionSelected (n == model.passengers) ]
                )
                [ 1, 2, 3, 4, 5, 6 ]
            )
        , Select.onChange (\s -> SetPassengers (Maybe.withDefault 1 (String.toInt s)))
        ]
        |> toHtml


departField : Model -> Html Msg
departField model =
    div [ class "flex min-w-0 flex-col gap-1.5" ]
        [ span [ class "text-label-md text-on-surface-variant" ] [ text "Depart" ]
        , dateTrigger
            { targetId = "crane-depart"
            , label = "Depart"
            , value = model.depart
            , icon = "flight_takeoff"
            }
        , DatePicker.view
            [ DatePicker.withId "crane-depart"
            , DatePicker.withLabel "Depart"
            , DatePicker.withClearable False
            , DatePicker.onChange SetDepart
            ]
            |> toHtml
        ]


returnOrTimeField : Model -> Html Msg
returnOrTimeField model =
    case model.tripType of
        RoundTrip ->
            div [ class "flex min-w-0 flex-col gap-1.5" ]
                [ span [ class "text-label-md text-on-surface-variant" ] [ text "Return" ]
                , dateTrigger
                    { targetId = "crane-return"
                    , label = "Return"
                    , value = model.return
                    , icon = "event"
                    }
                , DatePicker.view
                    [ DatePicker.withId "crane-return"
                    , DatePicker.withLabel "Return"
                    , DatePicker.withMinDate model.depart
                    , DatePicker.withClearable True
                    , DatePicker.onChange SetReturn
                    ]
                    |> toHtml
                ]

        OneWay ->
            div [ class "flex min-w-0 flex-col gap-1.5" ]
                [ span [ class "text-label-md text-on-surface-variant" ] [ text "Departure time" ]
                , TimePicker.view { label = "Preferred departure time" }
                    [ TimePicker.withId "crane-time"
                    , TimePicker.withValue model.time
                    , TimePicker.withStep 300
                    , TimePicker.onChange SetTime
                    ]
                    |> toHtml
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
        [ class "flex min-h-12 w-full items-center gap-2 rounded-md-corner-medium border border-outline-variant bg-surface-container px-3 py-2 text-left text-body-lg text-on-surface hover:bg-surface-container-high"
        , attribute "type" "button"
        , attribute "popovertarget" targetId
        , attribute "aria-label" (label ++ " " ++ value)
        ]
        [ Icon.view { name = icon } |> toHtml
        , span [ class "min-w-0 flex-1 truncate" ] [ text value ]
        , Icon.view { name = "expand_more" } |> toHtml
        ]


searchButton : Model -> Html Msg
searchButton model =
    Button.view { label = "Search fares", variant = Button.Filled }
        [ Button.size Button.Large
        , Button.leadingIcon (Icon.view { name = "travel_explore" })
        , Button.disabled model.searching
        , Button.onClick SearchFares
        ]
        |> toHtml


searchingIndicator : Html Msg
searchingIndicator =
    div [ class "flex items-center gap-2 text-body-md text-on-surface-variant" ]
        [ span [ class "inline-block size-6" ]
            [ LoadingIndicator.view
                [ LoadingIndicator.variant LoadingIndicator.Uncontained ]
                |> toHtml
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
        [ Heading.view { label = "Featured destinations", variant = Heading.Title }
            [ Heading.size Heading.Medium
            , Heading.level 3
            ]
            |> toHtml
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
            [ Shape.view
                { content =
                    [ Renderable.html (div [ class "size-28 bg-primary/30" ] []) ]
                }
                [ Shape.name d.shape ]
                |> toHtml
            ]
        , div [ class "absolute right-2 top-2" ] [ favoriteButton d favorited ]
        , span [ class "relative text-label-md uppercase tracking-wide" ] [ text d.country ]
        , span [ class "relative text-title-lg font-medium" ] [ text d.name ]
        , span [ class "relative text-body-sm" ] [ text (d.price ++ " · ★ " ++ d.rating) ]
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
            [ Heading.view
                { label = categoryLabel model.category ++ " — " ++ String.fromInt (List.length results) ++ " places"
                , variant = Heading.Title
                }
                [ Heading.size Heading.Medium
                , Heading.level 3
                ]
                |> toHtml
            ]
        , Divider.view [] |> toHtml
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
            [ Icon.view { name = "search_off" } |> toHtml
            , p [ class "text-body-md text-on-surface-variant" ]
                [ text ("No " ++ categoryLabel model.category ++ " results for \u{201C}" ++ model.query ++ "\u{201D}.") ]
            , Button.view { label = "Clear search", variant = Button.Text }
                [ Button.onClick (SetQuery "") ]
                |> toHtml
            ]
        ]


destinationCard : Model -> Destination -> Html Msg
destinationCard model d =
    let
        favorited =
            Set.member d.id model.favorites

        media =
            div [ class "relative grid h-32 place-items-center bg-secondary-container" ]
                [ Shape.view
                    { content =
                        [ Renderable.html
                            (div [ class "size-20 bg-primary text-on-primary grid place-items-center" ]
                                [ Icon.view { name = categoryIcon d.category } |> toHtml ]
                            )
                        ]
                    }
                    [ Shape.name d.shape ]
                    |> toHtml
                , div [ class "absolute left-2 top-2 flex items-center gap-1" ]
                    [ span [ attribute "id" (badgeAnchor d), class "rounded-md-corner-full bg-surface px-2 py-0.5 text-label-sm text-on-surface" ]
                        [ text ("★ " ++ d.rating) ]
                    , Badge.view [ Badge.label "Top rated", Badge.forId (badgeAnchor d) ] |> toHtml
                    ]
                , div [ class "absolute right-2 top-2" ] [ favoriteButton d favorited ]
                ]
    in
    Card.new
        |> Card.withVariant Card.Elevated
        |> Card.withMedia (Renderable.html media)
        |> Card.withHeadline (Heading.view { label = d.name, variant = Heading.Title } [])
        |> Card.withSubhead (Heading.view { label = d.country ++ " · " ++ d.price, variant = Heading.Label } [])
        |> Card.withBody
            [ Renderable.html (p [ class "text-body-md text-on-surface-variant" ] [ text d.blurb ]) ]
        |> Card.withActions
            [ Button.view { label = "Itinerary", variant = Button.Text }
                [ Button.onClick (OpenItinerary d.id) ]
            , Button.view { label = "Select", variant = Button.Filled }
                [ Button.onClick (OpenItinerary d.id) ]
            ]
        |> Card.toNode
        |> Node.toHtml


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
            [ IconButton.view
                { icon = "favorite_border"
                , name =
                    if favorited then
                        "Remove " ++ d.name ++ " from favorites"

                    else
                        "Add " ++ d.name ++ " to favorites"
                }
                [ IconButton.variant IconButton.Filled
                , IconButton.size IconButton.Small
                , IconButton.toggle True
                , IconButton.selected favorited
                , IconButton.onChange (ToggleFavorite d.id)
                , IconButton.selectedIcon (Icon.view { name = "favorite" })
                ]
                |> toHtml
            ]
        , Tooltip.plain { anchorId = anchorId, label = "Save to favorites" } [] |> toHtml
        ]



-- ITINERARY BOTTOM SHEET


itinerarySheet : Model -> Html Msg
itinerarySheet model =
    let
        maybeDest =
            model.itineraryFor
                |> Maybe.andThen (\id -> List.head (List.filter (\d -> d.id == id) destinations))

        headerHtml dest =
            div [ class "flex items-center gap-3" ]
                [ Shape.view
                    { content =
                        [ Renderable.html
                            (div [ class "size-10 bg-primary text-on-primary grid place-items-center" ]
                                [ Icon.view { name = categoryIcon dest.category } |> toHtml ]
                            )
                        ]
                    }
                    [ Shape.name dest.shape ]
                    |> toHtml
                , div [ class "flex flex-col" ]
                    [ span [ class "text-title-lg text-on-surface" ] [ text dest.name ]
                    , span [ class "text-body-md text-on-surface-variant" ] [ text (dest.country ++ " · " ++ dest.price) ]
                    ]
                ]

        timelineRow icon title detail =
            div [ class "flex items-start gap-3 py-2" ]
                [ Icon.view { name = icon } |> toHtml
                , div [ class "flex flex-col" ]
                    [ span [ class "text-body-lg text-on-surface" ] [ text title ]
                    , span [ class "text-body-sm text-on-surface-variant" ] [ text detail ]
                    ]
                ]

        bodyHtml dest =
            div [ class "flex flex-col gap-1 pt-2" ]
                [ timelineRow "flight_takeoff" "Depart" (model.depart ++ " · " ++ model.time)
                , Divider.view [ Divider.inset True ] |> toHtml
                , timelineRow (categoryIcon dest.category) ("Arrive in " ++ dest.name) dest.blurb
                , Divider.view [ Divider.inset True ] |> toHtml
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
            BottomSheet.view
                { content = [ Renderable.html (bodyHtml dest) ] }
                [ BottomSheet.open True
                , BottomSheet.onClose CloseItinerary
                , BottomSheet.modal True
                , BottomSheet.handle True
                , BottomSheet.header [ Renderable.html (headerHtml dest) ]
                , BottomSheet.actions
                    [ Button.view { label = "Close", variant = Button.Text }
                        [ Button.onClick CloseItinerary ]
                    , Button.view { label = "Book trip", variant = Button.Filled }
                        [ Button.onClick CloseItinerary ]
                    ]
                ]
                |> toHtml

        Nothing ->
            BottomSheet.view
                { content = [] }
                [ BottomSheet.open False
                , BottomSheet.onClose CloseItinerary
                , BottomSheet.modal True
                ]
                |> toHtml
