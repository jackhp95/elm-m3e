module Route.Examples.Feed exposing (ActionData, Data, Model, Msg, route)

{-| **Feed** — the canonical Material 3 adaptive feed pattern: a responsive grid of
content cards whose column count grows with the window size class, driven by a
`FilterChipSet` toolbar. It is the worked reference the `composing-m3e-layouts` skill
points at for this pattern.

The grid is the whole adaptivity: `grid-cols-1 sm:grid-cols-2 lg:grid-cols-3` — one
column on compact, two on medium, three on expanded — so the cards reflow to fill the
available width without any per-breakpoint markup. A row of `FilterChip`s filters the
feed by category; selecting one is real state (`SelectFilter`). Navigation switches the
usual way: `M3e.NavRail` on desktop, `M3e.NavBar` on mobile, one destination list.

Tailwind is layout only (grid/gap/padding/responsive columns); every visual token —
color, typography, surface, shape — comes through the `Kit` / `Kit.Surface` /
`Kit.Shape` seam.

-}

import BackendTask
import Effect exposing (Effect)
import ExampleNav
import Head
import Kit
import Kit.Shape as Shape
import Kit.Surface as Surface exposing (Surface)
import Layout
import M3e
import M3e.Attributes
import TypedHtml.Attributes as TA
import M3e.AppBar
import M3e.Card
import M3e.NavItem
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



-- MODEL -----------------------------------------------------------------------


type alias Model =
    { filter : String }


type Msg
    = SelectFilter String



-- ROUTE -----------------------------------------------------------------------


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
    ( { filter = "All" }, Effect.none )


update : App Data ActionData RouteParams -> Shared.Model -> Msg -> Model -> ( Model, Effect Msg )
update _ _ msg model =
    case msg of
        SelectFilter category ->
            ( { model | filter = category }, Effect.none )


subscriptions : RouteParams -> UrlPath -> Shared.Model -> Model -> Sub Msg
subscriptions _ _ _ _ =
    Sub.none


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    []



-- DATA ------------------------------------------------------------------------


type alias Post =
    { title : String
    , excerpt : String
    , category : String
    , author : String
    , when : String
    , media : Surface
    , icon : String
    }


posts : List Post
posts =
    [ { title = "Motion tokens land in 2.5", excerpt = "Springs and shape morphing now derive from the theme's motion scheme.", category = "Release", author = "Design team", when = "2h", media = Surface.primaryContainer, icon = "animation" }
    , { title = "Adaptive nav, one destination list", excerpt = "How the rail and the bottom bar share a single producer so they never drift.", category = "Guide", author = "Britta Holt", when = "5h", media = Surface.tertiaryContainer, icon = "dashboard" }
    , { title = "A11y-tree spot-checks", excerpt = "The Playwright recipe for asserting every interactive node has a name.", category = "Guide", author = "Miriam Steketee", when = "1d", media = Surface.secondaryContainer, icon = "accessibility_new" }
    , { title = "Re-skin with tokens", excerpt = "A brand refresh is a few Theme inputs, not a sheet of overrides.", category = "Guide", author = "Ali Connors", when = "1d", media = Surface.primaryContainer, icon = "palette" }
    , { title = "Split panes and refreshed search", excerpt = "The 2.5 layer/form roles get expressive elevation tokens across the board.", category = "Release", author = "Product", when = "2d", media = Surface.tertiaryContainer, icon = "space_dashboard" }
    , { title = "Community: composing rich cards", excerpt = "A pattern for media-topped cards that clip to the shape scale.", category = "Community", author = "Trevor Hansen", when = "3d", media = Surface.secondaryContainer, icon = "groups" }
    ]


filters : List String
filters =
    [ "All", "Release", "Guide", "Community" ]


{-| The four navigation destinations, with their Material Symbols icon name.
-}
destinations : List { icon : String, label : String }
destinations =
    [ { icon = "home", label = "Home" }
    , { icon = "explore", label = "Explore" }
    , { icon = "bookmark", label = "Saved" }
    , { icon = "notifications", label = "Activity" }
    ]



-- VIEW ------------------------------------------------------------------------


view : App Data ActionData RouteParams -> Shared.Model -> Model -> View (PagesMsg Msg)
view _ _ model =
    { title = "Feed · elm-m3e"
    , body =
        [ HtmlIr.Element.toNode (HtmlIr.Element.map PagesMsg.fromMsg (screen model)) ]
    }


