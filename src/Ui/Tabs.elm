module Ui.Tabs exposing
    ( Tabs, Tab
    , new, tab
    , withId, withStretch, withTabIcon, withTabBadge
    , view
    )

{-| Typed builder for `<m3e-tabs>` + `<m3e-tab>` — in-page navigation
between related sections. Mirrors the Material 3 [Tabs][m3] surface.

[m3]: https://m3.material.io/components/tabs/overview

For top-level destinations across pages, use `Ui.NavigationBar` /
`Ui.NavigationRail` / `Ui.NavigationDrawer`. Tabs are for _intra-page_
section switching.


# Type

@docs Tabs, Tab


# Constructors

@docs new, tab


# Modifiers

@docs withId, withStretch, withTabIcon, withTabBadge


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as HtmlEvents
import M3e.Tab
import M3e.Tabs
import Ui.Icon


{-| A tabs strip.
-}
type Tabs value msg
    = Tabs (TabsConfig value msg)


{-| One tab in a strip.
-}
type Tab value msg
    = Tab (TabConfig value msg)


type alias TabsConfig value msg =
    { id : Maybe String
    , stretch : Bool
    , tabs : List (Tab value msg)
    , selected : value
    , onChange : value -> msg
    }


type alias TabConfig value msg =
    { value : value
    , label : String
    , icon : Maybe (Ui.Icon.Icon msg)
    , badge : Maybe String
    }


{-| Construct a tabs strip.
-}
new :
    { tabs : List (Tab value msg)
    , selected : value
    , onChange : value -> msg
    }
    -> Tabs value msg
new c =
    Tabs
        { id = Nothing
        , stretch = False
        , tabs = c.tabs
        , selected = c.selected
        , onChange = c.onChange
        }


{-| Construct a tab.
-}
tab : { value : value, label : String } -> Tab value msg
tab c =
    Tab { value = c.value, label = c.label, icon = Nothing, badge = Nothing }


{-| Set the `id` attribute.
-}
withId : String -> Tabs value msg -> Tabs value msg
withId id (Tabs cfg) =
    Tabs { cfg | id = Just id }


{-| Stretch tabs to fill the container width.
-}
withStretch : Bool -> Tabs value msg -> Tabs value msg
withStretch b (Tabs cfg) =
    Tabs { cfg | stretch = b }


{-| Add an icon to a tab.
-}
withTabIcon : Ui.Icon.Icon msg -> Tab value msg -> Tab value msg
withTabIcon icon (Tab cfg) =
    Tab { cfg | icon = Just icon }


{-| Attach a small badge text to a tab.
-}
withTabBadge : String -> Tab value msg -> Tab value msg
withTabBadge badge (Tab cfg) =
    Tab { cfg | badge = Just badge }


{-| Render the tabs strip.
-}
view : Tabs value msg -> Html msg
view (Tabs cfg) =
    M3e.Tabs.component
        (List.filterMap identity
            [ Maybe.map Attr.id cfg.id
            , Just (M3e.Tabs.stretch cfg.stretch)
            ]
        )
        (List.map (tabView cfg) cfg.tabs)


tabView : TabsConfig value msg -> Tab value msg -> Html msg
tabView cfg (Tab t) =
    M3e.Tab.component
        [ M3e.Tab.selected (cfg.selected == t.value)
        , HtmlEvents.onClick (cfg.onChange t.value)
        ]
        (List.concat
            [ iconPart t.icon
            , [ Html.text t.label ]
            , badgePart t.badge
            ]
        )


iconPart : Maybe (Ui.Icon.Icon msg) -> List (Html msg)
iconPart icon =
    case icon of
        Nothing ->
            []

        Just i ->
            [ Ui.Icon.view i ]


badgePart : Maybe String -> List (Html msg)
badgePart badge =
    case badge of
        Nothing ->
            []

        Just b ->
            [ Html.span [ Attr.attribute "slot" "badge" ] [ Html.text b ] ]
