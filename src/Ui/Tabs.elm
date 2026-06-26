module Ui.Tabs exposing
    ( Tabs, Tab
    , new, tab
    , withAttributes
    , withId, withStretch, withTabIcon, withTabBadge
    , Variant(..), withVariant
    , HeaderPosition(..), withHeaderPosition
    , withPanel
    , withNextIcon, withPrevIcon
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


# Host attributes

@docs withAttributes


# Modifiers

@docs withId, withStretch, withTabIcon, withTabBadge


# Appearance

@docs Variant, withVariant
@docs HeaderPosition, withHeaderPosition


# Panels

A tab can carry the content it switches to. `withPanel` renders that content
as an `<m3e-tab-panel>` into the tabs' `panel` slot, associated to its tab by
the `for`/`id` mechanism the element uses (`<m3e-tab for=X>` ↔
`<m3e-tab-panel id=X>`). Panels are optional: tabs built without one keep the
strip-only behaviour.

@docs withPanel


# Pagination icons

@docs withNextIcon, withPrevIcon


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Html.Events as HtmlEvents
import Cem.M3e.Badge
import Cem.M3e.Tab
import Cem.M3e.TabPanel
import Cem.M3e.Tabs
import Ui.Icon


{-| A tabs strip.
-}
type Tabs value msg
    = Tabs (TabsConfig value msg)


{-| One tab in a strip.
-}
type Tab value msg
    = Tab (TabConfig value msg)


{-| The appearance variant of the tabs, mirroring the `m3e-tabs` `variant`
enum. `Secondary` (the element default) is a subtler presentation with a
thinner active indicator; `Primary` emphasizes the indicator and shape.
-}
type Variant
    = Primary
    | Secondary


{-| Where the tab headers sit relative to their panels, mirroring the
`m3e-tabs` `header-position` enum. `Before` (the element default) places the
header strip ahead of the panels; `After` places it after.
-}
type HeaderPosition
    = Before
    | After


type alias TabsConfig value msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , stretch : Bool
    , variant : Variant
    , headerPosition : HeaderPosition
    , tabs : List (Tab value msg)
    , selected : value
    , onChange : value -> msg
    , nextIcon : Maybe (Ui.Icon.Icon msg)
    , prevIcon : Maybe (Ui.Icon.Icon msg)
    }


type alias TabConfig value msg =
    { value : value
    , label : String
    , icon : Maybe (Ui.Icon.Icon msg)
    , badge : Maybe String
    , panel : Maybe (Html msg)
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
        , attributes = []
        , stretch = False
        , variant = Secondary
        , headerPosition = Before
        , tabs = c.tabs
        , selected = c.selected
        , onChange = c.onChange
        , nextIcon = Nothing
        , prevIcon = Nothing
        }


{-| Construct a tab.
-}
tab : { value : value, label : String } -> Tab value msg
tab c =
    Tab
        { value = c.value
        , label = c.label
        , icon = Nothing
        , badge = Nothing
        , panel = Nothing
        }


