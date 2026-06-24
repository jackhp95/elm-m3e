module Route.Studies.Shrine exposing (ActionData, Data, Model, Msg, route)

{-| **Shrine** — a Material 3 e-commerce boutique study.

A polished, interactive storefront composed entirely from the elm-m3e (`Ui.*`)
component library plus the tailwind-m3e-web token bridge. It exercises the full
set of components the coverage matrix assigns to the Shrine study (column 2):

AppBar, NavigationRail, Slide, Button, IconButton, ButtonGroup,
SegmentedButton, Slider, Chip, Select, Card, Dialog, BottomSheet, List,
Carousel, Badge, Snackbar, Skeleton, Icon, Heading, Shape, Theme, Size
(responsive grid columns), Divider.

Real product UX:

  - The **NavigationRail** picks a top department; **Chip** filter row
    multi-selects categories; the **SegmentedButton** flips Grid / List view;
    the **Slider** caps the price — all of which recompute the visible grid.
  - Each product is a **Card** with a **Shape**-clipped image, price **Heading**,
    a favorite **IconButton**, and an "Add to bag" **Button**.
  - The **AppBar** cart **IconButton** carries an item-count **Badge**; tapping a
    product opens a product **Dialog** (a **Slide** gallery, quantity **Slider**,
    size **Select**, and a Buy-now / Add **ButtonGroup**); the cart **BottomSheet**
    lists items (**List**) with quantity steppers; a **Snackbar** confirms
    "Added to bag." A brief **Skeleton** grid stands in while the catalog "loads."

-}

import BackendTask exposing (BackendTask)
import Dict exposing (Dict)
import Effect exposing (Effect)
import Head
import Head.Seo as Seo
import Html exposing (Html, div, span, text)
import Html.Attributes exposing (attribute, class)
import Html.Events
import Json.Decode as Decode
import M3e.Shape
import Pages.Url
import PagesMsg exposing (PagesMsg)
import Process
import RouteBuilder exposing (App, StatefulRoute)
import Shared
import Task
import Ui.AppBar as AppBar
import Ui.Badge as Badge
import Ui.BottomSheet as BottomSheet
import Ui.Button as Button
import Ui.ButtonGroup as ButtonGroup
import Ui.Card as Card
import Ui.Carousel as Carousel
import Ui.Chip as Chip
import Ui.Dialog as Dialog
import Ui.Divider as Divider
import Ui.Heading as Heading
import Ui.Icon as Icon
import Ui.IconButton as IconButton
import Ui.List as L
import Ui.NavigationRail as NavigationRail
import Ui.SegmentedButton as SegmentedButton
import Ui.Select as Select
import Ui.Shape as Shape
import Ui.Skeleton as Skeleton
import Ui.Slide as Slide
import Ui.Slider as Slider
import Ui.Snackbar as Snackbar
import UrlPath
import View exposing (View)



-- DOMAIN ---------------------------------------------------------------------


{-| A department drives the left navigation rail.
-}
type Department
    = All
    | Apparel
    | Home
    | Accessories


departments : List Department
departments =
    [ All, Apparel, Home, Accessories ]


departmentLabel : Department -> String
departmentLabel dept =
    case dept of
        All ->
            "All"

        Apparel ->
            "Apparel"

        Home ->
            "Home"

        Accessories ->
            "Accessories"


departmentIcon : Department -> String
departmentIcon dept =
    case dept of
        All ->
            "storefront"

        Apparel ->
            "checkroom"

        Home ->
            "chair"

        Accessories ->
            "diamond"


{-| A finer-grained category, multi-selectable via the filter chip row.
-}
type Category
    = Tops
    | Outerwear
    | Decor
    | Kitchen
    | Bags
    | Jewelry


allCategories : List Category
allCategories =
    [ Tops, Outerwear, Decor, Kitchen, Bags, Jewelry ]


categoryLabel : Category -> String
categoryLabel cat =
    case cat of
        Tops ->
            "Tops"

        Outerwear ->
            "Outerwear"

        Decor ->
            "Decor"

        Kitchen ->
            "Kitchen"

        Bags ->
            "Bags"

        Jewelry ->
            "Jewelry"


