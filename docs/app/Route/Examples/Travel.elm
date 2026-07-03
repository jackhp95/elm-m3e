module Route.Examples.Travel exposing (ActionData, Category, Data, Dest, Model, Msg, route)

{-| **Travel** — a trip-planning browser in the spirit of Google Trips / Airbnb /
Material Crane. A self-contained, full-viewport app screen with its own nav chrome:

  - Adaptive navigation: an `M3e.NavRail` on desktop (`hidden md:flex`) and an
    `M3e.NavBar` bottom bar on mobile (`md:hidden`), plus a top `M3e.AppBar`.
  - A search HERO built from `M3e.SearchBar`, sitting in a `Surface` panel.
  - Category `M3e.Tabs` (Flights / Stays / Experiences) driving the content.
  - Horizontally-scrolling destination RAILS (`flex gap-4 overflow-x-auto`) of
    `M3e.Card` items with shape-clipped media, a name, an `M3e.AssistChip` rating,
    and a price.

Local state drives the active nav destination and the active category tab. All
color / typography / shape come from the kit (`Kit`, `Surface`, `Shape`); Tailwind
is used only for layout (flex / grid / gap / padding / responsive visibility).

-}

import BackendTask
import Effect exposing (Effect)
import Head
import Html
import Kit
import Kit.Media as Media
import Kit.Shape as Shape
import Kit.Surface as Surface exposing (Surface)
import Layout
import M3e.Action as Action
import M3e.AppBar as AppBar
import M3e.AssistChip as AssistChip
import M3e.Card as Card
import M3e.Element as Element exposing (Element)
import M3e.Icon as Icon
import M3e.NavBar as NavBar
import M3e.NavItem as NavItem
import M3e.NavRail as NavRail
import M3e.SearchBar as SearchBar
import M3e.Tab as Tab
import M3e.Tabs as Tabs
import M3e.Value as Value exposing (Supported)
import Native
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatefulRoute)
import Shared
import UrlPath exposing (UrlPath)
import View exposing (View)



-- MODEL


type alias Model =
    { destination : Dest
    , category : Category
    }


{-| Top-level app destinations, mirrored across the rail and the bottom bar.
-}
type Dest
    = Explore
    | Trips
    | Saved
    | Profile


{-| The category tab that selects which sort of trip we are browsing.
-}
type Category
    = Flights
    | Stays
    | Experiences


type Msg
    = SetDest Dest
    | SetCategory Category


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
    ( { destination = Explore, category = Stays }, Effect.none )


update : App Data ActionData RouteParams -> Shared.Model -> Msg -> Model -> ( Model, Effect Msg )
update _ _ msg model =
    case msg of
        SetDest d ->
            ( { model | destination = d }, Effect.none )

        SetCategory c ->
            ( { model | category = c }, Effect.none )


subscriptions : RouteParams -> UrlPath -> Shared.Model -> Model -> Sub Msg
subscriptions _ _ _ _ =
    Sub.none


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    []



-- DATA


{-| A destination card: (name, region, gradient tint, rating, price).
The tint is a `Surface` role so the placeholder media reads as color without
touching Tailwind for background.
-}
type alias Place =
    { name : String
    , region : String
    , tint : Surface
    , rating : String
    , price : String
    }


{-| Popular destinations vary by the active category, so the rails feel alive
when the tabs change.
-}
popular : Category -> List Place
popular category =
    case category of
        Flights ->
            [ Place "Tokyo" "Japan" Surface.primaryContainer "4.9" "$780"
            , Place "Reykjavík" "Iceland" Surface.secondaryContainer "4.8" "$610"
            , Place "Cape Town" "South Africa" Surface.tertiaryContainer "4.7" "$920"
            , Place "Lima" "Peru" Surface.primaryContainer "4.6" "$540"
            ]

        Stays ->
            [ Place "Kyoto" "Japan" Surface.secondaryContainer "4.9" "$240/nt"
            , Place "Santorini" "Greece" Surface.tertiaryContainer "4.8" "$310/nt"
            , Place "Marrakesh" "Morocco" Surface.primaryContainer "4.7" "$180/nt"
            , Place "Queenstown" "New Zealand" Surface.secondaryContainer "4.8" "$220/nt"
            ]

        Experiences ->
            [ Place "Aurora Hunt" "Tromsø" Surface.tertiaryContainer "4.9" "$95"
            , Place "Souk Food Tour" "Fez" Surface.primaryContainer "4.8" "$45"
            , Place "Caldera Sail" "Oia" Surface.secondaryContainer "4.7" "$120"
            , Place "Temple at Dawn" "Bagan" Surface.tertiaryContainer "4.9" "$60"
            ]


