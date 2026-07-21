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
import Doc.Slider
import Effect exposing (Effect)
import ExampleNav
import Head
import Html
import Kit
import Kit.Media as Media
import Kit.Shape as Shape
import Kit.Surface as Surface exposing (Surface)
import Layout
import M3e
import TypedHtml.Attributes as TA
import TypedHtml.Aria as Aria
import M3e.Attributes
import M3e.AppBar
import M3e.Card
import M3e.NavItem
import M3e.SearchBar
import M3e.AssistChip
import M3e
import HtmlIr.Kind
import HtmlIr.Element exposing (Element)
import M3e.Kind
import M3e.Values as Value
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
        [ HtmlIr.Element.toNode (shell model) ]
    }


{-| Full-viewport chrome: a top app bar, a rail-or-main body, and a bottom bar
that only appears on small screens.
-}
shell : Model -> Element { s | html : M3e.Kind.Brand, sharedLink : HtmlIr.Kind.Shared } adm_ (PagesMsg Msg)
shell model =
    Layout.div "flex h-screen w-full flex-col"
        [ appBar
        , Layout.div "flex min-h-0 flex-1"
            [ navRail model.destination
            , Layout.section "min-w-0 flex-1 overflow-y-auto"
                [ content model
                , exampleFooter
                ]
            ]
        , navBar model.destination
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
            , ( "tabs", "Tabs" )
            , ( "tab", "Tab" )
            , ( "card", "Card" )
            , ( "assistchip", "AssistChip" )
            ]
        , prev = Just ( "/examples/mail", "Mail" )
        , next = Just ( "/examples/settings", "Settings" )
        }


appBar : Element { s | appBar : M3e.Kind.Brand } adm_ (PagesMsg Msg)
appBar =
    M3e.appBar []
        [ M3e.AppBar.leading (M3e.icon [ TA.name "public" ] [])
        , M3e.AppBar.title (Kit.text "Wander")
        , M3e.AppBar.trailing
            (M3e.iconButton
                [ M3e.Attributes.variant Value.standard, Aria.label "Notifications" ]
                [ M3e.icon [ TA.name "notifications" ] [] ]
            )
        ]



-- NAVIGATION


{-| The desktop navigation rail, hidden below the `md` breakpoint.
-}
navRail : Dest -> Element { s | html : M3e.Kind.Brand } adm_ (PagesMsg Msg)
navRail current =
    Layout.div "hidden md:flex"
        [ M3e.navRail []
            (List.map (railItem current) destinations)
        ]


railItem : Dest -> ( Dest, String, String ) -> Element { s | navItem : M3e.Kind.Brand } adm_ (PagesMsg Msg)
railItem current ( dest, iconName, label ) =
    M3e.navItem
        [ M3e.Attributes.selected (dest == current)
        , Native.onClick (PagesMsg.fromMsg (SetDest dest))
        ]
        [ M3e.NavItem.icon (M3e.icon [ TA.name iconName ] [])
        , Kit.text label
        ]


{-| The mobile bottom navigation bar, hidden at and above the `md` breakpoint.
-}
navBar : Dest -> Element { s | html : M3e.Kind.Brand } adm_ (PagesMsg Msg)
navBar current =
    Layout.div "md:hidden"
        [ M3e.navBar []
            (List.map (barItem current) destinations)
        ]


barItem : Dest -> ( Dest, String, String ) -> Element { s | navItem : M3e.Kind.Brand } adm_ (PagesMsg Msg)
barItem current ( dest, iconName, label ) =
    M3e.navItem
        [ M3e.Attributes.selected (dest == current)
        , Native.onClick (PagesMsg.fromMsg (SetDest dest))
        ]
        [ M3e.NavItem.icon (M3e.icon [ TA.name iconName ] [])
        , Kit.text label
        ]



-- CONTENT


content : Model -> Element { s | html : M3e.Kind.Brand } adm_ (PagesMsg Msg)
content model =
    Layout.div "flex flex-col gap-8 p-4 md:p-8"
        [ hero
        , categoryTabs model.category
        , popularRails model.category
        , rail "Nearby getaways" nearby
        ]


{-| The category-driven "Popular destinations" rail, sliding between categories.
Reuses `Doc.Slider.slidingPanels` (the same helper the API code toggle
uses): every category's rail is mounted in the track, and switching the category
tab slides the prior rail out and the new one in. The static "Nearby getaways"
rail below is category-independent and stays put.
-}
popularRails : Category -> Element { s | html : M3e.Kind.Brand } adm_ (PagesMsg Msg)
popularRails current =
    Doc.Slider.slidingPanels
        (categoryIndex current)
        (List.map (\( c, _ ) -> rail "Popular destinations" (popular c)) categories)