categoryKey : Category -> String
categoryKey =
    categoryLabel


{-| Department a category belongs to (so the rail and chips agree).
-}
categoryDepartment : Category -> Department
categoryDepartment cat =
    case cat of
        Tops ->
            Apparel

        Outerwear ->
            Apparel

        Decor ->
            Home

        Kitchen ->
            Home

        Bags ->
            Accessories

        Jewelry ->
            Accessories


type alias Product =
    { id : Int
    , name : String
    , category : Category
    , price : Float
    , shape : M3e.Shape.Name
    , swatch : String
    }


catalog : List Product
catalog =
    [ Product 1 "Linen Shirt" Tops 48 M3e.Shape.Pill "bg-tertiary-container"
    , Product 2 "Cotton Tee" Tops 24 M3e.Shape.Circle "bg-secondary-container"
    , Product 3 "Wool Overcoat" Outerwear 189 M3e.Shape.Arch "bg-primary-container"
    , Product 4 "Quilted Jacket" Outerwear 132 M3e.Shape.SoftBurst "bg-tertiary-container"
    , Product 5 "Ceramic Vase" Decor 36 M3e.Shape.Flower "bg-secondary-container"
    , Product 6 "Woven Throw" Decor 58 M3e.Shape.Puffy "bg-primary-container"
    , Product 7 "Copper Kettle" Kitchen 72 M3e.Shape.Gem "bg-tertiary-container"
    , Product 8 "Stoneware Bowls" Kitchen 44 M3e.Shape.Sunny "bg-secondary-container"
    , Product 9 "Leather Tote" Bags 156 M3e.Shape.Diamond "bg-primary-container"
    , Product 10 "Canvas Backpack" Bags 88 M3e.Shape.Hexagon "bg-tertiary-container"
    , Product 11 "Gold Hoops" Jewelry 64 M3e.Shape.VerySunny "bg-secondary-container"
    , Product 12 "Beaded Necklace" Jewelry 39 M3e.Shape.Heart "bg-primary-container"
    ]


sizeOptions : List String
sizeOptions =
    [ "XS", "S", "M", "L", "XL" ]



-- PURE LOGIC (filtering + cart maths) ----------------------------------------


{-| Filter the catalog by the active department, the selected category chips,
and a maximum price. With no chips selected, every category in the department
shows. This is the single source of truth the grid renders from.
-}
visibleProducts :
    { department : Department, categories : List Category, maxPrice : Float }
    -> List Product
    -> List Product
visibleProducts filters products =
    let
        inDepartment product =
            filters.department == All || categoryDepartment product.category == filters.department

        inCategories product =
            List.isEmpty filters.categories || List.member product.category filters.categories

        underPrice product =
            product.price <= filters.maxPrice
    in
    products
        |> List.filter inDepartment
        |> List.filter inCategories
        |> List.filter underPrice


{-| Categories that are reachable in the current department — used to render
only the relevant filter chips.
-}
categoriesForDepartment : Department -> List Category
categoriesForDepartment dept =
    case dept of
        All ->
            allCategories

        _ ->
            List.filter (\cat -> categoryDepartment cat == dept) allCategories


{-| The bag is a quantity per product id.
-}
type alias Cart =
    Dict Int Int


addToCart : Int -> Int -> Cart -> Cart
addToCart productId qty cart =
    if qty <= 0 then
        cart

    else
        Dict.update productId
            (\existing -> Just (Maybe.withDefault 0 existing + qty))
            cart


setQuantity : Int -> Int -> Cart -> Cart
setQuantity productId qty cart =
    if qty <= 0 then
        Dict.remove productId cart

    else
        Dict.insert productId qty cart


removeFromCart : Int -> Cart -> Cart
removeFromCart productId cart =
    Dict.remove productId cart


cartCount : Cart -> Int
cartCount cart =
    Dict.values cart |> List.sum