{-| A second, static "Nearby getaways" rail for variety.
-}
nearby : List Place
nearby =
    [ Place "Lisbon" "Portugal" Surface.secondaryContainer "4.7" "$150/nt"
    , Place "Oaxaca" "Mexico" Surface.primaryContainer "4.8" "$130/nt"
    , Place "Bologna" "Italy" Surface.tertiaryContainer "4.6" "$170/nt"
    , Place "Porto" "Portugal" Surface.secondaryContainer "4.7" "$140/nt"
    ]


categories : List ( Category, String )
categories =
    [ ( Flights, "Flights" )
    , ( Stays, "Stays" )
    , ( Experiences, "Experiences" )
    ]


destinations : List ( Dest, String, String )
destinations =
    [ ( Explore, "explore", "Explore" )
    , ( Trips, "luggage", "Trips" )
    , ( Saved, "favorite", "Saved" )
    , ( Profile, "person", "Profile" )
    ]



-- VIEW


view : App Data ActionData RouteParams -> Shared.Model -> Model -> View (PagesMsg Msg)
view _ _ model =
    { title = "Travel · elm-m3e"
    , body =
        [ Element.toNode (shell model) ]
    }


{-| Full-viewport chrome: a top app bar, a rail-or-main body, and a bottom bar
that only appears on small screens.
-}
shell : Model -> Element { s | html : Supported } (PagesMsg Msg)
shell model =
    Layout.div "flex h-screen w-full flex-col"
        [ appBar
        , Layout.div "flex min-h-0 flex-1"
            [ navRail model.destination
            , Layout.section "min-w-0 flex-1 overflow-y-auto"
                [ content model ]
            ]
        , navBar model.destination
        ]


appBar : Element { s | appBar : Supported } (PagesMsg Msg)
appBar =
    AppBar.view []
        [ AppBar.leadingIcon (Icon.view [ Icon.name "public" ] [])
        , AppBar.title (Kit.text "Wander")
        , AppBar.trailingIcon (Icon.view [ Icon.name "notifications" ] [])
        ]



-- NAVIGATION


{-| The desktop navigation rail, hidden below the `md` breakpoint.
-}
navRail : Dest -> Element { s | html : Supported } (PagesMsg Msg)
navRail current =
    Layout.div "hidden md:flex"
        [ NavRail.view []
            (NavRail.children (List.map (railItem current) destinations))
        ]


railItem : Dest -> ( Dest, String, String ) -> Element { s | navItem : Supported } (PagesMsg Msg)
railItem current ( dest, iconName, label ) =
    NavItem.view
        [ NavItem.selected (dest == current)
        , NavItem.onClick (PagesMsg.fromMsg (SetDest dest))
        ]
        [ NavItem.icon (Icon.view [ Icon.name iconName ] [])
        , NavItem.child (Kit.text label)
        ]


{-| The mobile bottom navigation bar, hidden at and above the `md` breakpoint.
-}
navBar : Dest -> Element { s | html : Supported } (PagesMsg Msg)
navBar current =
    Layout.div "md:hidden"
        [ NavBar.view []
            (NavBar.children (List.map (barItem current) destinations))
        ]


barItem : Dest -> ( Dest, String, String ) -> Element { s | navItem : Supported } (PagesMsg Msg)
barItem current ( dest, iconName, label ) =
    NavItem.view
        [ NavItem.selected (dest == current)
        , NavItem.onClick (PagesMsg.fromMsg (SetDest dest))
        ]
        [ NavItem.icon (Icon.view [ Icon.name iconName ] [])
        , NavItem.child (Kit.text label)
        ]



