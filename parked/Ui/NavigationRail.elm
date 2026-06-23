module Ui.NavigationRail exposing
    ( NavigationRail, Item
    , Mode(..)
    , new, item
    , withId, withMode, withItemLabel, withItemBadge
    , view
    )

{-| Typed builder for `<m3e-nav-rail>` — side-anchored primary
navigation for medium-width viewports. Mirrors the Material 3
[Navigation rail][m3] surface.

[m3]: https://m3.material.io/components/navigation-rail/overview

For compact viewports use `Ui.NavigationBar`; for expanded viewports
use `Ui.NavigationDrawer`. The viewport choice is content-tied and
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


# Modifiers

@docs withId, withMode, withItemLabel, withItemBadge


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as HtmlEvents
import M3e.NavMenuItem
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


{-| Mode (m3e). `Auto` picks compact/expanded based on width.
-}
type Mode
    = Compact
    | Expanded
    | Auto


type alias RailConfig value msg =
    { id : Maybe String
    , mode : Mode
    , items : List (Item value msg)
    , selected : Maybe value
    , onChange : value -> msg
    }


type alias ItemConfig value msg =
    { value : value
    , icon : Ui.Icon.Icon msg
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
        , label = Nothing
        , badge = Nothing
        }



-- MODIFIERS --------------------------------------------------------------


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



-- RENDER -----------------------------------------------------------------


{-| Render the navigation rail to `Html`.
-}
view : NavigationRail value msg -> Html msg
view (NavigationRail cfg) =
    M3e.NavRail.component
        (List.filterMap identity
            [ Maybe.map Attr.id cfg.id
            , Just (modeAttr cfg.mode)
            ]
        )
        (List.map (itemView cfg) cfg.items)


itemView : RailConfig value msg -> Item value msg -> Html msg
itemView cfg (Item it) =
    M3e.NavMenuItem.component
        [ M3e.NavMenuItem.selected (cfg.selected == Just it.value)
        , HtmlEvents.onClick (cfg.onChange it.value)
        ]
        (List.concat
            [ [ Ui.Icon.view it.icon ]
            , labelText it.label
            , badgeText it.badge
            ]
        )


labelText : Maybe String -> List (Html msg)
labelText label =
    case label of
        Nothing ->
            []

        Just l ->
            [ Html.text l ]


badgeText : Maybe String -> List (Html msg)
badgeText badge =
    case badge of
        Nothing ->
            []

        Just b ->
            [ Html.span [ Attr.attribute "slot" "badge" ] [ Html.text b ] ]


modeAttr : Mode -> Html.Attribute msg
modeAttr m =
    case m of
        Compact ->
            M3e.NavRail.modeCompact

        Expanded ->
            M3e.NavRail.modeExpanded

        Auto ->
            M3e.NavRail.modeAuto