cartSubtotal : Cart -> Float
cartSubtotal cart =
    Dict.foldl
        (\productId qty total ->
            case productById productId of
                Just product ->
                    total + product.price * toFloat qty

                Nothing ->
                    total
        )
        0
        cart


productById : Int -> Maybe Product
productById id =
    List.filter (\p -> p.id == id) catalog |> List.head


formatPrice : Float -> String
formatPrice amount =
    let
        cents =
            round (amount * 100)

        dollars =
            cents // 100

        remainder =
            modBy 100 cents

        pad n =
            if n < 10 then
                "0" ++ String.fromInt n

            else
                String.fromInt n
    in
    "$" ++ String.fromInt dollars ++ "." ++ pad remainder



-- MODEL ----------------------------------------------------------------------


type View_
    = Grid
    | ListView


type alias Model =
    { loading : Bool
    , department : Department
    , categories : List Category
    , maxPrice : Float
    , viewMode : View_
    , favorites : List Int
    , cart : Cart
    , cartOpen : Bool
    , detail : Maybe Int
    , detailQty : Float
    , detailSize : String
    , snackbar : Maybe (Snackbar.Snackbar Msg)
    }


type alias RouteParams =
    {}


type alias Data =
    {}


type alias ActionData =
    {}


type Msg
    = CatalogLoaded
    | DepartmentPicked Department
    | CategoryToggled Category
    | MaxPriceChanged Float
    | ViewModeChanged View_
    | FavoriteToggled Int
    | AddedToBag Int Int
    | CartOpened
    | CartClosed
    | QuantityChanged Int Int
    | ItemRemoved Int
    | ProductOpened Int
    | ProductClosed
    | DetailQtyChanged Float
    | DetailSizeChanged String


init : App Data ActionData RouteParams -> Shared.Model -> ( Model, Effect Msg )
init _ _ =
    ( { loading = True
      , department = All
      , categories = []
      , maxPrice = 200
      , viewMode = Grid
      , favorites = []
      , cart = Dict.empty
      , cartOpen = False
      , detail = Nothing
      , detailQty = 1
      , detailSize = "M"
      , snackbar = Nothing
      }
      -- Simulate the first-content load that the Skeleton placeholders cover.
    , Effect.fromCmd (delay 600 CatalogLoaded)
    )


delay : Float -> msg -> Cmd msg
delay ms msg =
    Process.sleep ms |> Task.perform (always msg)


update : App Data ActionData RouteParams -> Shared.Model -> Msg -> Model -> ( Model, Effect Msg )
update _ _ msg model =
    case msg of
        CatalogLoaded ->
            ( { model | loading = False }, Effect.none )

        DepartmentPicked dept ->
            -- Switching department drops category chips that no longer apply.
            ( { model
                | department = dept
                , categories =
                    List.filter (\c -> List.member c (categoriesForDepartment dept)) model.categories
              }
            , Effect.none
            )

        CategoryToggled cat ->
            ( { model
                | categories =
                    if List.member cat model.categories then
                        List.filter ((/=) cat) model.categories

                    else
                        cat :: model.categories
              }
            , Effect.none
            )

        MaxPriceChanged price ->
            ( { model | maxPrice = price }, Effect.none )

        ViewModeChanged mode ->
            ( { model | viewMode = mode }, Effect.none )

        FavoriteToggled productId ->
            ( { model
                | favorites =
                    if List.member productId model.favorites then
                        List.filter ((/=) productId) model.favorites

                    else
                        productId :: model.favorites
              }
            , Effect.none
            )

        AddedToBag productId qty ->
            ( { model
                | cart = addToCart productId qty model.cart
                , snackbar = Just (addedSnackbar productId qty)
              }
            , Effect.none
            )

        CartOpened ->
            ( { model | cartOpen = True, snackbar = Nothing }, Effect.none )

        CartClosed ->
            ( { model | cartOpen = False }, Effect.none )

        QuantityChanged productId qty ->
            ( { model | cart = setQuantity productId qty model.cart }, Effect.none )

        ItemRemoved productId ->
            ( { model | cart = removeFromCart productId model.cart }, Effect.none )

        ProductOpened productId ->
            ( { model | detail = Just productId, detailQty = 1, detailSize = "M" }, Effect.none )

        ProductClosed ->
            ( { model | detail = Nothing }, Effect.none )

        DetailQtyChanged qty ->
            ( { model | detailQty = qty }, Effect.none )

        DetailSizeChanged size ->
            ( { model | detailSize = size }, Effect.none )


