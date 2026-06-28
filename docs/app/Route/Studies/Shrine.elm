module Route.Studies.Shrine exposing (ActionData, Data, Model, Msg, route)

{-| **Shrine** — a Material 3 e-commerce boutique study.

A polished, interactive storefront composed entirely from the elm-m3e (`M3e.*`)
component library plus the tailwind-m3e-web token bridge. It exercises the full
set of components the coverage matrix assigns to the Shrine study (column 2):

AppBar, NavigationRail, Slide, Button, IconButton, ButtonGroup,
SegmentedButton, Slider, Chip, Select, Card, Dialog, BottomSheet, List,
Badge, Snackbar, Skeleton, Icon, Heading, Shape, Theme, Size
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
import Html exposing (div, span, text)
import Html.Attributes exposing (attribute, class)
import Html.Attributes
import Html.Events
import Json.Decode as Decode
import Layout
import Cem.M3e.Shape
import M3e.AppBar as AppBar
import M3e.Badge as Badge
import M3e.BottomSheet as BottomSheet
import M3e.Button as Button
import M3e.ButtonGroup as ButtonGroup
import M3e.Card as Card
import M3e.Chip as Chip
import M3e.ChipSet as ChipSet
import M3e.Dialog as Dialog
import M3e.Divider as Divider
import M3e.Heading as Heading
import M3e.Icon as Icon
import M3e.IconButton as IconButton
import M3e.List as L
import M3e.NavigationRail as NavigationRail
import M3e.Node as Node exposing (Node)
import M3e.Element as Element exposing (Element, Supported)
import M3e.SegmentedButton as SegmentedButton
import M3e.Select as Select
import M3e.Shape as Shape
import M3e.Skeleton as Skeleton
import M3e.Slide as Slide
import M3e.Slider as Slider
import M3e.Snackbar as Snackbar
import Pages.Url
import PagesMsg exposing (PagesMsg)
import Process
import RouteBuilder exposing (App, StatefulRoute)
import Shared
import Task
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
    , shape : Cem.M3e.Shape.Name
    , swatch : String
    }


catalog : List Product
catalog =
    [ Product 1 "Linen Shirt" Tops 48 Cem.M3e.Shape.Pill "bg-tertiary-container"
    , Product 2 "Cotton Tee" Tops 24 Cem.M3e.Shape.Circle "bg-secondary-container"
    , Product 3 "Wool Overcoat" Outerwear 189 Cem.M3e.Shape.Arch "bg-primary-container"
    , Product 4 "Quilted Jacket" Outerwear 132 Cem.M3e.Shape.SoftBurst "bg-tertiary-container"
    , Product 5 "Ceramic Vase" Decor 36 Cem.M3e.Shape.Flower "bg-secondary-container"
    , Product 6 "Woven Throw" Decor 58 Cem.M3e.Shape.Puffy "bg-primary-container"
    , Product 7 "Copper Kettle" Kitchen 72 Cem.M3e.Shape.Gem "bg-tertiary-container"
    , Product 8 "Stoneware Bowls" Kitchen 44 Cem.M3e.Shape.Sunny "bg-secondary-container"
    , Product 9 "Leather Tote" Bags 156 Cem.M3e.Shape.Diamond "bg-primary-container"
    , Product 10 "Canvas Backpack" Bags 88 Cem.M3e.Shape.Hexagon "bg-tertiary-container"
    , Product 11 "Gold Hoops" Jewelry 64 Cem.M3e.Shape.VerySunny "bg-secondary-container"
    , Product 12 "Beaded Necklace" Jewelry 39 Cem.M3e.Shape.Heart "bg-primary-container"
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
    , snackbar : Maybe { message : String }
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


addedSnackbar : Int -> Int -> { message : String }
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
    { message = label }


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
        [ Node.map PagesMsg.fromMsg (viewShrine model) ]
    }


