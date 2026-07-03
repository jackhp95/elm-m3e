module Route.Examples.Shop exposing (ActionData, Data, Model, Msg, route)

{-| **Shop** example — a full-viewport Material 3 e-commerce storefront screen,
authored on the Vocab API with the m3e component set carrying almost all of the
structure and the kit (`Kit`, `Kit.Surface`, `Kit.Shape`) owning every visual
choice. Tailwind is used only for layout (flex/grid/gap/spacing/positioning and
responsive visibility).

Chrome adapts to the viewport: an `M3e.NavRail` on desktop (`hidden md:flex`) and
an `M3e.NavBar` bottom bar on mobile (`md:hidden`), with a top `M3e.AppBar`
carrying the store name and a cart `M3e.IconButton` wearing an `M3e.Badge` with a
live item count. The catalog is filtered by an `M3e.FilterChipSet` toolbar and
laid out as a responsive `M3e.Card` grid; each card has shape-clipped media (via
`Kit.Shape.corner`), a name, a price, and an add-to-cart `M3e.IconButton`. An
`M3e.Fab` floats over the content. Interactive local state: the active category
and the cart count.

-}

import BackendTask
import Effect exposing (Effect)
import Head
import Kit
import Kit.Badge
import Kit.Shape as Shape
import Kit.Surface as Surface exposing (Surface)
import Layout
import M3e.Action as Action
import M3e.AppBar as AppBar
import M3e.Badge as Badge
import M3e.Card as Card
import M3e.Cem.Attr exposing (Attr)
import M3e.Content exposing (Content)
import M3e.Element as Element exposing (Element)
import M3e.Fab as Fab
import M3e.FilterChip as FilterChip
import M3e.FilterChipSet as FilterChipSet
import M3e.Icon as Icon
import M3e.IconButton as IconButton
import M3e.NavBar as NavBar
import M3e.NavItem as NavItem
import M3e.NavRail as NavRail
import M3e.Value as Value exposing (Supported)
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatefulRoute)
import Shared
import UrlPath exposing (UrlPath)
import View exposing (View)



-- MODEL / MSG -----------------------------------------------------------------


type alias Model =
    { category : String
    , cart : Int
    }


type Msg
    = SetCategory String
    | AddToCart


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
    ( { category = "All", cart = 2 }, Effect.none )


update : App Data ActionData RouteParams -> Shared.Model -> Msg -> Model -> ( Model, Effect Msg )
update _ _ msg model =
    case msg of
        SetCategory c ->
            ( { model | category = c }, Effect.none )

        AddToCart ->
            ( { model | cart = model.cart + 1 }, Effect.none )


subscriptions : RouteParams -> UrlPath -> Shared.Model -> Model -> Sub Msg
subscriptions _ _ _ _ =
    Sub.none


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    []



-- CATALOG ---------------------------------------------------------------------


type alias Product =
    { name : String
    , price : String
    , category : String
    , media : Surface
    , icon : String
    }


products : List Product
products =
    [ { name = "Vagabond sack", price = "$120", category = "Apparel", media = Surface.primaryContainer, icon = "backpack" }
    , { name = "Stella sunglasses", price = "$58", category = "Apparel", media = Surface.tertiaryContainer, icon = "eyeglasses" }
    , { name = "Chambray shirt", price = "$70", category = "Apparel", media = Surface.secondaryContainer, icon = "apparel" }
    , { name = "Gilt desk trio", price = "$58", category = "Home", media = Surface.secondaryContainer, icon = "table_restaurant" }
    , { name = "Copper wire rack", price = "$44", category = "Home", media = Surface.primaryContainer, icon = "shelves" }
    , { name = "Terracotta vase", price = "$36", category = "Home", media = Surface.tertiaryContainer, icon = "potted_plant" }
    , { name = "Rosewater mist", price = "$28", category = "Beauty", media = Surface.tertiaryContainer, icon = "spa" }
    , { name = "Velvet lip tint", price = "$22", category = "Beauty", media = Surface.primaryContainer, icon = "brush" }
    ]


categories : List String
categories =
    [ "All", "Apparel", "Home", "Beauty" ]



