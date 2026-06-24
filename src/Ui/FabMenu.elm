module Ui.FabMenu exposing
    ( FabMenu, Item
    , Variant(..)
    , new, item
    , withItemLabel, withId
    , view
    )

{-| Typed builder for `<m3e-fab-menu>` — a floating action button that
expands into a small set of actions. Mirrors the Material 3
[FAB menu][m3] surface.

[m3]: https://m3.material.io/components/fab-menu/overview

Use for a few related primary actions at the same screen level. For a
single primary action, prefer `Ui.Fab`.


# Type

@docs FabMenu, Item


# Configuration

@docs Variant


# Constructors

@docs new, item


# Modifiers

@docs withItemLabel, withId


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Json.Decode
import M3e.Fab
import M3e.FabMenu
import M3e.FabMenuTrigger
import M3e.MenuItem
import Ui.Icon


{-| A FAB menu.
-}
type FabMenu msg
    = FabMenu (MenuConfig msg)


{-| One action in a FAB menu.
-}
type Item msg
    = Item (ItemConfig msg)


type alias MenuConfig msg =
    { triggerIcon : Ui.Icon.Icon msg
    , triggerLabel : String
    , variant : Variant
    , menuId : String
    , items : List (Item msg)
    }


type alias ItemConfig msg =
    { icon : Ui.Icon.Icon msg
    , label : String
    , onClick : msg
    }


{-| FAB menu variant.
-}
type Variant
    = Primary
    | Secondary
    | Tertiary


{-| Construct a FAB menu.
-}
new :
    { triggerIcon : Ui.Icon.Icon msg
    , triggerLabel : String
    , variant : Variant
    , items : List (Item msg)
    }
    -> FabMenu msg
new c =
    FabMenu
        { triggerIcon = c.triggerIcon
        , triggerLabel = c.triggerLabel
        , variant = c.variant
        , menuId = "fab-menu"
        , items = c.items
        }


{-| Construct one item in a FAB menu.
-}
item : { icon : Ui.Icon.Icon msg, label : String, onClick : msg } -> Item msg
item =
    Item


{-| Set the visible label on a FAB menu item.
-}
withItemLabel : String -> Item msg -> Item msg
withItemLabel label (Item cfg) =
    Item { cfg | label = label }


{-| Override the DOM id used to link the trigger to the menu (via the
trigger's `for` attribute). Defaults to `"fab-menu"`. Set a unique id
when rendering more than one FAB menu on a page.
-}
withId : String -> FabMenu msg -> FabMenu msg
withId menuId (FabMenu cfg) =
    FabMenu { cfg | menuId = menuId }


{-| Render the FAB menu.

Emits an opener (`m3e-fab` carrying the trigger icon plus a nested
`m3e-fab-menu-trigger` whose `for` references the menu) followed by the
`m3e-fab-menu` container holding the actions as `m3e-menu-item`s.

-}
view : FabMenu msg -> Html msg
view (FabMenu cfg) =
    Html.div []
        [ M3e.Fab.component
            [ Attr.attribute "aria-label" cfg.triggerLabel ]
            [ Html.span [ Attr.attribute "aria-hidden" "true" ] [ Ui.Icon.view cfg.triggerIcon ]
            , M3e.FabMenuTrigger.component
                [ M3e.FabMenuTrigger.for cfg.menuId ]
                []
            ]
        , M3e.FabMenu.component
            [ Attr.id cfg.menuId
            , variantAttr cfg.variant
            ]
            (List.map itemView cfg.items)
        ]


itemView : Item msg -> Html msg
itemView (Item cfg) =
    M3e.MenuItem.component
        [ M3e.MenuItem.onClick (Json.Decode.succeed cfg.onClick) ]
        [ Html.span [ M3e.MenuItem.iconSlot, Attr.attribute "aria-hidden" "true" ]
            [ Ui.Icon.view cfg.icon ]
        , Html.text cfg.label
        ]


variantAttr : Variant -> Html.Attribute msg
variantAttr v =
    case v of
        Primary ->
            M3e.FabMenu.variant M3e.FabMenu.Primary

        Secondary ->
            M3e.FabMenu.variant M3e.FabMenu.Secondary

        Tertiary ->
            M3e.FabMenu.variant M3e.FabMenu.Tertiary