addedSnackbar : Int -> Int -> Snackbar.Snackbar Msg
addedSnackbar productId qty =
    let
        name =
            productById productId |> Maybe.map .name |> Maybe.withDefault "Item"

        label =
            if qty > 1 then
                String.fromInt qty ++ " × " ++ name ++ " added to bag"

            else
                name ++ " added to bag"
    in
    Snackbar.new label
        |> Snackbar.withId "shrine-snackbar"
        |> Snackbar.withAction "View bag"
        |> Snackbar.withDismissible True
        |> Snackbar.withDuration 4000


subscriptions : RouteParams -> UrlPath.UrlPath -> Shared.Model -> Model -> Sub Msg
subscriptions _ _ _ _ =
    Sub.none


route : StatefulRoute RouteParams Data ActionData Model Msg
route =
    RouteBuilder.single { head = head, data = BackendTask.succeed {} }
        |> RouteBuilder.buildWithLocalState
            { view = view
            , init = init
            , update = update
            , subscriptions = subscriptions
            }


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-m3e"
        , image = { url = [ "favicon.ico" ] |> UrlPath.join |> Pages.Url.fromPath, alt = "elm-m3e", dimensions = Nothing, mimeType = Nothing }
        , description = "Shrine — an interactive Material 3 e-commerce storefront built with elm-m3e."
        , locale = Nothing
        , title = "Shrine · Studies · elm-m3e"
        }
        |> Seo.website



-- VIEW -----------------------------------------------------------------------


view : App Data ActionData RouteParams -> Shared.Model -> Model -> View (PagesMsg Msg)
view _ _ model =
    { title = "Shrine · Studies · elm-m3e"
    , body =
        [ Html.map PagesMsg.fromMsg (viewShrine model) ]
    }


viewShrine : Model -> Html Msg
viewShrine model =
    let
        filtered =
            visibleProducts
                { department = model.department
                , categories = model.categories
                , maxPrice = model.maxPrice
                }
                catalog
    in
    div [ class "mx-auto flex max-w-6xl flex-col gap-6" ]
        [ viewAppBar model
        , viewCarousel
        , div [ class "flex gap-4" ]
            [ div [ class "hidden sm:block" ] [ viewRail model ]
            , div [ class "flex min-w-0 flex-1 flex-col gap-4" ]
                [ viewControls model
                , Divider.new |> Divider.view
                , viewResultsBar model filtered
                , if model.loading then
                    viewSkeletonGrid

                  else
                    viewCatalog model filtered
                ]
            ]
        , viewCartSheet model
        , viewDetailDialog model
        , viewSnackbar model
        ]


viewAppBar : Model -> Html Msg
viewAppBar model =
    let
        count =
            cartCount model.cart

        cartButton =
            div [ class "relative" ]
                [ IconButton.new
                    { icon = Icon.material "shopping_bag"
                    , label = "Open bag"
                    , variant = IconButton.Standard
                    }
                    |> IconButton.withOnClick CartOpened
                    |> IconButton.view
                , if count > 0 then
                    span [ class "pointer-events-none absolute -right-1 -top-1" ]
                        [ Badge.count count |> Badge.view ]

                  else
                    text ""
                ]
    in
    AppBar.new "Shrine"
        |> AppBar.withId "shrine-appbar"
        |> AppBar.withSize AppBar.Small
        |> AppBar.withLeading
            (IconButton.new
                { icon = Icon.material "menu"
                , label = "Menu"
                , variant = IconButton.Standard
                }
                |> IconButton.view
            )
        |> AppBar.withTrailing
            [ IconButton.new
                { icon = Icon.material "search"
                , label = "Search"
                , variant = IconButton.Standard
                }
                |> IconButton.view
            , cartButton
            ]
        |> AppBar.view


