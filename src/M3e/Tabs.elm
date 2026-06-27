module M3e.Tabs exposing
    ( HeaderPosition(..)
    , Option
    , PanelOption
    , TabOption
    , Variant(..)
    , headerPosition
    , panel
    , panelId
    , stretch
    , tab
    , tabDisabled
    , tabFor
    , tabOnClick
    , tabSelected
    , variant
    , view
    )

{-| `<m3e-tabs>` + `<m3e-tab>` + `<m3e-tab-panel>` — in-page navigation
between related content sections (Material 3 Tabs).

Spec (per docs/CONVENTIONS.md):

  - Two sub-components:
    `tab  : { label : String } → List TabOption → Renderable { tab }`
    `panel: { content }       → List PanelOption → Renderable { tabPanel }`
  - View:
    `view : { tabs, panels } → List Option → Renderable { tabs }`
  - Tabs default-slot ← m3e-tab children (no slot injection)
  - Panels panel-slot ← m3e-tab-panel children (Node.withSlot "panel")
  - Properties: selected (tab), disabled (tab), stretch (strip)
  - Attrs: for (tab, relational), id (panel, relational),
    variant / header-position (strip, rawAttr enums)
  - Events: click → tabOnClick msg (per-tab)
  - Tag: tabs

Wiring `<m3e-tab for=X>` ↔ `<m3e-tab-panel id=X>` is the caller's
responsibility via `tabFor` / `panelId` options — they choose meaningful,
stable ids.

-}

import Cem.M3e.Tabs as CemTabs
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


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


type alias TabOption msg =
    Internal.Option (TabConfig msg) msg


type alias PanelOption msg =
    Internal.Option PanelConfig msg


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
    }


defaultTabConfig : TabConfig msg
defaultTabConfig =
    { selected = False
    , disabled = False
    , for = Nothing
    , onClick = Nothing
    }


{-| Construct a tab.

    M3e.Tabs.tab { label = "Details" }
        [ M3e.Tabs.tabSelected True
        , M3e.Tabs.tabFor "details-panel"
        , M3e.Tabs.tabOnClick DetailsClicked
        ]

-}
tab : { label : String } -> List (TabOption msg) -> Renderable { t | tab : Supported } msg
tab req opts =
    let
        c =
            Internal.applyOptions opts defaultTabConfig
    in
    Internal.fromNode
        (Node.element "m3e-tab"
            (List.filterMap identity
                [ Just (Node.property "selected" (Encode.bool c.selected))
                , if c.disabled then
                    Just (Node.property "disabled" (Encode.bool True))

                  else
                    Nothing
                , Maybe.map (Node.attribute "for") c.for
                , Maybe.map (\m -> Node.on "click" (Decode.succeed m)) c.onClick
                ]
            )
            [ Node.text req.label ]
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
panel : { content : List (Renderable any msg) } -> List (PanelOption msg) -> Renderable { p | tabPanel : Supported } msg
panel req opts =
    let
        c =
            Internal.applyOptions opts defaultPanelConfig
    in
    Internal.fromNode
        (Node.element "m3e-tab-panel"
            (List.filterMap identity
                [ Maybe.map (Node.attribute "id") c.id
                ]
            )
            (List.map Renderable.toNode req.content)
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
    { tabs : List (Renderable { tab : Supported } msg)
    , panels : List (Renderable { tabPanel : Supported } msg)
    }
    -> List (Option msg)
    -> Renderable { s | tabs : Supported } msg
view req opts =
    let
        c =
            Internal.applyOptions opts defaultStripConfig
    in
    Internal.fromNode
        (Node.element "m3e-tabs"
            (List.filterMap identity
                [ if c.stretch then
                    Just (Node.property "stretch" (Encode.bool True))

                  else
                    Nothing
                , Just (Node.rawAttr (CemTabs.variant (toCemVariant c.variant)))
                , Just (Node.rawAttr (CemTabs.headerPosition (toCemHeaderPosition c.headerPosition)))
                ]
            )
            (List.map Renderable.toNode req.tabs
                ++ List.map (Node.withSlot "panel" << Renderable.toNode) req.panels
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