{-| Append attributes to the underlying `<m3e-tabs>` host element — the escape
hatch for styling the component itself. Structural attributes are emitted
after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> Tabs value msg -> Tabs value msg
withAttributes attributes (Tabs cfg) =
    Tabs { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` attribute.
-}
withId : String -> Tabs value msg -> Tabs value msg
withId id (Tabs cfg) =
    Tabs { cfg | id = Just id }


{-| Stretch tabs to fill the header width — the `stretch` attribute (default
`False`, tabs sized to their content). When `True`, tabs expand to divide the
container evenly.
-}
withStretch : Bool -> Tabs value msg -> Tabs value msg
withStretch b (Tabs cfg) =
    Tabs { cfg | stretch = b }


{-| Set the appearance variant — the `variant` attribute (default
`Secondary`, a subtler strip). `Primary` emphasizes the active indicator and
shape styling for more prominent navigation.
-}
withVariant : Variant -> Tabs value msg -> Tabs value msg
withVariant variant (Tabs cfg) =
    Tabs { cfg | variant = variant }


{-| Set where the header strip sits relative to its panels — the
`header-position` attribute (default `Before`, the strip ahead of the panels).
`After` places the strip after the panels.
-}
withHeaderPosition : HeaderPosition -> Tabs value msg -> Tabs value msg
withHeaderPosition headerPosition (Tabs cfg) =
    Tabs { cfg | headerPosition = headerPosition }


{-| Add an icon before the tab's label — rides the `icon` slot of `m3e-tab`.
-}
withTabIcon : Ui.Icon.Icon msg -> Tab value msg -> Tab value msg
withTabIcon icon (Tab cfg) =
    Tab { cfg | icon = Just icon }


{-| Attach a small badge text to a tab.
-}
withTabBadge : String -> Tab value msg -> Tab value msg
withTabBadge badge (Tab cfg) =
    Tab { cfg | badge = Just badge }


{-| Attach the panel content a tab switches to. It is rendered as an
`<m3e-tab-panel>` in the tabs' `panel` slot and wired to its tab via a
generated `for`/`id` pair, so the element shows the matching panel when the
tab is selected.
-}
withPanel : Html msg -> Tab value msg -> Tab value msg
withPanel panel (Tab cfg) =
    Tab { cfg | panel = Just panel }


{-| Set the icon used by the "next page" pagination button (the `next-icon`
slot), shown when the strip overflows.
-}
withNextIcon : Ui.Icon.Icon msg -> Tabs value msg -> Tabs value msg
withNextIcon icon (Tabs cfg) =
    Tabs { cfg | nextIcon = Just icon }


{-| Set the icon used by the "previous page" pagination button (the
`prev-icon` slot), shown when the strip overflows.
-}
withPrevIcon : Ui.Icon.Icon msg -> Tabs value msg -> Tabs value msg
withPrevIcon icon (Tabs cfg) =
    Tabs { cfg | prevIcon = Just icon }


{-| Render the tabs strip.
-}
view : Tabs value msg -> Html msg
view (Tabs cfg) =
    Cem.M3e.Tabs.component
        (cfg.attributes
            ++ List.filterMap identity
                [ Maybe.map Attr.id cfg.id
                , Just (Cem.M3e.Tabs.stretch cfg.stretch)
                , Just (Cem.M3e.Tabs.variant (toM3eVariant cfg.variant))
                , Just (Cem.M3e.Tabs.headerPosition (toM3eHeaderPosition cfg.headerPosition))
                ]
        )
        (List.indexedMap (tabView cfg) cfg.tabs
            ++ List.filterMap identity (List.indexedMap (panelView cfg) cfg.tabs)
            ++ paginationIcons cfg
        )


toM3eVariant : Variant -> Cem.M3e.Tabs.Variant
toM3eVariant variant =
    case variant of
        Primary ->
            Cem.M3e.Tabs.Primary

        Secondary ->
            Cem.M3e.Tabs.Secondary


toM3eHeaderPosition : HeaderPosition -> Cem.M3e.Tabs.HeaderPosition
toM3eHeaderPosition headerPosition =
    case headerPosition of
        Before ->
            Cem.M3e.Tabs.Before

        After ->
            Cem.M3e.Tabs.After


{-| The `for`/`id` value linking a tab to its panel
(`<m3e-tab for=X>` ↔ `<m3e-tab-panel id=X>`).
-}
panelId : TabsConfig value msg -> Int -> String
panelId cfg index =
    Maybe.withDefault "tabs" cfg.id ++ "-panel-" ++ String.fromInt index


tabView : TabsConfig value msg -> Int -> Tab value msg -> Html msg
tabView cfg index (Tab t) =
    Cem.M3e.Tab.component
        ([ Cem.M3e.Tab.selected (cfg.selected == t.value)
         , HtmlEvents.onClick (cfg.onChange t.value)
         ]
            ++ (case t.panel of
                    Just _ ->
                        [ Cem.M3e.Tab.for (panelId cfg index) ]

                    Nothing ->
                        []
               )
        )
        (List.concat
            [ iconPart t.icon
            , [ Html.text t.label ]
            , badgePart t.badge
            ]
        )


panelView : TabsConfig value msg -> Int -> Tab value msg -> Maybe (Html msg)
panelView cfg index (Tab t) =
    Maybe.map
        (\panel ->
            Cem.M3e.TabPanel.component
                [ Attr.id (panelId cfg index)
                , Cem.M3e.Tabs.panelSlot
                ]
                [ panel ]
        )
        t.panel


paginationIcons : TabsConfig value msg -> List (Html msg)
paginationIcons cfg =
    List.filterMap identity
        [ Maybe.map
            (\i -> Html.span [ Cem.M3e.Tabs.prevIconSlot ] [ Ui.Icon.view i ])
            cfg.prevIcon
        , Maybe.map
            (\i -> Html.span [ Cem.M3e.Tabs.nextIconSlot ] [ Ui.Icon.view i ])
            cfg.nextIcon
        ]


iconPart : Maybe (Ui.Icon.Icon msg) -> List (Html msg)
iconPart icon =
    case icon of
        Nothing ->
            []

        Just i ->
            [ Html.span [ Cem.M3e.Tab.iconSlot ] [ Ui.Icon.view i ] ]


{-| There is no `badge` slot on `m3e-tab` (only `(default)` and `icon`);
compose the count as an `m3e-badge` element beside the label in the
default content instead.
-}
badgePart : Maybe String -> List (Html msg)
badgePart badge =
    case badge of
        Nothing ->
            []

        Just b ->
            [ Cem.M3e.Badge.component [] [ Html.text b ] ]
