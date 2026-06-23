module Ui.Disclosure exposing
    ( Disclosure, new
    , Panel, panel
    , withId, withPanels, withSingleOpen
    , withDefaultOpen, withExplicitOpenState
    , view
    )

{-| Typed builder for click-to-expand surfaces. Absorbs the legacy
`Ui.Accordion` and `Ui.Collapsible` modules into one configuration-
driven primitive whose panel count picks the underlying M3e
composition:

  - 1 panel → standalone `M3e.ExpansionPanel`
  - 2+ panels → `M3e.Accordion` wrapping multiple `M3e.ExpansionPanel`
    children. `withSingleOpen` sets the accordion's `multi=false` so
    only one panel is open at a time; the default leaves panels
    independent (`multi=true`).

Each `Panel` owns its own header, body, and open state. Open state is
hybrid (uncontrolled default-open vs caller-controlled), matching the
legacy modules.


# Spec deviations vs the REDESIGN\_PLAN

  - **1-panel renderer is `M3e.ExpansionPanel`, not `M3e.Collapsible`.**
    The spec inference table says "1 panel → M3e.Collapsible", but
    `M3e.Collapsible` has no header slot. Since the universal Panel
    type carries a header, dropping it for the 1-panel case would
    silently lose data. Phase 3a renders `M3e.ExpansionPanel`
    standalone for the 1-panel path so headers always survive. Raw
    headerless `M3e.Collapsible` callers (rare; a "show more"
    disclosure with no separate header) drop down to M3e directly.
  - **`Panel` header type is `Html msg`, not `List (Content msg)`.**
    The expansion-header slot is a single chrome slot — no
    leading/trailing semantics — so position-significant Content lists
    don't earn their weight. Matches Phase 0's chrome-slot
    convention and the legacy `Ui.Accordion.panel` signature.
  - **`withSingleOpen` inverts the legacy `Ui.Accordion.withMulti`
    polarity.** Default is multi-open (panels independent);
    `withSingleOpen` opts in to the classic "accordion" mutual
    exclusion. The spec uses this polarity (`-- accordion-like; only
    one panel open at a time`). Migration from `Ui.Accordion` callers
    should swap `withMulti True` → drop the call, and
    `withMulti False` (or absence) → `withSingleOpen`.
  - **Panel disabled state isn't exposed.** `M3e.ExpansionPanel` has
    a `disabled` attribute and the legacy `Ui.Accordion` doesn't
    expose it either. A future `Panel.withDisabled` can land if needed.


# Type

@docs Disclosure, new


# Panel

@docs Panel, panel


# Identity and panels

@docs withId, withPanels, withSingleOpen


# Per-panel open state (hybrid)

@docs withDefaultOpen, withExplicitOpenState


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Json.Decode as Decode
import M3e.Accordion
import M3e.ExpansionHeader
import M3e.ExpansionPanel


type Disclosure msg
    = Disclosure (Config msg)


type Panel msg
    = Panel (PanelConfig msg)


type OpenState msg
    = NoOpen
    | DefaultOpen Bool
    | ExplicitOpen (Bool -> msg) Bool


type alias Config msg =
    { id : Maybe String
    , panels : List (Panel msg)
    , singleOpen : Bool
    }


type alias PanelConfig msg =
    { header : Html msg
    , body : List (Html msg)
    , state : OpenState msg
    }


{-| A fresh disclosure. Defaults to no panels, no id, multi-open mode
(panels independent). Add panels with `withPanels` and flip to
classic accordion behavior with `withSingleOpen`.
-}
new : Disclosure msg
new =
    Disclosure { id = Nothing, panels = [], singleOpen = False }


{-| Construct a panel from its header and body. Open state defaults to
uncontrolled-closed; opt in to `withDefaultOpen` or
`withExplicitOpenState` to drive it.
-}
panel : Html msg -> List (Html msg) -> Panel msg
panel header body =
    Panel { header = header, body = body, state = NoOpen }


{-| Attach a DOM id. Used as the wrapper's id directly in the 2+-panel
(Accordion) case and as the standalone ExpansionPanel's id in the
1-panel case. Per-panel ids inside an Accordion derive from this id
(`<id>-panel-<index>`).
-}
withId : String -> Disclosure msg -> Disclosure msg
withId id_ (Disclosure cfg) =
    Disclosure { cfg | id = Just id_ }


{-| Replace the panel list. Single panel renders standalone; 2+ panels
render inside an Accordion.
-}
withPanels : List (Panel msg) -> Disclosure msg -> Disclosure msg
withPanels ps (Disclosure cfg) =
    Disclosure { cfg | panels = ps }


{-| Opt in to classic accordion behavior: only one panel can be open
at a time. Default is multi-open (panels independent). No-op when
there's only one panel.
-}
withSingleOpen : Disclosure msg -> Disclosure msg
withSingleOpen (Disclosure cfg) =
    Disclosure { cfg | singleOpen = True }


{-| Render the panel initially open with the DOM owning subsequent
state. Useful for "this is the section the user is most likely to
read" defaults that should still collapse on click.
-}
withDefaultOpen : Bool -> Panel msg -> Panel msg
withDefaultOpen flag (Panel cfg) =
    Panel { cfg | state = DefaultOpen flag }


{-| Caller-owned open state. The first argument is invoked with the
new flag whenever the panel reports an opened/closed event.
-}
withExplicitOpenState : (Bool -> msg) -> Bool -> Panel msg -> Panel msg
withExplicitOpenState onToggle isOpen (Panel cfg) =
    Panel { cfg | state = ExplicitOpen onToggle isOpen }



-- VIEW DISPATCH


view : Disclosure msg -> Html msg
view (Disclosure cfg) =
    case cfg.panels of
        [] ->
            viewEmpty cfg

        [ only ] ->
            viewSinglePanel cfg only

        many ->
            viewAccordion cfg many


viewEmpty : Config msg -> Html msg
viewEmpty cfg =
    -- Degenerate case (no panels); render an empty accordion shell so
    -- the id survives for testability. Matches the "empty content is
    -- valid" stance of Button / Item.
    M3e.Accordion.component
        (List.filterMap identity [ Maybe.map Attr.id cfg.id ])
        []


viewSinglePanel : Config msg -> Panel msg -> Html msg
viewSinglePanel cfg p =
    viewPanel cfg.id p


viewAccordion : Config msg -> List (Panel msg) -> Html msg
viewAccordion cfg panels =
    let
        accordionId =
            Maybe.withDefault "ui-next-disclosure" cfg.id

        panelId index =
            accordionId ++ "-panel-" ++ String.fromInt index
    in
    M3e.Accordion.component
        (List.filterMap identity
            [ Maybe.map Attr.id cfg.id
            , Just (M3e.Accordion.multi (not cfg.singleOpen))
            ]
        )
        (List.indexedMap (\i p -> viewPanel (Just (panelId i)) p) panels)



-- PANEL


viewPanel : Maybe String -> Panel msg -> Html msg
viewPanel maybeId (Panel p) =
    M3e.ExpansionPanel.component
        (List.filterMap identity
            (Maybe.map Attr.id maybeId
                :: panelOpenAttrs p.state
            )
        )
        (M3e.ExpansionHeader.component
            [ M3e.ExpansionPanel.headerSlot ]
            [ p.header ]
            :: p.body
        )


panelOpenAttrs : OpenState msg -> List (Maybe (Html.Attribute msg))
panelOpenAttrs state =
    case state of
        NoOpen ->
            []

        DefaultOpen True ->
            [ Just (Attr.attribute "open" "true") ]

        DefaultOpen False ->
            []

        ExplicitOpen onToggle flag ->
            [ Just (M3e.ExpansionPanel.open flag)
            , Just (M3e.ExpansionPanel.onOpened (Decode.succeed (onToggle True)))
            , Just (M3e.ExpansionPanel.onClosed (Decode.succeed (onToggle False)))
            ]
