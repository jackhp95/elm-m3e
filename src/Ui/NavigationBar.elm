module Ui.NavigationBar exposing
    ( NavigationBar, Item
    , Mode(..)
    , new, item
    , withAttributes
    , withId, withMode, withItemLabel, withItemBadge, withItemSelectedIcon
    , view
    )

{-| Typed builder for `<m3e-nav-bar>` — bottom-anchored primary
navigation. Mirrors the Material 3 [Navigation bar][m3] surface.

[m3]: https://m3.material.io/components/navigation-bar/overview

A navigation bar is the **compact/mobile** end of the responsive
top-level-navigation trio: it anchors 3–5 destinations to the bottom of the
screen. As the viewport grows, step up to `Ui.NavigationRail` (side, medium
widths) and then `Ui.NavigationDrawer` (expanded side drawer, large screens).
The choice is content-tied (which layout the caller wants); this module
doesn't pick.


# Required-by-design

`new` requires:

  - `items` — list of destinations.
  - `selected` — currently-active destination value (or `Nothing`).
  - `onChange` — handler receiving the newly-selected typed value.

Each `item` requires:

  - `value` — the destination's typed model value.
  - `icon` — the destination's glyph (per m3 spec, every nav bar item
    has an icon).


# Generic over `value`

Same pattern as `Ui.RadioButton` / `Ui.Select`: selection state stays
typed end-to-end.


# Quick example

    type Page = Home | Inbox | Profile

    Ui.NavigationBar.new
        { items =
            [ Ui.NavigationBar.item { value = Home, icon = home }
                |> Ui.NavigationBar.withItemLabel "Home"
            , Ui.NavigationBar.item { value = Inbox, icon = inbox }
                |> Ui.NavigationBar.withItemLabel "Inbox"
                |> Ui.NavigationBar.withItemBadge "3"
            , Ui.NavigationBar.item { value = Profile, icon = profile }
                |> Ui.NavigationBar.withItemLabel "Profile"
            ]
        , selected = Just state.currentPage
        , onChange = PageChanged
        }
        |> Ui.NavigationBar.view


# Type

@docs NavigationBar, Item


# Configuration

@docs Mode


# Constructors

@docs new, item


# Host attributes

@docs withAttributes


# Modifiers

@docs withId, withMode, withItemLabel, withItemBadge, withItemSelectedIcon


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Html.Events as HtmlEvents
import M3e.Badge
import M3e.NavBar
import M3e.NavItem
import Ui.Icon



-- TYPES ------------------------------------------------------------------


{-| A bottom navigation bar.
-}
type NavigationBar value msg
    = NavigationBar (BarConfig value msg)


{-| One destination in a navigation bar.
-}
type Item value msg
    = Item (ItemConfig value msg)


{-| How items are presented — the `mode` attribute. `Compact` is the m3e
attribute default; `Auto` picks `Compact`/`Expanded` based on available width.
(This builder's `new` defaults the bar to `Auto`.)
-}
type Mode
    = Compact
    | Expanded
    | Auto


type alias BarConfig value msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , mode : Mode
    , items : List (Item value msg)
    , selected : Maybe value
    , onChange : value -> msg
    }


type alias ItemConfig value msg =
    { value : value
    , icon : Ui.Icon.Icon msg
    , selectedIcon : Maybe (Ui.Icon.Icon msg)
    , label : Maybe String
    , badge : Maybe String
    }



-- CONSTRUCTORS -----------------------------------------------------------


{-| Construct a navigation bar.
-}
new :
    { items : List (Item value msg)
    , selected : Maybe value
    , onChange : value -> msg
    }
    -> NavigationBar value msg
new c =
    NavigationBar
        { id = Nothing
        , attributes = []
        , mode = Auto
        , items = c.items
        , selected = c.selected
        , onChange = c.onChange
        }