viewCarousel : Html Msg
viewCarousel =
    let
        featured =
            [ ( "Spring linens", "bg-tertiary-container", "weekend" )
            , ( "Warm layers", "bg-primary-container", "ac_unit" )
            , ( "Home accents", "bg-secondary-container", "home" )
            , ( "New arrivals", "bg-tertiary-container", "auto_awesome" )
            ]

        slideCard ( title, swatch, icon ) =
            div
                [ class ("flex h-32 w-56 shrink-0 flex-col justify-between rounded-md-corner-large p-4 text-on-surface " ++ swatch) ]
                [ Icon.material icon |> Icon.view
                , span [ class "text-title-medium font-medium" ] [ text title ]
                ]
    in
    Carousel.new (List.map slideCard featured)
        |> Carousel.withId "shrine-carousel"
        |> Carousel.view


viewRail : Model -> Html Msg
viewRail model =
    let
        railItem dept =
            NavigationRail.item
                { value = dept
                , icon = Icon.material (departmentIcon dept)
                }
                |> NavigationRail.withItemLabel (departmentLabel dept)
    in
    NavigationRail.new
        { items = List.map railItem departments
        , selected = Just model.department
        , onChange = DepartmentPicked
        }
        |> NavigationRail.withId "shrine-rail"
        |> NavigationRail.withMode NavigationRail.Expanded
        |> NavigationRail.view


viewControls : Model -> Html Msg
viewControls model =
    let
        chips =
            categoriesForDepartment model.department
                |> List.map
                    (\cat ->
                        Chip.filter
                            { id = "chip-" ++ categoryKey cat
                            , label = text (categoryLabel cat)
                            , onToggle = CategoryToggled cat
                            }
                            |> Chip.withSelected (List.member cat model.categories)
                    )

        viewModeControl =
            SegmentedButton.single
                { label = "View mode"
                , segments =
                    [ SegmentedButton.segment { value = Grid, label = "Grid" }
                    , SegmentedButton.segment { value = ListView, label = "List" }
                    ]
                , selected = Just model.viewMode
                , onChange = ViewModeChanged
                }
                |> SegmentedButton.withId "shrine-viewmode"
                |> SegmentedButton.view

        priceSlider =
            Slider.value
                { label = "Max price"
                , value = model.maxPrice
                , onChange = MaxPriceChanged
                }
                |> Slider.withId "shrine-price"
                |> Slider.withMin 0
                |> Slider.withMax 200
                |> Slider.withStep 5
                |> Slider.withDiscrete True
                |> Slider.withLabelled True
                |> Slider.view
    in
    div [ class "flex flex-col gap-4" ]
        [ div [ class "flex flex-wrap items-center justify-between gap-3" ]
            [ Chip.filterSet chips
                |> Chip.withId "shrine-filters"
                |> Chip.viewSet
            , viewModeControl
            ]
        , div [ class "max-w-md" ]
            [ span [ class "text-label-medium text-on-surface-variant" ]
                [ text ("Up to " ++ formatPrice model.maxPrice) ]
            , priceSlider
            ]
        ]


viewResultsBar : Model -> List Product -> Html Msg
viewResultsBar _ filtered =
    div [ class "flex items-center gap-2 text-on-surface-variant" ]
        [ Icon.material "inventory_2" |> Icon.view
        , Heading.new
            |> Heading.withVariant Heading.Title
            |> Heading.withSize Heading.Small
            |> Heading.withLevel 2
            |> Heading.withContent (text (String.fromInt (List.length filtered) ++ " products"))
            |> Heading.view
        ]