-- VIEW ------------------------------------------------------------------------


view : App Data ActionData RouteParams -> Shared.Model -> Model -> View (PagesMsg Msg)
view _ _ model =
    let
        shown : List Product
        shown =
            if model.category == "All" then
                products

            else
                List.filter (\p -> p.category == model.category) products
    in
    { title = "Shop · elm-m3e"
    , body =
        [ Element.toNode
            (Surface.view Surface.surface
                [ Layout.class "flex min-h-screen w-full" ]
                [ navRail model
                , Layout.div "flex min-w-0 flex-1 flex-col"
                    [ appBar model
                    , Layout.section "relative flex-1 overflow-y-auto"
                        [ Layout.div "mx-auto flex w-full max-w-6xl flex-col gap-6 p-4 pb-24 md:p-6"
                            [ hero
                            , filterBar model.category
                            , productGrid shown
                            ]
                        , checkoutFab
                        ]
                    ]
                , navBar model
                ]
            )
        ]
    }



-- CHROME ----------------------------------------------------------------------


{-| Top app bar: store name in the title slot, a search + cart action trailing.
The cart button wears a Badge showing the live item count.
-}
appBar : Model -> Element { s | appBar : Supported } (PagesMsg Msg)
appBar model =
    AppBar.view
        [ Layout.class "px-2" ]
        [ AppBar.title
            (Layout.div "flex items-center gap-2"
                [ Kit.colored [ Kit.primary ] [ Icon.view [ Icon.name "storefront", Icon.filled True ] [] ]
                , Kit.title Value.large [ Kit.onSurface ] [ Kit.text "Maru Market" ]
                ]
            )
        , AppBar.trailing
            (Layout.div "flex items-center gap-1"
                [ iconAction "search"
                , cartAction model.cart
                ]
            )
        ]


{-| Cart icon button carrying a Badge with the item count.
-}
cartAction : Int -> Element { s | html : Supported } (PagesMsg Msg)
cartAction count =
    Kit.Badge.on
        { anchor =
            IconButton.view
                { content = Icon.view [ Icon.name "shopping_bag" ] [], action = Action.none }
                [ IconButton.variant Value.standard ]
                []
        , badge =
            Badge.view [] [ Badge.child (Kit.text (String.fromInt count)) ]
        }


{-| Left navigation rail — desktop only.
-}
navRail : Model -> Element { s | navRail : Supported } (PagesMsg Msg)
navRail model =
    NavRail.view
        [ Layout.class "hidden shrink-0 md:flex" ]
        (NavRail.children (List.map (railItem model.category) destinations))


{-| Bottom navigation bar — mobile only.
-}
navBar : Model -> Element { s | navBar : Supported } (PagesMsg Msg)
navBar model =
    NavBar.view
        [ Layout.class "shrink-0 md:hidden" ]
        (NavBar.children (List.map (barItem model.category) destinations))


type alias Destination =
    { label : String, icon : String, category : Maybe String }


destinations : List Destination
destinations =
    [ { label = "Shop", icon = "storefront", category = Just "All" }
    , { label = "Apparel", icon = "apparel", category = Just "Apparel" }
    , { label = "Wishlist", icon = "favorite", category = Nothing }
    , { label = "Account", icon = "person", category = Nothing }
    ]


railItem : String -> Destination -> Element { s | navItem : Supported } (PagesMsg Msg)
railItem current dest =
    navDestination current dest


barItem : String -> Destination -> Element { s | navItem : Supported } (PagesMsg Msg)
barItem current dest =
    navDestination current dest


navDestination : String -> Destination -> Element { s | navItem : Supported } (PagesMsg Msg)
navDestination current dest =
    let
        attrs : List (Attr { c | selected : Supported, onClick : Supported } (PagesMsg Msg))
        attrs =
            case dest.category of
                Just cat ->
                    [ NavItem.selected (cat == current)
                    , NavItem.onClick (PagesMsg.fromMsg (SetCategory cat))
                    ]

                Nothing ->
                    [ NavItem.selected False ]
    in
    NavItem.view attrs
        [ NavItem.icon (Icon.view [ Icon.name dest.icon ] [])
        , NavItem.child (Kit.text dest.label)
        ]