-- CONTENT


content : Model -> Element { s | html : Supported } (PagesMsg Msg)
content model =
    Layout.div "flex flex-col gap-8 p-4 md:p-8"
        [ hero
        , categoryTabs model.category
        , rail "Popular destinations" (popular model.category)
        , rail "Nearby getaways" nearby
        ]


{-| A search hero: a headline over a `SearchBar`, wrapped in a tinted, extra-large
`Surface` panel.
-}
hero : Element { s | html : Supported } (PagesMsg Msg)
hero =
    Surface.view Surface.surfaceContainer
        [ Shape.corner Shape.extraLarge, Layout.class "flex flex-col gap-4 p-6 md:p-8" ]
        [ Kit.headline Value.small [] [ Kit.text "Where to next?" ]
        , Kit.body Value.medium
            [ Kit.onSurfaceVariant ]
            [ Kit.text "Search destinations, dates, and guests." ]
        , searchBar
        ]


searchBar : Element { s | html : Supported, searchBar : Supported } (PagesMsg Msg)
searchBar =
    SearchBar.view
        { input = Native.node Html.input [] [] }
        []
        [ SearchBar.leading (Icon.view [ Icon.name "search" ] [])
        , SearchBar.trailing (Icon.view [ Icon.name "tune" ] [])
        ]


{-| Category tabs (Flights / Stays / Experiences) that reselect the rails' data.
-}
categoryTabs : Category -> Element { s | tabs : Supported } (PagesMsg Msg)
categoryTabs current =
    Tabs.view []
        (Tabs.children (List.map (categoryTab current) categories))


categoryTab : Category -> ( Category, String ) -> Element { s | tab : Supported } (PagesMsg Msg)
categoryTab current ( category, label ) =
    Tab.view
        [ Tab.selected (category == current)
        , Tab.onClick (PagesMsg.fromMsg (SetCategory category))
        ]
        [ Tab.child (Kit.text label) ]



-- RAILS


{-| A titled, horizontally-scrolling strip of destination cards.
-}
rail : String -> List Place -> Element { s | html : Supported } (PagesMsg Msg)
rail heading places =
    Layout.section "flex flex-col gap-4"
        [ Kit.title Value.large [] [ Kit.text heading ]
        , Layout.div "flex gap-4 overflow-x-auto pb-2"
            (List.map placeCard places)
        ]


{-| One destination card: shape-clipped tinted media, name + region, a rating
`AssistChip` with a star, and a price. Fixed width so cards line up in the rail.
-}
placeCard : Place -> Element { s | html : Supported } (PagesMsg Msg)
placeCard place =
    Layout.div "w-56 shrink-0"
        [ Card.view [ Card.variant Value.elevated ]
            [ Card.header (media place)
            , Card.content
                (Layout.div "flex flex-col gap-2"
                    [ Kit.title Value.medium [] [ Kit.text place.name ]
                    , Kit.body Value.small [ Kit.onSurfaceVariant ] [ Kit.text place.region ]
                    , Layout.div "flex items-center justify-between"
                        [ ratingChip place.rating
                        , Kit.label Value.large [ Kit.primary ] [ Kit.text place.price ]
                        ]
                    ]
                )
            ]
        ]


{-| Placeholder media: a shape-clipped, tinted card-media block standing in for a
destination photo.
-}
media : Place -> Element { s | html : Supported } msg
media place =
    Media.view place.tint
        Shape.large
        [ Layout.class "flex h-28 w-full items-end p-3" ]
        [ Icon.view [ Icon.name "image" ] [] ]


ratingChip : String -> Element { s | assistChip : Supported } (PagesMsg Msg)
ratingChip rating =
    AssistChip.view
        { content = Kit.text rating
        , action = Action.onClick (PagesMsg.fromMsg (SetDest Saved))
        }
        []
        [ AssistChip.icon (Icon.view [ Icon.name "star", Icon.filled True ] []) ]