{-| The 0-based position of the active category within `categories` — the rail
`slidingPanels` translates into view.
-}
categoryIndex : Category -> Int
categoryIndex current =
    categories
        |> List.map Tuple.first
        |> List.indexedMap Tuple.pair
        |> List.filter (\( _, c ) -> c == current)
        |> List.head
        |> Maybe.map Tuple.first
        |> Maybe.withDefault 0


{-| A search hero: a headline over a `SearchBar`, wrapped in a tinted, extra-large
`Surface` panel.
-}
hero : Element { s | html : M3e.Kind.Brand } adm_ (PagesMsg Msg)
hero =
    Surface.view Surface.surfaceContainer
        [ Shape.corner Shape.extraLarge, Layout.class "flex flex-col gap-4 p-6 md:p-8" ]
        [ Kit.headline Value.small [] [ Kit.text "Where to next?" ]
        , Kit.body Value.medium
            [ Kit.onSurfaceVariant ]
            [ Kit.text "Search destinations, dates, and guests." ]
        , searchBar
        ]


searchBar : Element { s | html : M3e.Kind.Brand, searchBar : M3e.Kind.Brand } adm_ (PagesMsg Msg)
searchBar =
    M3e.searchBar
        []
        [ M3e.SearchBar.input (Native.node "input" [] [])
        , M3e.SearchBar.leading (M3e.icon [ TA.name "search" ] [])
        , M3e.SearchBar.trailing (M3e.icon [ TA.name "tune" ] [])
        ]


{-| Category tabs (Flights / Stays / Experiences) that reselect the rails' data.
-}
categoryTabs : Category -> Element { s | tabs : M3e.Kind.Brand } adm_ (PagesMsg Msg)
categoryTabs current =
    M3e.tabs []
        (List.map (categoryTab current) categories)


categoryTab : Category -> ( Category, String ) -> Element { s | tab : M3e.Kind.Brand } adm_ (PagesMsg Msg)
categoryTab current ( category, label ) =
    M3e.tab
        [ M3e.Attributes.selected (category == current)
        , Native.onClick (PagesMsg.fromMsg (SetCategory category))
        ]
        [ Kit.text label ]



-- RAILS


{-| A titled, horizontally-scrolling strip of destination cards.
-}
rail : String -> List Place -> Element { s | html : M3e.Kind.Brand } adm_ (PagesMsg Msg)
rail heading places =
    Layout.section "flex flex-col gap-4"
        [ Kit.title Value.large [] [ Kit.text heading ]
        , Layout.div "flex gap-4 overflow-x-auto pb-2"
            (List.map placeCard places)
        ]


{-| One destination card: shape-clipped tinted media, name + region, a rating
`AssistChip` with a star, and a price. Fixed width so cards line up in the rail.
-}
placeCard : Place -> Element { s | html : M3e.Kind.Brand } adm_ (PagesMsg Msg)
placeCard place =
    Layout.div "w-56 shrink-0"
        [ M3e.card [ M3e.Attributes.variant Value.elevated ]
            [ M3e.Card.header (media place)
            , M3e.Card.content
                (Layout.div "flex flex-col gap-2"
                    [ Kit.title Value.medium [] [ Kit.text place.name ]
                    , Kit.body Value.small [ Kit.onSurfaceVariant ] [ Kit.text place.region ]
                    , Layout.div "flex items-center justify-between"
                        [ ratingChip place.rating
                        , Kit.labelText Value.large [ Kit.primary ] [ Kit.text place.price ]
                        ]
                    ]
                )
            ]
        ]


{-| Placeholder media: a shape-clipped, tinted card-media block standing in for a
destination photo.
-}
media : Place -> Element { s | html : M3e.Kind.Brand } adm_ msg
media place =
    Media.view place.tint
        Shape.large
        [ Layout.class "flex h-28 w-full items-end p-3" ]
        [ M3e.icon [ TA.name "image" ] [] ]


ratingChip : String -> Element { s | assistChip : M3e.Kind.Brand } adm_ (PagesMsg Msg)
ratingChip rating =
    M3e.assistChip
        []
        [ M3e.text rating
        , M3e.AssistChip.icon (M3e.icon [ TA.name "star", M3e.Attributes.filled True ] [])
        ]