{-| The full-viewport shell: a desktop rail beside a column of AppBar + the
filter bar and the reflowing card grid, with a mobile bottom bar.
-}
screen : Model -> Element { s | html : M3e.Kind.Brand, sharedLink : HtmlIr.Kind.Shared } adm_ Msg
screen model =
    Surface.view Surface.surface
        [ Layout.class "flex h-screen w-full overflow-hidden" ]
        [ desktopRail
        , Layout.colWith "flex flex-1 flex-col min-w-0 overflow-hidden"
            [ appBar
            , Layout.div "flex-1 overflow-y-auto"
                [ Layout.div "mx-auto flex w-full max-w-6xl flex-col gap-6 p-4 pb-24 md:p-6"
                    [ filterBar model.filter
                    , cardGrid (shownPosts model.filter)
                    ]
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
            , ( "filterchipset", "FilterChipSet" )
            , ( "filterchip", "FilterChip" )
            ]
        , prev = Just ( "/examples/supporting-pane", "Supporting pane" )
        , next = Nothing
        }


appBar : Element { s | appBar : M3e.Kind.Brand } adm_ msg
appBar =
    M3e.appBar []
        [ M3e.AppBar.title (Kit.text "Feed") ]



-- FILTER BAR ------------------------------------------------------------------


{-| The filter toolbar: a `FilterChipSet` of `FilterChip`s. The selected chip
carries `attrSelected`; clicking one is real state via `Native.onClick` (a
`FilterChip`'s selection is presentation — the app owns which category is active).
-}
filterBar : String -> Element { s | filterChipSet : M3e.Kind.Brand } adm_ Msg
filterBar current =
    M3e.filterChipSet []
        (List.map (filterChip current) filters)


filterChip : String -> String -> Element { s | filterChip : M3e.Kind.Brand } adm_ Msg
filterChip current category =
    M3e.filterChip
        [ M3e.Attributes.selected (category == current)
        , Native.onClick (SelectFilter category)
        ]
        [ Kit.text category ]



-- CARD GRID -------------------------------------------------------------------


shownPosts : String -> List Post
shownPosts filter =
    if filter == "All" then
        posts

    else
        List.filter (\p -> p.category == filter) posts


{-| The adaptive grid: `grid-cols-1 sm:grid-cols-2 lg:grid-cols-3`. One line does
the whole responsive column count; the cards reflow to fill.
-}
cardGrid : List Post -> Element { s | html : M3e.Kind.Brand } adm_ msg
cardGrid shown =
    Layout.div "grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3"
        (List.map postCard shown)


postCard : Post -> Element { s | card : M3e.Kind.Brand } adm_ msg
postCard post =
    M3e.card [ M3e.Attributes.variant Value.elevated ]
        [ M3e.Card.header
            (Surface.view post.media
                [ Shape.corner Shape.medium, Layout.class "flex h-32 items-center justify-center" ]
                [ M3e.icon [ TA.name post.icon, Layout.class "text-4xl" ] [] ]
            )
        , M3e.Card.content
            (Layout.colWith "flex flex-col gap-2 pt-1"
                [ Kit.labelText Value.small [ Kit.primary ] [ Kit.text (String.toUpper post.category) ]
                , Kit.title Value.medium [ Kit.onSurface ] [ Kit.text post.title ]
                , Kit.body Value.medium [ Kit.onSurfaceVariant ] [ Kit.text post.excerpt ]
                , Kit.labelText Value.small [ Kit.onSurfaceVariant ] [ Kit.text (post.author ++ " · " ++ post.when) ]
                ]
            )
        ]



-- NAVIGATION ------------------------------------------------------------------


desktopRail : Element { s | navRail : M3e.Kind.Brand } adm_ msg
desktopRail =
    M3e.navRail [ Layout.class "hidden md:flex shrink-0" ]
        (List.map navItem destinations)


mobileBar : Element { s | navBar : M3e.Kind.Brand } adm_ msg
mobileBar =
    M3e.navBar [ Layout.class "md:hidden fixed inset-x-0 bottom-0" ]
        (List.map navItem destinations)


navItem : { icon : String, label : String } -> Element { s | navItem : M3e.Kind.Brand } adm_ msg
navItem d =
    M3e.navItem
        [ M3e.Attributes.selected (d.label == "Home") ]
        [ M3e.NavItem.icon (M3e.icon [ TA.name d.icon ] [])
        , Kit.text d.label
        ]