viewSkeletonGrid : Html Msg
viewSkeletonGrid =
    div [ class "grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3" ]
        (List.range 1 6
            |> List.map
                (\n ->
                    div [ class "flex flex-col gap-3 rounded-md-corner-large border border-outline-variant p-4" ]
                        [ Skeleton.new
                            |> Skeleton.withId ("skeleton-media-" ++ String.fromInt n)
                            |> Skeleton.withClass "h-32 w-full rounded-md-corner-medium"
                            |> Skeleton.view
                        , Skeleton.new
                            |> Skeleton.withId ("skeleton-title-" ++ String.fromInt n)
                            |> Skeleton.withClass "h-5 w-2/3"
                            |> Skeleton.view
                        , Skeleton.new
                            |> Skeleton.withId ("skeleton-price-" ++ String.fromInt n)
                            |> Skeleton.withClass "h-4 w-1/3"
                            |> Skeleton.view
                        ]
                )
        )


viewCatalog : Model -> List Product -> Html Msg
viewCatalog model filtered =
    if List.isEmpty filtered then
        div [ class "flex flex-col items-center gap-2 rounded-md-corner-large border border-outline-variant py-16 text-on-surface-variant" ]
            [ Icon.material "sentiment_dissatisfied" |> Icon.view
            , text "No products match these filters."
            ]

    else
        case model.viewMode of
            Grid ->
                div
                    -- Size: responsive grid columns scale with breakpoint.
                    [ class "grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3" ]
                    (List.map (viewProductCard model) filtered)

            ListView ->
                viewProductList model filtered


productMedia : Product -> Html Msg
productMedia product =
    Shape.new
        |> Shape.withName product.shape
        |> Shape.withClass ("flex h-36 items-center justify-center " ++ product.swatch)
        |> Shape.withContent
            [ Icon.material (categoryGlyph product.category) |> Icon.view ]
        |> Shape.view


categoryGlyph : Category -> String
categoryGlyph cat =
    case cat of
        Tops ->
            "apparel"

        Outerwear ->
            "checkroom"

        Decor ->
            "potted_plant"

        Kitchen ->
            "skillet"

        Bags ->
            "shopping_bag"

        Jewelry ->
            "diamond"


viewProductCard : Model -> Product -> Html Msg
viewProductCard model product =
    let
        favoriteButton =
            IconButton.new
                { icon = Icon.material "favorite"
                , label = "Favorite " ++ product.name
                , variant = IconButton.Standard
                }
                |> IconButton.withToggle
                    { selected = List.member product.id model.favorites
                    , onChange = always (FavoriteToggled product.id)
                    , selectedIcon = Just (Icon.material "favorite" |> Icon.withFilled True)
                    }
                |> IconButton.withSize IconButton.Small
                |> IconButton.view

        body =
            div [ class "flex flex-col gap-2" ]
                [ div [ class "flex items-start justify-between gap-2" ]
                    [ Heading.new
                        |> Heading.withVariant Heading.Title
                        |> Heading.withSize Heading.Medium
                        |> Heading.withLevel 3
                        |> Heading.withContent (text product.name)
                        |> Heading.view
                    , favoriteButton
                    ]
                , Heading.new
                    |> Heading.withVariant Heading.Title
                    |> Heading.withSize Heading.Small
                    |> Heading.withLevel 4
                    |> Heading.withContent
                        (span [ class "text-primary" ] [ text (formatPrice product.price) ])
                    |> Heading.view
                ]
    in
    Card.new Card.Elevated
        |> Card.withMedia
            (div
                [ class "cursor-pointer"
                , attribute "role" "button"
                , Html.Attributes.tabindex 0
                , Html.Events.onClick (ProductOpened product.id)
                ]
                [ productMedia product ]
            )
        |> Card.withBody body
        |> Card.withActions
            [ Button.new { label = "Add to bag", variant = Button.Filled }
                |> Button.withLeadingIcon (Icon.material "add_shopping_cart")
                |> Button.withOnClick (AddedToBag product.id 1)
            , Button.new { label = "Details", variant = Button.Text }
                |> Button.withOnClick (ProductOpened product.id)
            ]
        |> Card.view


viewProductList : Model -> List Product -> Html Msg
viewProductList _ filtered =
    L.new
        (filtered
            |> List.map
                (\product ->
                    L.actionItem product.name
                        |> L.withItemLeadingIcon (Icon.material (categoryGlyph product.category))
                        |> L.withItemOverline (categoryLabel product.category)
                        |> L.withItemSupporting (formatPrice product.price)
                        |> L.withItemTrailingIcon (Icon.material "add_shopping_cart")
                        |> L.withItemOnClick (AddedToBag product.id 1)
                )
        )
        |> L.withId "shrine-list"
        |> L.withVariant L.Standard
        |> L.view



