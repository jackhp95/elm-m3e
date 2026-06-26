module Ui.NavigationRail exposing
    ( NavigationRail, Item
    , Mode(..)
    , new, item
    , withAttributes
    , withId, withMode, withItemLabel, withItemBadge, withItemSelectedIcon
    , view
    )

{-| Typed builder for `<m3e-nav-rail>` — side-anchored primary
navigation for medium-width viewports. Mirrors the Material 3
[Navigation rail][m3] surface.

[m3]: https://m3.material.io/components/navigation-rail/overview

The rail is the **medium-width** middle of the responsive
top-level-navigation trio: for compact viewports step down to
`Ui.NavigationBar` (bottom bar); for expanded viewports step up to
`Ui.NavigationDrawer` (side drawer). The viewport choice is content-tied and
made by the caller — m3 documents the three as distinct components.


# Required-by-design

Same shape as `Ui.NavigationBar`:

  - `new` — items + selected + onChange.
  - `item` — value + icon (every nav-rail destination has a glyph).


# Generic over `value`

Selection state stays typed end-to-end.


# Quick example

    Ui.NavigationRail.new
        { items =
            [ Ui.NavigationRail.item { value = Home, icon = home }
                |> Ui.NavigationRail.withItemLabel "Home"
            , Ui.NavigationRail.item { value = Profile, icon = profile }
                |> Ui.NavigationRail.withItemLabel "Profile"
            ]
        , selected = Just state.currentPage
        , onChange = PageChanged
        }
        |> Ui.NavigationRail.view


# Type

@docs NavigationRail, Item


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
import M3e.NavItem
import M3e.NavRail
import Ui.Icon



-- TYPES ------------------------------------------------------------------


{-| A navigation rail.
-}
type NavigationRail value msg
    = NavigationRail (RailConfig value msg)


{-| One destination in a navigation rail.
-}
type Item value msg
    = Item (ItemConfig value msg)


{-| How items are presented — the `mode` attribute. `Compact` is the m3e
attribute default (icons only); `Expanded` shows labels; `Auto` switches
between them based on available width. (This builder's `new` defaults the
rail to `Auto`.)
-}
type Mode
    = Compact
    | Expanded
    | Auto


type alias RailConfig value msg =
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


{-| Construct a navigation rail.
-}
new :
    { items : List (Item value msg)
    , selected : Maybe value
    , onChange : value -> msg
    }
    -> NavigationRail value msg
new c =
    NavigationRail
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


{-| Append attributes to the underlying `<m3e-…>` host element — the escape
hatch for styling the component itself. Structural attributes are emitted
after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> NavigationRail value msg -> NavigationRail value msg
withAttributes attributes (NavigationRail cfg) =
    NavigationRail { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` attribute on the underlying `<m3e-nav-rail>`.
-}
withId : String -> NavigationRail value msg -> NavigationRail value msg
withId id (NavigationRail cfg) =
    NavigationRail { cfg | id = Just id }


{-| Set the rendering mode (default `Auto`).
-}
withMode : Mode -> NavigationRail value msg -> NavigationRail value msg
withMode m (NavigationRail cfg) =
    NavigationRail { cfg | mode = m }


{-| Add a label to an item.
-}
withItemLabel : String -> Item value msg -> Item value msg
withItemLabel label (Item cfg) =
    Item { cfg | label = Just label }


{-| Attach a small badge text to an item.
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


{-| Render the navigation rail to `Html`.
-}
view : NavigationRail value msg -> Html msg
view (NavigationRail cfg) =
    M3e.NavRail.component
        (cfg.attributes
            ++ List.filterMap identity
                [ Maybe.map Attr.id cfg.id
                , Just (modeAttr cfg.mode)
                ]
        )
        (List.map (itemView cfg) cfg.items)


itemView : RailConfig value msg -> Item value msg -> Html msg
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
            M3e.NavRail.mode M3e.NavRail.Compact

        Expanded ->
            M3e.NavRail.mode M3e.NavRail.Expanded

        Auto ->
            M3e.NavRail.mode M3e.NavRail.Auto
