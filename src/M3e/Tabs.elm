module M3e.Tabs exposing
    ( view, tab, panel
    , Option, TabOption, PanelOption, Variant(..), HeaderPosition(..)
    , tabSelected, tabDisabled, tabFor, tabOnClick, tabIcon
    , panelId
    , stretch, variant, headerPosition
    )

{-| `<m3e-tabs>` + `<m3e-tab>` + `<m3e-tab-panel>` — in-page navigation
between related content sections (Material 3 Tabs).

Spec (per docs/CONVENTIONS.md):

  - Two sub-components:
    `tab  : { label : String } → List TabOption → Element { tab }`
    `panel: { content }       → List PanelOption → Element { tabPanel }`
  - View:
    `view : { tabs, panels } → List Option → Element { tabs }`
  - Tabs default-slot ← m3e-tab children (no slot injection)
  - Panels panel-slot ← m3e-tab-panel children (Node.withSlot "panel")
  - Properties: selected (tab), disabled (tab), stretch (strip)
  - Attrs: for (tab, relational), id (panel, relational),
    variant / header-position (strip, rawAttr enums)
  - Events: click → tabOnClick msg (per-tab)
  - Slots: icon (tab, `Node.withSlot "icon"`)
  - Tag: tabs

Wiring `<m3e-tab for=X>` ↔ `<m3e-tab-panel id=X>` is the caller's
responsibility via `tabFor` / `panelId` options — they choose meaningful,
stable ids.

@docs view, tab, panel
@docs Option, TabOption, PanelOption, Variant, HeaderPosition
@docs tabSelected, tabDisabled, tabFor, tabOnClick, tabIcon
@docs panelId
@docs stretch, variant, headerPosition

-}

import Cem.M3e.Tabs as CemTabs
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node


{-| The appearance variant of the tabs strip.
`Secondary` (default) is a subtler presentation; `Primary` emphasizes the
active indicator.
-}
type Variant
    = Primary
    | Secondary


{-| Where the header strip sits relative to its panels.
`Before` (default) places the strip ahead of the panels; `After` places it
after.
-}
type HeaderPosition
    = Before
    | After


{-| An option configuring an individual tab.
-}
type alias TabOption msg =
    Internal.Option (TabConfig msg) msg


{-| An option configuring an individual tab panel.
-}
type alias PanelOption msg =
    Internal.Option PanelConfig msg


{-| An option configuring the tabs strip.
-}
type alias Option msg =
    Internal.Option StripConfig msg


{-| Mark the tab as currently selected. Sets the `selected` DOM property.
-}
tabSelected : Bool -> TabOption msg
tabSelected b =
    Internal.option (\c -> { c | selected = b })


{-| Disable the tab. Sets the `disabled` DOM property.
-}
tabDisabled : Bool -> TabOption msg
tabDisabled b =
    Internal.option (\c -> { c | disabled = b })


{-| Wire the tab to a panel via its panel's id (the `for` attribute).
-}
tabFor : String -> TabOption msg
tabFor s =
    Internal.option (\c -> { c | for = Just s })


{-| Fire a message when the tab is clicked.
-}
tabOnClick : msg -> TabOption msg
tabOnClick m =
    Internal.option (\c -> { c | onClick = Just m })


{-| Inject an icon into the tab's `icon` slot (rendered before the label).
The upstream `<m3e-tab>` icon slot accepts `m3e-icon` or any icon-shaped
element.
-}
tabIcon : Element { icon : Supported } msg -> TabOption msg
tabIcon i =
    Internal.option (\c -> { c | icon = Just i })


{-| Set the `id` attribute on the panel element — matches the `for` attribute
on its paired `m3e-tab`.
-}
panelId : String -> PanelOption msg
panelId s =
    Internal.option (\c -> { c | id = Just s })


{-| Stretch tabs to fill the header width. Default false.
-}
stretch : Bool -> Option msg
stretch b =
    Internal.option (\c -> { c | stretch = b })


{-| Set the strip appearance variant. Default `Secondary`.
-}
variant : Variant -> Option msg
variant v =
    Internal.option (\c -> { c | variant = v })


{-| Where the header strip sits relative to panels. Default `Before`.
-}
headerPosition : HeaderPosition -> Option msg
headerPosition hp =
    Internal.option (\c -> { c | headerPosition = hp })



-- Tab sub-component


type alias TabConfig msg =
    { selected : Bool
    , disabled : Bool
    , for : Maybe String
    , onClick : Maybe msg
    , icon : Maybe (Element { icon : Supported } msg)
    }


