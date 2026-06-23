module Ui.NavigationBar exposing
    ( NavigationBar, Item
    , Mode(..)
    , new, item
    , withId, withMode, withItemLabel, withItemBadge
    , view
    )

{-| Typed builder for `<m3e-nav-bar>` — bottom-anchored primary
navigation. Mirrors the Material 3 [Navigation bar][m3] surface.

[m3]: https://m3.material.io/components/navigation-bar/overview

Navigation bars host top-level destinations for compact viewports. For
medium viewports, use `Ui.NavigationRail`; for expanded viewports,
`Ui.NavigationDrawer`. The choice is content-tied (which layout the
caller wants); this module doesn't pick.


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


# Modifiers

@docs withId, withMode, withItemLabel, withItemBadge


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as HtmlEvents
import M3e.NavBar
import M3e.NavMenuItem
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


{-| Mode (m3e). `Auto` picks compact/expanded based on width.
-}
type Mode
    = Compact
    | Expanded
    | Auto


type alias BarConfig value msg =
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



-- RENDER -----------------------------------------------------------------


{-| Render the navigation bar to `Html`.
-}
view : NavigationBar value msg -> Html msg
view (NavigationBar cfg) =
    M3e.NavBar.component
        (List.filterMap identity
            [ Maybe.map Attr.id cfg.id
            , Just (modeAttr cfg.mode)
            ]
        )
        (List.map (itemView cfg) cfg.items)


itemView : BarConfig value msg -> Item value msg -> Html msg
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
            (M3e.NavBar.mode M3e.NavBar.Compact)

        Expanded ->
            (M3e.NavBar.mode M3e.NavBar.Expanded)

        Auto ->
            (M3e.NavBar.mode M3e.NavBar.Auto)
