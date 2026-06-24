module Ui.Menu exposing
    ( Menu, Item
    , new, item
    , withAttributes
    , withId, withSubmenu, withItemIcon, withItemHref, withItemDisabled
    , view
    )

{-| Typed builder for `<m3e-menu>` — an action menu that opens from a
button or other trigger. Mirrors the Material 3 [Menus][m3] surface.

[m3]: https://m3.material.io/components/menus/overview

For a form-control single/multi-select dropdown, see `Ui.Select`.


# Required-by-design

`new` requires the list of items. Each `item` requires:

  - `label` — visible row text.
  - `onClick` — handler that fires when the row is activated.


# Quick example

    Ui.Menu.new
        [ Ui.Menu.item "Edit" EditClicked
            |> Ui.Menu.withItemIcon (Ui.Icon.fontAwesome Icon.FontAwesome.pen)
        , Ui.Menu.item "Duplicate" DuplicateClicked
        , Ui.Menu.item "Delete" DeleteClicked
            |> Ui.Menu.withItemDisabled True
        ]
        |> Ui.Menu.view


# Type

@docs Menu, Item


# Constructors

@docs new, item


# Host attributes

@docs withAttributes


# Modifiers

@docs withId, withSubmenu, withItemIcon, withItemHref, withItemDisabled


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Html.Events as HtmlEvents
import M3e.Menu
import M3e.MenuItem
import Ui.Icon



-- TYPES ------------------------------------------------------------------


{-| A menu.
-}
type Menu msg
    = Menu (MenuConfig msg)


{-| One row in a menu.
-}
type Item msg
    = Item (ItemConfig msg)


type alias MenuConfig msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , submenu : Bool
    , items : List (Item msg)
    }


type alias ItemConfig msg =
    { label : String
    , onClick : msg
    , icon : Maybe (Ui.Icon.Icon msg)
    , href : Maybe String
    , disabled : Bool
    }



-- CONSTRUCTORS -----------------------------------------------------------


{-| Construct a menu from items.
-}
new : List (Item msg) -> Menu msg
new items =
    Menu { id = Nothing, attributes = [], submenu = False, items = items }


{-| Construct a menu item.
-}
item : String -> msg -> Item msg
item label msg =
    Item
        { label = label
        , onClick = msg
        , icon = Nothing
        , href = Nothing
        , disabled = False
        }



-- MODIFIERS --------------------------------------------------------------


{-| Append attributes to the underlying `<m3e-menu>` host element — the
escape hatch for styling the component itself. Structural attributes are
emitted after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> Menu msg -> Menu msg
withAttributes attributes (Menu cfg) =
    Menu { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` attribute on the underlying `<m3e-menu>`.
-}
withId : String -> Menu msg -> Menu msg
withId id (Menu cfg) =
    Menu { cfg | id = Just id }


{-| Mark this menu as a submenu (rendered as a flyout off another menu's row).
-}
withSubmenu : Bool -> Menu msg -> Menu msg
withSubmenu b (Menu cfg) =
    Menu { cfg | submenu = b }


{-| Add a leading icon to a menu item.
-}
withItemIcon : Ui.Icon.Icon msg -> Item msg -> Item msg
withItemIcon icon (Item cfg) =
    Item { cfg | icon = Just icon }


{-| Make this item a link (navigates instead of dispatching).
-}
withItemHref : String -> Item msg -> Item msg
withItemHref href (Item cfg) =
    Item { cfg | href = Just href }


{-| Mark this item disabled.
-}
withItemDisabled : Bool -> Item msg -> Item msg
withItemDisabled b (Item cfg) =
    Item { cfg | disabled = b }



-- RENDER -----------------------------------------------------------------


{-| Render the menu to `Html`.
-}
view : Menu msg -> Html msg
view (Menu cfg) =
    M3e.Menu.component
        (cfg.attributes
            ++ List.filterMap identity
                [ Maybe.map Attr.id cfg.id
                , Just (M3e.Menu.submenu cfg.submenu)
                ]
        )
        (List.map itemView cfg.items)


itemView : Item msg -> Html msg
itemView (Item cfg) =
    M3e.MenuItem.component
        (List.filterMap identity
            [ Maybe.map M3e.MenuItem.href cfg.href
            , Just (Attr.disabled cfg.disabled)
            , Just (HtmlEvents.onClick cfg.onClick)
            ]
        )
        (List.concat
            [ iconSlot cfg.icon
            , [ Html.text cfg.label ]
            ]
        )


iconSlot : Maybe (Ui.Icon.Icon msg) -> List (Html msg)
iconSlot icon =
    case icon of
        Nothing ->
            []

        Just i ->
            [ Html.span [ M3e.MenuItem.iconSlot ] [ Ui.Icon.view i ] ]
