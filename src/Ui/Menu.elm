module Ui.Menu exposing
    ( Menu, Item
    , PositionX(..), PositionY(..)
    , new, item, checkboxItem, radioItem, group
    , withAttributes
    , withId, withSubmenu, withPositionX, withPositionY, withOnToggle
    , triggerFor, withTriggerIcon
    , withItemIcon, withItemTrailingIcon, withItemHref, withItemDisabled
    , withItemChecked, withItemSelected
    , view
    )

{-| Typed builder for `<m3e-menu>` — an action menu that opens from a
button or other trigger. Mirrors the Material 3 [Menus][m3] surface.

[m3]: https://m3.material.io/components/menus/overview

For a form-control single/multi-select dropdown, see `Ui.Select`.


# Opening a menu

A menu opens from an `<m3e-menu-trigger>` nested inside a clickable, linked to
the menu by a shared `id`. Open/close is element-managed — no `Model` state to
wire. Two ways:

  - **Bring your own trigger** — nest [`triggerFor`](#triggerFor) inside any
    control via its `withExtraContent` (e.g. `Ui.IconButton`, `Ui.Button`), and
    give the menu the same `id` via [`withId`](#withId):

        Ui.IconButton.new { icon = overflow, label = "More", variant = Ui.IconButton.Standard }
            |> Ui.IconButton.withExtraContent [ Ui.Menu.triggerFor "row-actions" ]
            |> Ui.IconButton.view

        Ui.Menu.new [ … ] |> Ui.Menu.withId "row-actions" |> Ui.Menu.view

  - **Convenience trigger** — [`withTriggerIcon`](#withTriggerIcon) renders an
    icon button (with the nested trigger) and the menu together, auto-linked:

        Ui.Menu.new [ … ]
            |> Ui.Menu.withTriggerIcon { icon = overflow, label = "More" }
            |> Ui.Menu.view


# Required-by-design

`new` requires the list of items. Item constructors:

  - `item` — a plain action row (`<m3e-menu-item>`); requires a `label`
    and an `onClick` handler.
  - `checkboxItem` — a togglable row (`<m3e-menu-item-checkbox>`);
    requires a `label` and a handler receiving the new checked state.
    Drive the displayed state with [`withItemChecked`](#withItemChecked).
  - `radioItem` — a mutually-exclusive row (`<m3e-menu-item-radio>`);
    requires a `label` and a selection handler. Mark the chosen one with
    [`withItemSelected`](#withItemSelected) and group related radios with
    [`group`](#group).
  - `group` — a labelled grouping of related items
    (`<m3e-menu-item-group>`), typically radios.


# Quick example

    Ui.Menu.new
        [ Ui.Menu.item "Edit" EditClicked
            |> Ui.Menu.withItemIcon (Ui.Icon.fontAwesome Icon.FontAwesome.pen)
        , Ui.Menu.checkboxItem "Show grid" GridToggled
            |> Ui.Menu.withItemChecked model.showGrid
        , Ui.Menu.group "Alignment"
            [ Ui.Menu.radioItem "Left" (Align Left)
                |> Ui.Menu.withItemSelected (model.align == Left)
            , Ui.Menu.radioItem "Right" (Align Right)
                |> Ui.Menu.withItemSelected (model.align == Right)
            ]
        ]
        |> Ui.Menu.view


# Type

@docs Menu, Item
@docs PositionX, PositionY


# Constructors

@docs new, item, checkboxItem, radioItem, group


# Host attributes

@docs withAttributes


# Menu modifiers

@docs withId, withSubmenu, withPositionX, withPositionY, withOnToggle


# Trigger

@docs triggerFor, withTriggerIcon


# Item modifiers

@docs withItemIcon, withItemTrailingIcon, withItemHref, withItemDisabled
@docs withItemChecked, withItemSelected


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Html.Events as HtmlEvents
import Json.Decode as Decode
import M3e.Menu
import M3e.MenuItem
import M3e.MenuItemCheckbox
import M3e.MenuItemGroup
import M3e.MenuItemRadio
import M3e.MenuTrigger
import Ui.Icon
import Ui.IconButton



-- TYPES ------------------------------------------------------------------


{-| A menu.
-}
type Menu msg
    = Menu (MenuConfig msg)


{-| One entry in a menu. Which `<m3e-*>` element it renders is fixed by the
constructor used to make it ([`item`](#item), [`checkboxItem`](#checkboxItem),
[`radioItem`](#radioItem), or [`group`](#group)); a modifier that does not
apply to an entry's kind is a no-op.
-}
type Item msg
    = Item (ItemConfig msg)
    | Group (GroupConfig msg)


type alias MenuConfig msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , submenu : Bool
    , positionX : Maybe PositionX
    , positionY : Maybe PositionY
    , onToggle : Maybe (Bool -> msg)
    , trigger : Maybe { icon : Ui.Icon.Icon msg, label : String }
    , items : List (Item msg)
    }


{-| The menu's position on the x-axis, relative to its trigger. Default `After`.
-}
type PositionX
    = After
    | Before


{-| The menu's position on the y-axis, relative to its trigger. Default `Below`.
-}
type PositionY
    = Above
    | Below


type alias ItemConfig msg =
    { label : String
    , icon : Maybe (Ui.Icon.Icon msg)
    , trailingIcon : Maybe (Ui.Icon.Icon msg)
    , href : Maybe String
    , disabled : Bool
    , kind : ItemKind msg
    }


type alias GroupConfig msg =
    { label : String
    , items : List (Item msg)
    }


{-| Per-entry kind-specific state. Internal — the element is selected from
this, never inferred from modifier presence.
-}
type ItemKind msg
    = Standard msg
    | Checkbox { checked : Bool, onChange : Bool -> msg }
    | Radio { selected : Bool, onClick : msg }



-- CONSTRUCTORS -----------------------------------------------------------


{-| Construct a menu from items.
-}
new : List (Item msg) -> Menu msg
new items =
    Menu
        { id = Nothing
        , attributes = []
        , submenu = False
        , positionX = Nothing
        , positionY = Nothing
        , onToggle = Nothing
        , trigger = Nothing
        , items = items
        }


emptyItem : ItemKind msg -> String -> Item msg
emptyItem kind label =
    Item
        { label = label
        , icon = Nothing
        , trailingIcon = Nothing
        , href = Nothing
        , disabled = False
        , kind = kind
        }


{-| Construct a plain action menu item (`<m3e-menu-item>`). `onClick` fires
when the row is activated.
-}
item : String -> msg -> Item msg
item label msg =
    emptyItem (Standard msg) label


{-| Construct a checkable menu item (`<m3e-menu-item-checkbox>`). The handler
receives the new checked state when toggled (the opposite of the current
[`withItemChecked`](#withItemChecked) state).
-}
checkboxItem : String -> (Bool -> msg) -> Item msg
checkboxItem label onChange =
    emptyItem (Checkbox { checked = False, onChange = onChange }) label


{-| Construct a mutually-exclusive menu item (`<m3e-menu-item-radio>`).
`onSelect` fires when the row is chosen. Mark the active one with
[`withItemSelected`](#withItemSelected); group related radios with
[`group`](#group).
-}
radioItem : String -> msg -> Item msg
radioItem label onSelect =
    emptyItem (Radio { selected = False, onClick = onSelect }) label


{-| Construct a labelled grouping of related items
(`<m3e-menu-item-group>`), typically [`radioItem`](#radioItem)s. The label
fills the group's `label` slot.
-}
group : String -> List (Item msg) -> Item msg
group label items =
    Group { label = label, items = items }



-- MENU MODIFIERS ---------------------------------------------------------


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


{-| Set the menu's horizontal position relative to its trigger.
-}
withPositionX : PositionX -> Menu msg -> Menu msg
withPositionX p (Menu cfg) =
    Menu { cfg | positionX = Just p }


{-| Set the menu's vertical position relative to its trigger.
-}
withPositionY : PositionY -> Menu msg -> Menu msg
withPositionY p (Menu cfg) =
    Menu { cfg | positionY = Just p }


{-| React to the menu opening or closing. The handler receives `True` when the
menu opens, `False` when it closes. (Open/close itself is element-managed; this
is only for observing the state.)
-}
withOnToggle : (Bool -> msg) -> Menu msg -> Menu msg
withOnToggle toMsg (Menu cfg) =
    Menu { cfg | onToggle = Just toMsg }


{-| The trigger marker (`<m3e-menu-trigger for="…">`). Nest it inside a
clickable control via that control's `withExtraContent`, passing the same `id`
you give the menu via [`withId`](#withId); activating the control opens the
menu.
-}
triggerFor : String -> Html msg
triggerFor menuId =
    M3e.MenuTrigger.component [ M3e.MenuTrigger.for menuId ] []


{-| Render a convenience icon-button trigger (with the nested marker) alongside
the menu, auto-linked. The icon button is a `Standard` `Ui.IconButton` carrying
`label` as its accessible name. For any other trigger control, use
[`triggerFor`](#triggerFor) instead. The link `id` is [`withId`](#withId) if
set, else derived from the label.
-}
withTriggerIcon : { icon : Ui.Icon.Icon msg, label : String } -> Menu msg -> Menu msg
withTriggerIcon t (Menu cfg) =
    Menu { cfg | trigger = Just t }



-- ITEM MODIFIERS ---------------------------------------------------------


{-| Map the shared config of an item entry; a no-op on a [`group`](#group).
-}
mapConfig : (ItemConfig msg -> ItemConfig msg) -> Item msg -> Item msg
mapConfig f item_ =
    case item_ of
        Item cfg ->
            Item (f cfg)

        Group _ ->
            item_


{-| Map the kind-specific state of an item entry; a no-op on a group.
-}
mapKind : (ItemKind msg -> ItemKind msg) -> Item msg -> Item msg
mapKind f =
    mapConfig (\cfg -> { cfg | kind = f cfg.kind })


{-| Add a leading icon to a menu item.
-}
withItemIcon : Ui.Icon.Icon msg -> Item msg -> Item msg
withItemIcon icon =
    mapConfig (\cfg -> { cfg | icon = Just icon })


{-| Add a trailing icon to a menu item (the `trailing-icon` slot, after the
label).
-}
withItemTrailingIcon : Ui.Icon.Icon msg -> Item msg -> Item msg
withItemTrailingIcon icon =
    mapConfig (\cfg -> { cfg | trailingIcon = Just icon })


{-| Make this item a link (navigates instead of dispatching). Only honoured
on a plain [`item`](#item); `<m3e-menu-item-checkbox>` / `-radio` are not
links.
-}
withItemHref : String -> Item msg -> Item msg
withItemHref href =
    mapConfig (\cfg -> { cfg | href = Just href })


{-| Mark this item disabled.
-}
withItemDisabled : Bool -> Item msg -> Item msg
withItemDisabled b =
    mapConfig (\cfg -> { cfg | disabled = b })


{-| Set whether a [`checkboxItem`](#checkboxItem) is checked. A no-op on
other entry kinds.
-}
withItemChecked : Bool -> Item msg -> Item msg
withItemChecked b =
    mapKind
        (\kind ->
            case kind of
                Checkbox data ->
                    Checkbox { data | checked = b }

                _ ->
                    kind
        )


{-| Set whether a [`radioItem`](#radioItem) is the selected one in its group.
A no-op on other entry kinds.
-}
withItemSelected : Bool -> Item msg -> Item msg
withItemSelected b =
    mapKind
        (\kind ->
            case kind of
                Radio data ->
                    Radio { data | selected = b }

                _ ->
                    kind
        )



-- RENDER -----------------------------------------------------------------


{-| Render the menu to `Html`. With a convenience trigger
([`withTriggerIcon`](#withTriggerIcon)) the result is the trigger button and the
menu together (wrapped in a layout-neutral `display:contents` span); otherwise
it is the bare `<m3e-menu>` (place your own [`triggerFor`](#triggerFor)).
-}
view : Menu msg -> Html msg
view (Menu cfg) =
    case cfg.trigger of
        Nothing ->
            menuElement cfg cfg.id

        Just t ->
            let
                menuId : String
                menuId =
                    Maybe.withDefault ("uimenu-" ++ slugify t.label) cfg.id
            in
            Html.span [ Attr.style "display" "contents" ]
                [ Ui.IconButton.new
                    { icon = t.icon, label = t.label, variant = Ui.IconButton.Standard }
                    |> Ui.IconButton.withExtraContent [ triggerFor menuId ]
                    |> Ui.IconButton.view
                , menuElement cfg (Just menuId)
                ]


menuElement : MenuConfig msg -> Maybe String -> Html msg
menuElement cfg menuId =
    M3e.Menu.component
        (cfg.attributes
            ++ List.filterMap identity
                [ Maybe.map Attr.id menuId
                , Just (M3e.Menu.submenu cfg.submenu)
                , Maybe.map positionXAttr cfg.positionX
                , Maybe.map positionYAttr cfg.positionY
                , Maybe.map onToggleAttr cfg.onToggle
                ]
        )
        (List.map itemView cfg.items)


positionXAttr : PositionX -> Attribute msg
positionXAttr p =
    M3e.Menu.positionX
        (case p of
            After ->
                M3e.Menu.After

            Before ->
                M3e.Menu.Before
        )


positionYAttr : PositionY -> Attribute msg
positionYAttr p =
    M3e.Menu.positionY
        (case p of
            Above ->
                M3e.Menu.Above

            Below ->
                M3e.Menu.Below
        )


onToggleAttr : (Bool -> msg) -> Attribute msg
onToggleAttr toMsg =
    -- m3e-menu dispatches a standard ToggleEvent; `newState` is "open"/"closed".
    M3e.Menu.onToggle
        (Decode.at [ "newState" ] Decode.string
            |> Decode.map (\s -> toMsg (s == "open"))
        )


slugify : String -> String
slugify label =
    label
        |> String.toLower
        |> String.toList
        |> List.map
            (\c ->
                if Char.isAlphaNum c then
                    c

                else
                    '-'
            )
        |> String.fromList
        |> String.split "-"
        |> List.filter (not << String.isEmpty)
        |> String.join "-"


itemView : Item msg -> Html msg
itemView item_ =
    case item_ of
        Group g ->
            M3e.MenuItemGroup.component []
                (groupLabel g.label :: List.map itemView g.items)

        Item cfg ->
            case cfg.kind of
                Standard onClick ->
                    M3e.MenuItem.component
                        (List.filterMap identity
                            [ Maybe.map M3e.MenuItem.href cfg.href
                            , Just (M3e.MenuItem.disabled cfg.disabled)
                            , Just (HtmlEvents.onClick onClick)
                            ]
                        )
                        (itemChildren cfg)

                Checkbox data ->
                    M3e.MenuItemCheckbox.component
                        [ M3e.MenuItemCheckbox.checked data.checked
                        , M3e.MenuItemCheckbox.disabled cfg.disabled
                        , HtmlEvents.onClick (data.onChange (not data.checked))
                        ]
                        (itemChildren cfg)

                Radio data ->
                    M3e.MenuItemRadio.component
                        [ M3e.MenuItemRadio.checked data.selected
                        , M3e.MenuItemRadio.disabled cfg.disabled
                        , HtmlEvents.onClick data.onClick
                        ]
                        (itemChildren cfg)


itemChildren : ItemConfig msg -> List (Html msg)
itemChildren cfg =
    List.concat
        [ iconSlot cfg.icon
        , [ Html.text cfg.label ]
        , trailingIconSlot cfg.trailingIcon
        ]


groupLabel : String -> Html msg
groupLabel label =
    -- `m3e-menu-item-group` exposes a `label` slot (per the element docs);
    -- the binding does not surface a slot helper, so the slot attribute is
    -- written directly here.
    Html.span [ Attr.attribute "slot" "label" ] [ Html.text label ]


iconSlot : Maybe (Ui.Icon.Icon msg) -> List (Html msg)
iconSlot icon =
    case icon of
        Nothing ->
            []

        Just i ->
            [ Html.span [ M3e.MenuItem.iconSlot ] [ Ui.Icon.view i ] ]


trailingIconSlot : Maybe (Ui.Icon.Icon msg) -> List (Html msg)
trailingIconSlot icon =
    case icon of
        Nothing ->
            []

        Just i ->
            [ Html.span [ M3e.MenuItem.trailingIconSlot ] [ Ui.Icon.view i ] ]
