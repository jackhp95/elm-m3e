module Ui.FabMenu exposing
    ( FabMenu, Item
    , Variant(..)
    , new, item
    , withItemLabel
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

@docs withItemLabel


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as HtmlEvents
import M3e.FabMenu
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


{-| Render the FAB menu.
-}
view : FabMenu msg -> Html msg
view (FabMenu cfg) =
    M3e.FabMenu.component
        [ variantAttr cfg.variant
        , Attr.attribute "aria-label" cfg.triggerLabel
        ]
        (List.map itemView cfg.items)


itemView : Item msg -> Html msg
itemView (Item cfg) =
    Html.button
        [ HtmlEvents.onClick cfg.onClick
        , Attr.attribute "aria-label" cfg.label
        , Attr.title cfg.label
        ]
        [ Html.span [ Attr.attribute "aria-hidden" "true" ] [ Ui.Icon.view cfg.icon ]
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