{-| Construct a destination item.
-}
item : { value : value, icon : Ui.Icon.Icon msg } -> Item value msg
item c =
    Item
        { value = c.value
        , icon = c.icon
        , selectedIcon = Nothing
        , label = Nothing
        , badge = Nothing
        }



-- MODIFIERS --------------------------------------------------------------


{-| Append attributes to the underlying `<m3e-nav-bar>` host element — the
escape hatch for styling the component itself. Structural attributes are
emitted after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> NavigationBar value msg -> NavigationBar value msg
withAttributes attributes (NavigationBar cfg) =
    NavigationBar { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` attribute on the underlying `<m3e-nav-bar>`.
-}
withId : String -> NavigationBar value msg -> NavigationBar value msg
withId id (NavigationBar cfg) =
    NavigationBar { cfg | id = Just id }


{-| Set the rendering mode (default `Auto`).
-}
withMode : Mode -> NavigationBar value msg -> NavigationBar value msg
withMode m (NavigationBar cfg) =
    NavigationBar { cfg | mode = m }


{-| Add a label to an item.
-}
withItemLabel : String -> Item value msg -> Item value msg
withItemLabel label (Item cfg) =
    Item { cfg | label = Just label }


{-| Attach a small badge text to an item (e.g. "3" unread count).
-}
withItemBadge : String -> Item value msg -> Item value msg
withItemBadge badge (Item cfg) =
    Item { cfg | badge = Just badge }


{-| Give an item a distinct glyph for its active state (the `selected-icon`
slot). Shown in place of `icon` while the item is selected.
-}
withItemSelectedIcon : Ui.Icon.Icon msg -> Item value msg -> Item value msg
withItemSelectedIcon icon (Item cfg) =
    Item { cfg | selectedIcon = Just icon }



-- RENDER -----------------------------------------------------------------


{-| Render the navigation bar to `Html`.
-}
view : NavigationBar value msg -> Html msg
view (NavigationBar cfg) =
    M3e.NavBar.component
        (cfg.attributes
            ++ List.filterMap identity
                [ Maybe.map Attr.id cfg.id
                , Just (modeAttr cfg.mode)
                ]
        )
        (List.map (itemView cfg) cfg.items)


itemView : BarConfig value msg -> Item value msg -> Html msg
itemView cfg (Item it) =
    M3e.NavItem.component
        [ M3e.NavItem.selected (cfg.selected == Just it.value)
        , HtmlEvents.onClick (cfg.onChange it.value)
        ]
        (List.concat
            [ [ Html.span [ M3e.NavItem.iconSlot ] [ Ui.Icon.view it.icon ] ]
            , selectedIconSlot it.selectedIcon
            , labelText it.label
            , badgeText it.badge
            ]
        )


{-| Render the `selected-icon` slot when an item supplies a distinct active glyph.
-}
selectedIconSlot : Maybe (Ui.Icon.Icon msg) -> List (Html msg)
selectedIconSlot icon =
    case icon of
        Nothing ->
            []

        Just i ->
            [ Html.span [ M3e.NavItem.selectedIconSlot ] [ Ui.Icon.view i ] ]


{-| The label rides the default slot — `m3e-nav-item` has no `label` slot.
-}
labelText : Maybe String -> List (Html msg)
labelText label =
    case label of
        Nothing ->
            []

        Just l ->
            [ Html.text l ]


{-| There is no `badge` slot on `m3e-nav-item`; compose the count as an
`m3e-badge` element inside the item's default content instead.
-}
badgeText : Maybe String -> List (Html msg)
badgeText badge =
    case badge of
        Nothing ->
            []

        Just b ->
            [ M3e.Badge.component [] [ Html.text b ] ]


modeAttr : Mode -> Html.Attribute msg
modeAttr m =
    case m of
        Compact ->
            M3e.NavBar.mode M3e.NavBar.Compact

        Expanded ->
            M3e.NavBar.mode M3e.NavBar.Expanded

        Auto ->
            M3e.NavBar.mode M3e.NavBar.Auto
