module Ui.NavigationDrawer exposing
    ( NavigationDrawer, Item
    , Side(..)
    , new, item
    , withId, withSide, withModal, withItemLabel, withItemBadge
    , view
    )

{-| Typed builder for `<m3e-nav-menu>` inside `<m3e-drawer-container>`
— a full-height side panel hosting top-level destinations for
expanded-width viewports. Mirrors the Material 3
[Navigation drawer][m3] surface.

[m3]: https://m3.material.io/components/navigation-drawer/overview

For compact viewports use `Ui.NavigationBar`; for medium viewports use
`Ui.NavigationRail`.


# Modal vs side mode

  - **Modal** (`withModal True`, the default) — overlays content with
    a scrim; closes on outside click. Most common.
  - **Side** (`withModal False`) — sits alongside content as part of
    the layout. Useful for desktop "permanent" drawers.


# Required-by-design

Same shape as `Ui.NavigationBar` / `Ui.NavigationRail`:

  - `new` — items + selected + onChange.
  - `item` — value + icon.


# Quick example

    Ui.NavigationDrawer.new
        { items =
            [ Ui.NavigationDrawer.item { value = Home, icon = home }
                |> Ui.NavigationDrawer.withItemLabel "Home"
            , Ui.NavigationDrawer.item { value = Settings, icon = settings }
                |> Ui.NavigationDrawer.withItemLabel "Settings"
            ]
        , selected = Just state.currentPage
        , onChange = PageChanged
        }
        |> Ui.NavigationDrawer.view


# Type

@docs NavigationDrawer, Item


# Configuration

@docs Side


# Constructors

@docs new, item


# Modifiers

@docs withId, withSide, withModal, withItemLabel, withItemBadge


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as HtmlEvents
import M3e.DrawerContainer
import M3e.NavMenu
import M3e.NavMenuItem
import Ui.Icon



-- TYPES ------------------------------------------------------------------


{-| A navigation drawer.
-}
type NavigationDrawer value msg
    = NavigationDrawer (DrawerConfig value msg)


{-| One destination in a navigation drawer.
-}
type Item value msg
    = Item (ItemConfig value msg)


{-| Which edge of the viewport the drawer anchors to.
-}
type Side
    = Start
    | End


type alias DrawerConfig value msg =
    { id : Maybe String
    , side : Side
    , modal : Bool
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


{-| Construct a navigation drawer.
-}
new :
    { items : List (Item value msg)
    , selected : Maybe value
    , onChange : value -> msg
    }
    -> NavigationDrawer value msg
new c =
    NavigationDrawer
        { id = Nothing
        , side = Start
        , modal = True
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


{-| Set the `id` attribute.
-}
withId : String -> NavigationDrawer value msg -> NavigationDrawer value msg
withId id (NavigationDrawer cfg) =
    NavigationDrawer { cfg | id = Just id }


{-| Anchor edge (default `Start`).
-}
withSide : Side -> NavigationDrawer value msg -> NavigationDrawer value msg
withSide s (NavigationDrawer cfg) =
    NavigationDrawer { cfg | side = s }


{-| Modal (True, default) vs side (False) mode.
-}
withModal : Bool -> NavigationDrawer value msg -> NavigationDrawer value msg
withModal b (NavigationDrawer cfg) =
    NavigationDrawer { cfg | modal = b }


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


{-| Render the navigation drawer to `Html`.
-}
view : NavigationDrawer value msg -> Html msg
view (NavigationDrawer cfg) =
    M3e.DrawerContainer.component
        (List.filterMap identity
            [ Maybe.map Attr.id cfg.id
            , Just (sideAttr cfg)
            , Just (modeAttr cfg)
            ]
        )
        [ M3e.NavMenu.component []
            (List.map (itemView cfg) cfg.items)
        ]


itemView : DrawerConfig value msg -> Item value msg -> Html msg
itemView cfg (Item it) =
    M3e.NavMenuItem.component
        [ M3e.NavMenuItem.selected (cfg.selected == Just it.value)
        , HtmlEvents.onClick (cfg.onChange it.value)
        ]
        (List.concat
            [ [ Html.span [ M3e.NavMenuItem.iconSlot ] [ Ui.Icon.view it.icon ] ]
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
            [ Html.span [ M3e.NavMenuItem.labelSlot ] [ Html.text l ] ]


badgeText : Maybe String -> List (Html msg)
badgeText badge =
    case badge of
        Nothing ->
            []

        Just b ->
            [ Html.span [ M3e.NavMenuItem.badgeSlot ] [ Html.text b ] ]


sideAttr : DrawerConfig value msg -> Html.Attribute msg
sideAttr cfg =
    case cfg.side of
        Start ->
            M3e.DrawerContainer.start True

        End ->
            M3e.DrawerContainer.end True


modeAttr : DrawerConfig value msg -> Html.Attribute msg
modeAttr cfg =
    let
        attrName : String
        attrName =
            case cfg.side of
                Start ->
                    "start-mode"

                End ->
                    "end-mode"

        value : String
        value =
            if cfg.modal then
                "over"

            else
                "side"
    in
    Attr.attribute attrName value