-- CONTENT ---------------------------------------------------------------------


{-| A small welcome banner painted on a container surface.
-}
hero : Element { s | html : Supported } msg
hero =
    Surface.view Surface.primaryContainer
        [ Shape.corner Shape.extraLarge, Layout.class "flex flex-col gap-1 p-6" ]
        [ Kit.overline [] [ Kit.text "New season" ]
        , Kit.headline Value.small [] [ Kit.text "Everyday goods, thoughtfully made" ]
        , Kit.body Value.medium [] [ Kit.text "Free shipping on orders over $75." ]
        ]


{-| Category filter toolbar: a single-select FilterChipSet that scrolls
horizontally on narrow screens, plus a sort action.
-}
filterBar : String -> Element { s | html : Supported } (PagesMsg Msg)
filterBar current =
    Layout.div "flex items-center gap-2"
        [ Layout.div "min-w-0 flex-1 overflow-x-auto"
            [ FilterChipSet.view [ Layout.class "flex gap-2" ]
                (List.map (categoryChip current) categories)
            ]
        , iconAction "sort"
        ]


categoryChip : String -> String -> Content { r | default : Supported } (PagesMsg Msg)
categoryChip current cat =
    FilterChipSet.child
        (FilterChip.view
            { content = Kit.text cat }
            [ FilterChip.selected (cat == current)
            , FilterChip.onClick (PagesMsg.fromMsg (SetCategory cat))
            ]
            []
        )


{-| Responsive product grid: 1 col on mobile, 2 on small, 3/4 on larger screens.
-}
productGrid : List Product -> Element { s | html : Supported } (PagesMsg Msg)
productGrid shown =
    Layout.div "grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4"
        (List.map productCard shown)


{-| A product card: shape-clipped media, name, price, add-to-cart action.
-}
productCard : Product -> Element { s | card : Supported } (PagesMsg Msg)
productCard product =
    Card.view [ Card.variant Value.elevated ]
        [ Card.header (media product)
        , Card.content
            (Layout.div "flex flex-col gap-0.5 px-1"
                [ Kit.title Value.medium [ Kit.onSurface ] [ Kit.text product.name ]
                , Kit.label Value.large [ Kit.onSurfaceVariant ] [ Kit.text product.category ]
                ]
            )
        , Card.actions
            (Layout.div "flex w-full items-center justify-between px-1"
                [ Kit.title Value.large [ Kit.primary ] [ Kit.text product.price ]
                , IconButton.view
                    { content = Icon.view [ Icon.name "add_shopping_cart" ] []
                    , action = Action.onClick (PagesMsg.fromMsg AddToCart)
                    }
                    [ IconButton.variant Value.tonal ]
                    []
                ]
            )
        ]


{-| Placeholder media: a shape-clipped surface tile with a centered glyph.
-}
media : Product -> Element { s | html : Supported } msg
media product =
    Surface.view product.media
        [ Shape.corner Shape.large, Layout.class "flex aspect-square items-center justify-center" ]
        [ Icon.view [ Icon.name product.icon, Icon.opticalSize 48 ] [] ]


{-| A floating checkout action over the content.
-}
checkoutFab : Element { s | html : Supported } msg
checkoutFab =
    Layout.div "pointer-events-none sticky bottom-4 flex justify-end pr-2 md:bottom-6"
        [ Layout.span "pointer-events-auto"
            [ Fab.view
                { content = Icon.view [ Icon.name "shopping_cart_checkout" ] []
                , action = Action.none
                }
                [ Fab.variant Value.primary, Fab.extended True ]
                [ Fab.label (Kit.text "Checkout") ]
            ]
        ]


{-| A standalone standard icon button used for toolbar actions.
-}
iconAction : String -> Element { s | iconButton : Supported } msg
iconAction icon =
    IconButton.view
        { content = Icon.view [ Icon.name icon ] [], action = Action.none }
        [ IconButton.variant Value.standard ]
        []