-- CART SHEET -----------------------------------------------------------------


viewCartSheet : Model -> Html Msg
viewCartSheet model =
    let
        items =
            Dict.toList model.cart
                |> List.filterMap
                    (\( productId, qty ) ->
                        productById productId |> Maybe.map (\p -> ( p, qty ))
                    )

        header =
            div [ class "flex items-center justify-between" ]
                [ Heading.new
                    |> Heading.withVariant Heading.Headline
                    |> Heading.withSize Heading.Small
                    |> Heading.withLevel 2
                    |> Heading.withContent (text "Your bag")
                    |> Heading.view
                , span [ class "text-label-large text-on-surface-variant" ]
                    [ text (String.fromInt (cartCount model.cart) ++ " items") ]
                ]

        body =
            if List.isEmpty items then
                div [ class "flex flex-col items-center gap-2 py-8 text-on-surface-variant" ]
                    [ Icon.material "shopping_bag" |> Icon.view
                    , text "Your bag is empty."
                    ]

            else
                div [ class "flex flex-col gap-2" ]
                    (List.map viewCartRow items
                        ++ [ Divider.new |> Divider.view
                           , div [ class "flex items-center justify-between pt-1" ]
                                [ span [ class "text-title-medium text-on-surface" ] [ text "Subtotal" ]
                                , span [ class "text-title-medium font-medium text-primary" ]
                                    [ text (formatPrice (cartSubtotal model.cart)) ]
                                ]
                           ]
                    )
    in
    BottomSheet.new { open = model.cartOpen, onClose = CartClosed }
        |> BottomSheet.withId "shrine-cart"
        |> BottomSheet.withModal True
        |> BottomSheet.withHandle True
        |> BottomSheet.withHeader header
        |> BottomSheet.withBody body
        |> BottomSheet.withActions
            [ Button.new { label = "Checkout", variant = Button.Filled }
                |> Button.withLeadingIcon (Icon.material "lock")
                |> Button.withDisabled
                    (if List.isEmpty items then
                        Button.Disabled

                     else
                        Button.Enabled
                    )
                |> Button.withOnClick CartClosed
            , Button.new { label = "Keep shopping", variant = Button.Text }
                |> Button.withOnClick CartClosed
            ]
        |> BottomSheet.view


viewCartRow : ( Product, Int ) -> Html Msg
viewCartRow ( product, qty ) =
    div [ class "flex items-center gap-3" ]
        [ Shape.new
            |> Shape.withName product.shape
            |> Shape.withClass ("flex h-10 w-10 items-center justify-center " ++ product.swatch)
            |> Shape.withContent
                [ Icon.material (categoryGlyph product.category) |> Icon.view ]
            |> Shape.view
        , div [ class "flex min-w-0 flex-1 flex-col" ]
            [ span [ class "truncate text-body-large text-on-surface" ] [ text product.name ]
            , span [ class "text-label-medium text-on-surface-variant" ]
                [ text (formatPrice product.price ++ " each") ]
            ]
        , div [ class "flex items-center gap-1" ]
            [ IconButton.new
                { icon = Icon.material "remove"
                , label = "Decrease quantity"
                , variant = IconButton.Standard
                }
                |> IconButton.withSize IconButton.ExtraSmall
                |> IconButton.withOnClick (QuantityChanged product.id (qty - 1))
                |> IconButton.view
            , span [ class "w-6 text-center text-body-large text-on-surface" ] [ text (String.fromInt qty) ]
            , IconButton.new
                { icon = Icon.material "add"
                , label = "Increase quantity"
                , variant = IconButton.Standard
                }
                |> IconButton.withSize IconButton.ExtraSmall
                |> IconButton.withOnClick (QuantityChanged product.id (qty + 1))
                |> IconButton.view
            , IconButton.new
                { icon = Icon.material "delete"
                , label = "Remove " ++ product.name
                , variant = IconButton.Standard
                }
                |> IconButton.withSize IconButton.ExtraSmall
                |> IconButton.withOnClick (ItemRemoved product.id)
                |> IconButton.view
            ]
        ]



