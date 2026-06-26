module Ui.FabMenu exposing
    ( FabMenu, Item
    , Variant(..)
    , new, item
    , withAttributes
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


# Host attributes

@docs withAttributes


# Modifiers

@docs withItemLabel, withId


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Json.Decode
import Cem.M3e.Fab
import Cem.M3e.FabMenu
import Cem.M3e.FabMenuTrigger
import Cem.M3e.MenuItem
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
    , attributes : List (Attribute msg)
    , items : List (Item msg)
    }


type alias ItemConfig msg =
    { icon : Ui.Icon.Icon msg
    , label : String
    , onClick : msg
    }


{-| Appearance variant of the expanded menu surface (m3e `m3e-fab-menu`
`variant`, default `primary`).
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
        , attributes = []
        , items = c.items
        }


{-| Construct one item in a FAB menu.
-}
item : { icon : Ui.Icon.Icon msg, label : String, onClick : msg } -> Item msg
item =
    Item


{-| Append attributes to the wrapper `<div>` around the FAB trigger and menu —
the escape hatch for positioning/styling the whole menu unit. The trigger's own
structural attributes are unaffected.
-}
withAttributes : List (Attribute msg) -> FabMenu msg -> FabMenu msg
withAttributes attributes (FabMenu cfg) =
    FabMenu { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the visible label on a FAB menu item (the item's default slot).
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
    Html.div cfg.attributes
        [ Cem.M3e.Fab.component
            [ Attr.attribute "aria-label" cfg.triggerLabel ]
            [ Html.span [ Attr.attribute "aria-hidden" "true" ] [ Ui.Icon.view cfg.triggerIcon ]
            , Cem.M3e.FabMenuTrigger.component
                [ Cem.M3e.FabMenuTrigger.for cfg.menuId ]
                []
            ]
        , Cem.M3e.FabMenu.component
            [ Attr.id cfg.menuId
            , variantAttr cfg.variant
            ]
            (List.map itemView cfg.items)
        ]


itemView : Item msg -> Html msg
itemView (Item cfg) =
    Cem.M3e.MenuItem.component
        [ Cem.M3e.MenuItem.onClick (Json.Decode.succeed cfg.onClick) ]
        [ Html.span [ Cem.M3e.MenuItem.iconSlot, Attr.attribute "aria-hidden" "true" ]
            [ Ui.Icon.view cfg.icon ]
        , Html.text cfg.label
        ]


variantAttr : Variant -> Html.Attribute msg
variantAttr v =
    case v of
        Primary ->
            Cem.M3e.FabMenu.variant Cem.M3e.FabMenu.Primary

        Secondary ->
            Cem.M3e.FabMenu.variant Cem.M3e.FabMenu.Secondary

        Tertiary ->
            Cem.M3e.FabMenu.variant Cem.M3e.FabMenu.Tertiary