viewShrine : Model -> Node Msg
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
    Layout.div "mx-auto flex max-w-6xl flex-col gap-6 px-4 py-6 sm:px-6 sm:py-8"
        [ viewAppBar model
        , viewCarousel
        , Layout.div "flex gap-4"
            [ Layout.div "hidden sm:block" [ viewRail model ]
            , Layout.div "flex min-w-0 flex-1 flex-col gap-4"
                [ viewControls model
                , Divider.view [] |> Element.toNode
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


viewAppBar : Model -> Node Msg
viewAppBar model =
    let
        count =
            cartCount model.cart

        cartElem =
            Element.element { tag = "div" }
                [ Node.attribute "class" "relative" ]
                (Element.toNode
                    (IconButton.view { icon = "shopping_bag", name = "Open bag" }
                        [ IconButton.onClick CartOpened ]
                    )
                    :: (if count > 0 then
                            [ Element.toNode (Badge.view [ Badge.count count ]) ]

                        else
                            []
                       )
                )
    in
    AppBar.view
        [ AppBar.id "shrine-appbar"
        , AppBar.size AppBar.Small
        , AppBar.leading
            (IconButton.view { icon = "menu", name = "Menu" } [])
        , AppBar.title
            (Heading.view { label = "Shrine", variant = Heading.Title } [])
        , AppBar.trailing
            [ IconButton.view { icon = "search", name = "Search" } []
            , cartElem
            ]
        ]
        |> Element.toNode


viewCarousel : Node Msg
viewCarousel =
    let
        featured =
            [ ( "Spring linens", "bg-tertiary-container", "weekend" )
            , ( "Warm layers", "bg-primary-container", "ac_unit" )
            , ( "Home accents", "bg-secondary-container", "home" )
            , ( "New arrivals", "bg-tertiary-container", "auto_awesome" )
            ]

        slideCard ( title, swatch, iconName ) =
            Layout.div ("flex h-32 w-56 shrink-0 flex-col justify-between rounded-md-corner-large p-4 text-on-surface " ++ swatch)
                [ Icon.view { name = iconName } |> Element.toNode
                , Node.raw (span [ class "text-title-md font-medium" ] [ text title ])
                ]
    in
    Layout.div "-mx-4 flex gap-4 overflow-x-auto px-4 pb-2 sm:mx-0 sm:px-0"
        (List.map slideCard featured)


viewRail : Model -> Node Msg
viewRail model =
    NavigationRail.view
        { items = List.map (railItem model.department) departments }
        [ NavigationRail.id "shrine-rail"
        , NavigationRail.mode NavigationRail.Expanded
        ]
        |> Element.toNode


railItem : Department -> Department -> Element { s | navItem : Element.Supported } Msg
railItem selectedDept dept =
    NavigationRail.item
        { icon = Icon.view { name = departmentIcon dept }, label = departmentLabel dept }
        [ NavigationRail.itemSelected (dept == selectedDept)
        , NavigationRail.itemOnClick (DepartmentPicked dept)
        ]


viewControls : Model -> Node Msg
viewControls model =
    let
        chips =
            categoriesForDepartment model.department
                |> List.map
                    (\cat ->
                        Chip.filter
                            { label = categoryLabel cat
                            , onToggle = CategoryToggled cat
                            }
                            [ Chip.selected (List.member cat model.categories) ]
                    )

        chipSet =
            ChipSet.filterSet { label = "Product filters" }
                [ ChipSet.chips chips ]
                |> Element.toNode

        viewModeControl =
            SegmentedButton.view
                { segments =
                    [ SegmentedButton.segment { label = "Grid", checked = model.viewMode == Grid }
                        [ SegmentedButton.segmentOnClick (ViewModeChanged Grid) ]
                    , SegmentedButton.segment { label = "List", checked = model.viewMode == ListView }
                        [ SegmentedButton.segmentOnClick (ViewModeChanged ListView) ]
                    ]
                }
                []
                |> Element.toNode

        priceSlider =
            Slider.view { name = "Max price" }
                [ Slider.value model.maxPrice
                , Slider.min 0
                , Slider.max 200
                , Slider.step 5
                , Slider.discrete True
                , Slider.labelled True
                , Slider.onInput MaxPriceChanged
                ]
                |> Element.toNode
    in
    Layout.col
        [ Layout.div "flex flex-col gap-3 sm:flex-row sm:flex-wrap sm:items-center sm:justify-between"
            [ chipSet
            , viewModeControl
            ]
        , Layout.div "max-w-md"
            [ Node.raw (span [ class "text-label-md text-on-surface-variant" ]
                [ text ("Up to " ++ formatPrice model.maxPrice) ])
            , priceSlider
            ]
        ]


viewResultsBar : Model -> List Product -> Node Msg
viewResultsBar _ filtered =
    Layout.div "flex items-center gap-2 text-on-surface-variant"
        [ Icon.view { name = "inventory_2" } |> Element.toNode
        , Heading.view
            { label = String.fromInt (List.length filtered) ++ " products"
            , variant = Heading.Title
            }
            [ Heading.size Heading.Small
            , Heading.level 2
            ]
            |> Element.toNode
        ]


viewSkeletonGrid : Node Msg
viewSkeletonGrid =
    Layout.div "grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3"
        (List.range 1 6
            |> List.map
                (\_ ->
                    Layout.div "flex flex-col gap-3 rounded-md-corner-large border border-outline-variant p-4"
                        [ Skeleton.view
                            { content =
                                [ Element.html
                                    (div [ class "h-32 w-full rounded-md-corner-medium" ] [])
                                ]
                            }
                            []
                            |> Element.toNode
                        , Skeleton.view
                            { content =
                                [ Element.html (div [ class "h-5 w-2/3" ] []) ]
                            }
                            []
                            |> Element.toNode
                        , Skeleton.view
                            { content =
                                [ Element.html (div [ class "h-4 w-1/3" ] []) ]
                            }
                            []
                            |> Element.toNode
                        ]
                )
        )


viewCatalog : Model -> List Product -> Node Msg
viewCatalog model filtered =
    if List.isEmpty filtered then
        Layout.div "flex flex-col items-center gap-2 rounded-md-corner-large border border-outline-variant py-16 text-on-surface-variant"
            [ Icon.view { name = "sentiment_dissatisfied" } |> Element.toNode
            , Node.text "No products match these filters."
            ]

    else
        case model.viewMode of
            Grid ->
                Layout.div
                    -- Size: responsive grid columns scale with breakpoint.
                    "grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3"
                    (List.map (viewProductCard model) filtered)

            ListView ->
                viewProductList model filtered


productMedia : Product -> Node Msg
productMedia product =
    Shape.view
        { content =
            [ Element.fromNode
                (Layout.div ("flex h-full w-full items-center justify-center " ++ product.swatch)
                    [ Icon.view { name = categoryGlyph product.category } |> Element.toNode ]
                )
            ]
        }
        [ Shape.name product.shape
        , Shape.attributes [ Node.rawAttr (class "block h-36 w-full") ]
        ]
        |> Element.toNode


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


viewProductCard : Model -> Product -> Node Msg
viewProductCard model product =
    let
        favoriteButton =
            IconButton.view
                { icon = "favorite"
                , name = "Favorite " ++ product.name
                }
                [ IconButton.toggle True
                , IconButton.selected (List.member product.id model.favorites)
                , IconButton.onChange (always (FavoriteToggled product.id))
                , IconButton.selectedIcon (Icon.view { name = "favorite" })
                , IconButton.size IconButton.Small
                ]
                |> Element.toNode

        body =
            Layout.div "flex flex-col gap-2"
                [ Layout.div "flex items-start justify-between gap-2"
                    [ Heading.view { label = product.name, variant = Heading.Title }
                        [ Heading.size Heading.Medium
                        , Heading.level 3
                        ]
                        |> Element.toNode
                    , favoriteButton
                    ]
                , Layout.span "text-primary"
                    [ Heading.view { label = formatPrice product.price, variant = Heading.Title }
                        [ Heading.size Heading.Small
                        , Heading.level 4
                        ]
                        |> Element.toNode
                    ]
                ]
    in
    Card.view
        [ Card.variant Card.Elevated
        , Card.media
            (Element.fromNode
                (Node.element "div"
                    [ Node.rawAttr (class "cursor-pointer")
                    , Node.rawAttr (attribute "role" "button")
                    , Node.rawAttr (Html.Attributes.tabindex 0)
                    , Node.rawAttr (Html.Events.onClick (ProductOpened product.id))
                    ]
                    [ productMedia product ]
                )
            )
        , Card.body [ Element.fromNode body ]
        , Card.actions
            [ Button.view { label = "Add to bag", variant = Button.Filled }
                [ Button.leadingIcon (Icon.view { name = "add_shopping_cart" })
                , Button.onClick (AddedToBag product.id 1)
                ]
            ]
        ]
        |> Element.toNode


viewProductList : Model -> List Product -> Node Msg
viewProductList _ filtered =
    L.actionList
        { items =
            filtered
                |> List.map
                    (\product ->
                        L.actionItem { headline = product.name }
                            [ L.actionLeading
                                (Element.element { tag = "span" }
                                    []
                                    [ Element.toNode (Icon.view { name = categoryGlyph product.category }) ]
                                )
                            , L.actionOverline (categoryLabel product.category)
                            , L.actionSupporting (formatPrice product.price)
                            , L.actionTrailing
                                (Element.element { tag = "span" }
                                    []
                                    [ Element.toNode (Icon.view { name = "add_shopping_cart" }) ]
                                )
                            , L.actionOnClick (AddedToBag product.id 1)
                            ]
                    )
        }
        []
        |> Element.toNode



-- CART SHEET -----------------------------------------------------------------


viewCartSheet : Model -> Node Msg
viewCartSheet model =
    let
        items =
            Dict.toList model.cart
                |> List.filterMap
                    (\( productId, qty ) ->
                        productById productId |> Maybe.map (\p -> ( p, qty ))
                    )

        header =
            Layout.div "flex items-center justify-between"
                [ Heading.view { label = "Your bag", variant = Heading.Headline }
                    [ Heading.size Heading.Small
                    , Heading.level 2
                    ]
                    |> Element.toNode
                , Node.raw
                    (span [ class "text-label-lg text-on-surface-variant" ]
                        [ text (String.fromInt (cartCount model.cart) ++ " items") ]
                    )
                ]

        body =
            if List.isEmpty items then
                Layout.div "flex flex-col items-center gap-2 py-8 text-on-surface-variant"
                    [ Icon.view { name = "shopping_bag" } |> Element.toNode
                    , Node.text "Your bag is empty."
                    ]

            else
                Layout.div "flex flex-col gap-2"
                    (List.map viewCartRow items
                        ++ [ Divider.view [] |> Element.toNode
                           , Node.raw
                                (div [ class "flex items-center justify-between pt-1" ]
                                    [ span [ class "text-title-md text-on-surface" ] [ text "Subtotal" ]
                                    , span [ class "text-title-md font-medium text-primary" ]
                                        [ text (formatPrice (cartSubtotal model.cart)) ]
                                    ]
                                )
                           ]
                    )
    in
    BottomSheet.view
        { content = [ Element.fromNode body ] }
        [ BottomSheet.open model.cartOpen
        , BottomSheet.onClose CartClosed
        , BottomSheet.modal True
        , BottomSheet.handle True
        , BottomSheet.header [ Element.fromNode header ]
        , BottomSheet.actions
            [ Button.view { label = "Checkout", variant = Button.Filled }
                [ Button.leadingIcon (Icon.view { name = "lock" })
                , Button.disabled (List.isEmpty items)
                , Button.onClick CartClosed
                ]
            , Button.view { label = "Keep shopping", variant = Button.Text }
                [ Button.onClick CartClosed ]
            ]
        ]
        |> Element.toNode


viewCartRow : ( Product, Int ) -> Node Msg
viewCartRow ( product, qty ) =
    Layout.row
        [ Shape.view
            { content =
                [ Element.fromNode
                    (Layout.div ("flex h-10 w-10 items-center justify-center " ++ product.swatch)
                        [ Icon.view { name = categoryGlyph product.category } |> Element.toNode ]
                    )
                ]
            }
            [ Shape.name product.shape ]
            |> Element.toNode
        , Node.raw
            (div [ class "flex min-w-0 flex-1 flex-col" ]
                [ span [ class "truncate text-body-lg text-on-surface" ] [ text product.name ]
                , span [ class "text-label-md text-on-surface-variant" ]
                    [ text (formatPrice product.price ++ " each") ]
                ]
            )
        , Layout.div "flex items-center gap-1"
            [ IconButton.view { icon = "remove", name = "Decrease quantity" }
                [ IconButton.size IconButton.ExtraSmall
                , IconButton.onClick (QuantityChanged product.id (qty - 1))
                ]
                |> Element.toNode
            , Node.raw (span [ class "w-6 text-center text-body-lg text-on-surface" ] [ text (String.fromInt qty) ])
            , IconButton.view { icon = "add", name = "Increase quantity" }
                [ IconButton.size IconButton.ExtraSmall
                , IconButton.onClick (QuantityChanged product.id (qty + 1))
                ]
                |> Element.toNode
            , IconButton.view { icon = "delete", name = "Remove " ++ product.name }
                [ IconButton.size IconButton.ExtraSmall
                , IconButton.onClick (ItemRemoved product.id)
                ]
                |> Element.toNode
            ]
        ]



-- PRODUCT DETAIL DIALOG ------------------------------------------------------


viewDetailDialog : Model -> Node Msg
viewDetailDialog model =
    case model.detail |> Maybe.andThen productById of
        Nothing ->
            Node.text ""

        Just product ->
            let
                qty =
                    max 1 (round model.detailQty)

                gallery =
                    Slide.view
                        { items =
                            List.range 0 2
                                |> List.map
                                    (\i ->
                                        Element.fromNode
                                            (Layout.div ("flex h-40 items-center justify-center rounded-md-corner-large " ++ product.swatch)
                                                [ Icon.view { name = galleryGlyph product.category i } |> Element.toNode ]
                                            )
                                    )
                        }
                        [ Slide.selectedIndex 0 ]
                        |> Element.toNode

                sizeSelect =
                    Select.view { label = "Size" }
                        [ Select.id "shrine-size"
                        , Select.required True
                        , Select.options
                            (List.map
                                (\s ->
                                    Select.option { value = s, label = s }
                                        [ Select.optionSelected (s == model.detailSize) ]
                                )
                                sizeOptions
                            )
                        , Select.onChange DetailSizeChanged
                        ]
                        |> Element.toNode

                qtySlider =
                    Slider.view { name = "Quantity" }
                        [ Slider.value model.detailQty
                        , Slider.min 1
                        , Slider.max 10
                        , Slider.step 1
                        , Slider.discrete True
                        , Slider.labelled True
                        , Slider.onInput DetailQtyChanged
                        ]
                        |> Element.toNode

                buyActions =
                    ButtonGroup.view
                        { buttons =
                            [ Button.view { label = "Buy now", variant = Button.Filled }
                                [ Button.leadingIcon (Icon.view { name = "bolt" })
                                , Button.onClick (AddedToBag product.id qty)
                                ]
                            , Button.view { label = "Add to bag", variant = Button.Tonal }
                                [ Button.leadingIcon (Icon.view { name = "add_shopping_cart" })
                                , Button.onClick (AddedToBag product.id qty)
                                ]
                            ]
                        }
                        [ ButtonGroup.variant ButtonGroup.Connected ]
                        |> Element.toNode

                body =
                    Layout.col
                        [ gallery
                        , Layout.div "flex items-center justify-between"
                            [ Layout.span "text-primary"
                                [ Heading.view { label = formatPrice product.price, variant = Heading.Title }
                                    [ Heading.size Heading.Large
                                    , Heading.level 3
                                    ]
                                    |> Element.toNode
                                ]
                            , Node.raw
                                (span [ class "text-label-lg text-on-surface-variant" ]
                                    [ text (categoryLabel product.category) ]
                                )
                            ]
                        , sizeSelect
                        , qtySlider
                        , buyActions
                        ]
            in
            Dialog.view
                { headline = product.name
                , content = [ Element.fromNode body ]
                }
                [ Dialog.open True
                , Dialog.onClose ProductClosed
                , Dialog.dismissible True
                , Dialog.actions
                    [ Button.view { label = "Close", variant = Button.Text }
                        [ Button.onClick ProductClosed ]
                    ]
                ]
                |> Element.toNode


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


viewSnackbar : Model -> Node Msg
viewSnackbar model =
    case model.snackbar of
        Just { message } ->
            Node.element "div"
                [ Node.rawAttr (attribute "data-shrine-snackbar" "true")
                , Node.rawAttr (Html.Events.on "avt-snackbar-action" (Decode.succeed CartOpened))
                ]
                [ Snackbar.view { message = message }
                    [ Snackbar.id "shrine-snackbar"
                    , Snackbar.action "View bag"
                    , Snackbar.dismissible True
                    , Snackbar.duration 4000
                    ]
                    |> Element.toNode
                ]

        Nothing ->
            Node.text ""