-- PRODUCT DETAIL DIALOG ------------------------------------------------------


viewDetailDialog : Model -> Html Msg
viewDetailDialog model =
    case model.detail |> Maybe.andThen productById of
        Nothing ->
            text ""

        Just product ->
            let
                qty =
                    max 1 (round model.detailQty)

                gallery =
                    Slide.new
                        |> Slide.withId "shrine-gallery"
                        |> Slide.withSlides
                            (List.range 0 2
                                |> List.map
                                    (\i ->
                                        [ div
                                            [ class ("flex h-40 items-center justify-center rounded-md-corner-large " ++ product.swatch) ]
                                            [ Icon.material (galleryGlyph product.category i) |> Icon.view ]
                                        ]
                                    )
                            )
                        |> Slide.view

                sizeSelect =
                    Select.single
                        { label = "Size"
                        , options =
                            List.map (\s -> Select.option { value = s, label = s }) sizeOptions
                        , selected = Just model.detailSize
                        , onChange = DetailSizeChanged
                        }
                        |> Select.withId "shrine-size"
                        |> Select.withRequired True
                        |> Select.view

                qtySlider =
                    Slider.value
                        { label = "Quantity"
                        , value = model.detailQty
                        , onChange = DetailQtyChanged
                        }
                        |> Slider.withId "shrine-qty"
                        |> Slider.withMin 1
                        |> Slider.withMax 10
                        |> Slider.withStep 1
                        |> Slider.withDiscrete True
                        |> Slider.withLabelled True
                        |> Slider.view

                buyActions =
                    ButtonGroup.new
                        [ Button.new { label = "Buy now", variant = Button.Filled }
                            |> Button.withLeadingIcon (Icon.material "bolt")
                            |> Button.withOnClick (AddedToBag product.id qty)
                        , Button.new { label = "Add to bag", variant = Button.Tonal }
                            |> Button.withLeadingIcon (Icon.material "add_shopping_cart")
                            |> Button.withOnClick (AddedToBag product.id qty)
                        ]
                        |> ButtonGroup.withVariant ButtonGroup.Connected
                        |> ButtonGroup.view

                body =
                    div [ class "flex flex-col gap-4" ]
                        [ gallery
                        , div [ class "flex items-center justify-between" ]
                            [ Heading.new
                                |> Heading.withVariant Heading.Title
                                |> Heading.withSize Heading.Large
                                |> Heading.withLevel 3
                                |> Heading.withContent (span [ class "text-primary" ] [ text (formatPrice product.price) ])
                                |> Heading.view
                            , span [ class "text-label-large text-on-surface-variant" ]
                                [ text (categoryLabel product.category) ]
                            ]
                        , sizeSelect
                        , qtySlider
                        , buyActions
                        ]
            in
            Dialog.new { title = product.name, open = True, onClose = ProductClosed }
                |> Dialog.withId "shrine-detail"
                |> Dialog.withDismissible True
                |> Dialog.withBody body
                |> Dialog.withActions
                    [ Button.new { label = "Close", variant = Button.Text }
                        |> Button.withOnClick ProductClosed
                    ]
                |> Dialog.view


galleryGlyph : Category -> Int -> String
galleryGlyph cat i =
    case modBy 3 i of
        0 ->
            categoryGlyph cat

        1 ->
            "zoom_in"

        _ ->
            "palette"



-- SNACKBAR -------------------------------------------------------------------


viewSnackbar : Model -> Html Msg
viewSnackbar model =
    case model.snackbar of
        Just snackbar ->
            div
                [ attribute "data-shrine-snackbar" "true"
                , Html.Events.on "avt-snackbar-action" (Decode.succeed CartOpened)
                ]
                [ Snackbar.view snackbar ]

        Nothing ->
            text ""