defaultTabConfig : TabConfig msg
defaultTabConfig =
    { selected = False
    , disabled = False
    , for = Nothing
    , onClick = Nothing
    , icon = Nothing
    }


{-| Construct a tab.

    M3e.Tabs.tab { label = "Details" }
        [ M3e.Tabs.tabSelected True
        , M3e.Tabs.tabFor "details-panel"
        , M3e.Tabs.tabOnClick DetailsClicked
        ]

-}
tab : { label : String } -> List (TabOption msg) -> Element { t | tab : Supported } msg
tab req opts =
    let
        c : TabConfig msg
        c =
            Internal.applyOptions opts defaultTabConfig
    in
    Internal.fromNode
        (Node.element "m3e-tab"
            (List.filterMap identity
                [ Just (Node.property "selected" (Encode.bool c.selected))
                , Just (Node.property "disabled" (Encode.bool c.disabled))
                , Maybe.map (Node.attribute "for") c.for
                , Maybe.map (\m -> Node.on "click" (Decode.succeed m)) c.onClick
                ]
            )
            (List.filterMap identity
                [ Maybe.map (\i -> Node.withSlot "icon" (Element.toNode i)) c.icon
                , Just (Node.text req.label)
                ]
            )
        )



-- Panel sub-component


type alias PanelConfig =
    { id : Maybe String }


defaultPanelConfig : PanelConfig
defaultPanelConfig =
    { id = Nothing }


{-| Construct a tab panel.

    M3e.Tabs.panel
        { content = [ detailContent ] }
        [ M3e.Tabs.panelId "details-panel" ]

-}
panel : { content : List (Element any msg) } -> List (PanelOption msg) -> Element { p | tabPanel : Supported } msg
panel req opts =
    let
        c : PanelConfig
        c =
            Internal.applyOptions opts defaultPanelConfig
    in
    Internal.fromNode
        (Node.element "m3e-tab-panel"
            (List.filterMap identity
                [ Maybe.map (Node.attribute "id") c.id
                ]
            )
            (List.map Element.toNode req.content)
        )



-- Strip


type alias StripConfig =
    { stretch : Bool
    , variant : Variant
    , headerPosition : HeaderPosition
    }


defaultStripConfig : StripConfig
defaultStripConfig =
    { stretch = False
    , variant = Secondary
    , headerPosition = Before
    }


{-| Render the tabs strip.

    M3e.Tabs.view
        { tabs =
            [ M3e.Tabs.tab { label = "Tab 1" }
                [ M3e.Tabs.tabSelected True, M3e.Tabs.tabFor "p1" ]
            , M3e.Tabs.tab { label = "Tab 2" }
                [ M3e.Tabs.tabFor "p2", M3e.Tabs.tabOnClick (TabChanged "p2") ]
            ]
        , panels =
            [ M3e.Tabs.panel { content = [ content1 ] } [ M3e.Tabs.panelId "p1" ]
            , M3e.Tabs.panel { content = [ content2 ] } [ M3e.Tabs.panelId "p2" ]
            ]
        }
        []

Panels receive `slot="panel"` automatically; tab elements land in the default
slot. The `tabFor`/`panelId` pairing is the caller's responsibility.

-}
view :
    { tabs : List (Element { tab : Supported } msg)
    , panels : List (Element { tabPanel : Supported } msg)
    }
    -> List (Option msg)
    -> Element { s | tabs : Supported } msg
view req opts =
    let
        c : StripConfig
        c =
            Internal.applyOptions opts defaultStripConfig
    in
    Internal.fromNode
        (Node.element "m3e-tabs"
            [ Node.property "stretch" (Encode.bool c.stretch)
            , Node.rawAttr (CemTabs.variant (toCemVariant c.variant))
            , Node.rawAttr (CemTabs.headerPosition (toCemHeaderPosition c.headerPosition))
            ]
            (List.map Element.toNode req.tabs
                ++ List.map (Node.withSlot "panel" << Element.toNode) req.panels
            )
        )


toCemVariant : Variant -> CemTabs.Variant
toCemVariant v =
    case v of
        Primary ->
            CemTabs.Primary

        Secondary ->
            CemTabs.Secondary


toCemHeaderPosition : HeaderPosition -> CemTabs.HeaderPosition
toCemHeaderPosition hp =
    case hp of
        Before ->
            CemTabs.Before

        After ->
            CemTabs.After
