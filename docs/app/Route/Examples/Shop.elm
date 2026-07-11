module Route.Examples.Shop exposing (ActionData, Data, Model, Msg, route)

{-| **Shop** example — a full-viewport Material 3 e-commerce storefront screen,
authored on the M3e API with the m3e component set carrying almost all of the
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
import ExampleNav
import Head
import Kit
import Kit.Badge
import Kit.Shape as Shape
import Kit.Surface as Surface exposing (Surface)
import Layout
import M3e
import M3e.Action as Action
import M3e.Element as Element exposing (Element)
import M3e.Html.Attr exposing (Attr)
import M3e.NavItem as NavItem
import M3e.Record.Fab as Fab
import M3e.Record.FilterChip as FilterChip
import M3e.Record.IconButton as IconButton
import M3e.Token as Value exposing (Supported)
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
                        , exampleFooter
                        , checkoutFab
                        ]
                    ]
                , navBar model
                ]
            )
        ]
    }


{-| The shared "Built from" + prev/next strip.
-}
exampleFooter : Element { s | html : Supported, link : Supported } msg
exampleFooter =
    ExampleNav.footer
        { builtFrom =
            [ ( "appbar", "AppBar" )
            , ( "navrail", "NavRail" )
            , ( "navbar", "NavBar" )
            , ( "card", "Card" )
            , ( "badge", "Badge" )
            , ( "filterchipset", "FilterChipSet" )
            , ( "fab", "Fab" )
            , ( "iconbutton", "IconButton" )
            ]
        , prev = Just ( "/examples/dashboard", "Dashboard" )
        , next = Just ( "/examples/mail", "Mail" )
        }



-- CHROME ----------------------------------------------------------------------


{-| Top app bar: store name in the title slot, a search + cart action trailing.
The cart button wears a Badge showing the live item count.
-}
appBar : Model -> Element { s | appBar : Supported } (PagesMsg Msg)
appBar model =
    M3e.appBar
        [ Layout.class "px-2" ]
        [ M3e.appBarSlotTitle
            (Layout.div "flex items-center gap-2"
                [ Kit.colored [ Kit.primary ] [ M3e.icon [ M3e.attrName "storefront", M3e.attrFilled True ] [] ]
                , Kit.title Value.large [ Kit.onSurface ] [ Kit.text "Maru Market" ]
                ]
            )
        , M3e.appBarSlotTrailing
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
                { content = M3e.icon [ M3e.attrName "shopping_bag" ] [], action = Action.none }
                [ IconButton.variant Value.standard, M3e.ariaLabel "Cart" ]
                []
        , badge =
            M3e.badge [] [ Kit.text (String.fromInt count) ]
        }


{-| Left navigation rail — desktop only.
-}
navRail : Model -> Element { s | navRail : Supported } (PagesMsg Msg)
navRail model =
    M3e.navRail
        [ Layout.class "hidden shrink-0 md:flex" ]
        (List.map (railItem model.category) destinations)


{-| Bottom navigation bar — mobile only.
-}
navBar : Model -> Element { s | navBar : Supported } (PagesMsg Msg)
navBar model =
    M3e.navBar
        [ Layout.class "fixed inset-x-0 bottom-0 z-30 md:hidden" ]
        (List.map (barItem model.category) destinations)


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
                    [ M3e.attrSelected (cat == current)
                    , NavItem.onClick (PagesMsg.fromMsg (SetCategory cat))
                    ]

                Nothing ->
                    [ M3e.attrSelected False ]
    in
    M3e.navItem attrs
        [ M3e.navItemSlotIcon (M3e.icon [ M3e.attrName dest.icon ] [])
        , Kit.text dest.label
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
            [ M3e.filterChipSet [ Layout.class "flex gap-2" ]
                (List.map (categoryChip current) categories)
            ]
        , iconAction "sort"
        ]


categoryChip : String -> String -> Element { s | filterChip : Supported } (PagesMsg Msg)
categoryChip current cat =
    FilterChip.view
        { content = Kit.text cat }
        [ FilterChip.selected (cat == current)
        , FilterChip.onClick (PagesMsg.fromMsg (SetCategory cat))
        ]
        []


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
    M3e.card [ M3e.variantElevated ]
        [ M3e.cardSlotHeader (media product)
        , M3e.cardSlotContent
            (Layout.div "flex flex-col gap-0.5 px-1"
                [ Kit.title Value.medium [ Kit.onSurface ] [ Kit.text product.name ]
                , Kit.labelText Value.large [ Kit.onSurfaceVariant ] [ Kit.text product.category ]
                ]
            )
        , M3e.cardSlotActions
            (Layout.div "flex w-full items-center justify-between px-1"
                [ Kit.title Value.large [ Kit.primary ] [ Kit.text product.price ]
                , IconButton.view
                    { content = M3e.icon [ M3e.attrName "add_shopping_cart" ] []
                    , action = Action.onClick (PagesMsg.fromMsg AddToCart)
                    }
                    [ IconButton.variant Value.tonal, M3e.ariaLabel "Add to cart" ]
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
        [ M3e.icon [ M3e.attrName product.icon, M3e.attrOpticalSize 48 ] [] ]


{-| A floating checkout action over the content.
-}
checkoutFab : Element { s | html : Supported } msg
checkoutFab =
    Layout.div "pointer-events-none sticky bottom-20 flex justify-end pr-2 md:bottom-6"
        [ Layout.span "pointer-events-auto"
            [ Fab.view
                { content = M3e.icon [ M3e.attrName "shopping_cart_checkout" ] []
                , action = Action.none
                }
                [ Fab.variant Value.primary, Fab.extended True, M3e.ariaLabel "Checkout" ]
                [ Fab.label (Kit.text "Checkout") ]
            ]
        ]


{-| A standalone standard icon button used for toolbar actions.
-}
iconAction : String -> Element { s | iconButton : Supported } msg
iconAction icon =
    IconButton.view
        { content = M3e.icon [ M3e.attrName icon ] [], action = Action.none }
        [ IconButton.variant Value.standard, M3e.ariaLabel icon ]
        []
