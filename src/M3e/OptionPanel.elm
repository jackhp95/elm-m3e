module M3e.OptionPanel exposing
    ( Option, PanelState(..), ScrollStrategy(..)
    , state, scrollStrategy, fitAnchorWidth, anchorOffset
    , onBeforetoggle, onToggle
    , view
    )

{-| `<m3e-option-panel>` — a temporary floating surface presenting a list of
selectable options (extends `<m3e-floating-panel>`).

Spec (per docs/CONVENTIONS.md):

  - Required: { content : List (Element any msg) }
    (content renders into the default slot)
  - Options: state, scrollStrategy, fitAnchorWidth, anchorOffset,
    onBeforetoggle, onToggle
  - Slots: default ← arbitrary content (free row; typically option items)
  - Properties: fitAnchorWidth, anchorOffset (DOM properties — emitted unconditionally)
  - Attrs: state (enum attribute via Cem.M3e.OptionPanel.stateToString),
    scroll-strategy (enum attribute via Cem.M3e.OptionPanel.scrollStrategyToString)
  - Events: beforetoggle, toggle (inherited from m3e-floating-panel)
  - Escape: html (default-slot region)
  - Tag: optionPanel

Note: `show`, `hide`, and `toggle` are imperative JS methods on the element —
they are not modelled here (use a port or custom event to drive them from Elm).


# Type

@docs Option, PanelState, ScrollStrategy


# Options

@docs state, scrollStrategy, fitAnchorWidth, anchorOffset
@docs onBeforetoggle, onToggle

@docs view

-}

import Cem.M3e.OptionPanel as Cem
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node



-- TYPES ------------------------------------------------------------------


{-| The display state of the option panel.

  - `Content` — show the option list (default).
  - `Loading` — show a loading indicator.
  - `NoData` — show the empty-state slot.

Upstream: `state` attribute on `<m3e-option-panel>`.
CEM: `OptionPanelState` — `"content"`, `"loading"`, or `"no-data"`.

-}
type PanelState
    = Content
    | Loading
    | NoData


{-| How the panel behaves when its trigger scrolls out of view.

  - `Hide` — panel is hidden when the trigger scrolls (default).
  - `Reposition` — panel repositions to follow the trigger.

Upstream: `scroll-strategy` attribute on `<m3e-option-panel>` (inherited
from `m3e-floating-panel`).
CEM: `FloatingPanelScrollStrategy` — `"hide"` or `"reposition"`.

-}
type ScrollStrategy
    = Hide
    | Reposition


type alias Config msg =
    { state : Maybe PanelState
    , scrollStrategy : Maybe ScrollStrategy
    , fitAnchorWidth : Bool
    , anchorOffset : Float
    , onBeforetoggle : Maybe msg
    , onToggle : Maybe msg
    }


{-| An opaque configuration option for [`view`](#view).
-}
type alias Option msg =
    Internal.Option (Config msg) msg


defaultConfig : Config msg
defaultConfig =
    { state = Nothing
    , scrollStrategy = Nothing
    , fitAnchorWidth = False
    , anchorOffset = 0
    , onBeforetoggle = Nothing
    , onToggle = Nothing
    }



-- OPTIONS ------------------------------------------------------------------


{-| Set the panel display state (`Content`, `Loading`, or `NoData`; default `Content`).

Upstream: `state` attribute on `<m3e-option-panel>`.

-}
state : PanelState -> Option msg
state s =
    Internal.option (\c -> { c | state = Just s })


{-| Set the scroll strategy (`Hide` or `Reposition`; default `Hide`).

Upstream: `scroll-strategy` attribute on `<m3e-option-panel>` (inherited
from `m3e-floating-panel`).

-}
scrollStrategy : ScrollStrategy -> Option msg
scrollStrategy s =
    Internal.option (\c -> { c | scrollStrategy = Just s })


{-| Whether the panel's width should match its anchor's width (the
`fitAnchorWidth` DOM property). Default `False`. Emitted unconditionally.
-}
fitAnchorWidth : Bool -> Option msg
fitAnchorWidth b =
    Internal.option (\c -> { c | fitAnchorWidth = b })


{-| The margin in pixels between the panel and its anchor (the `anchorOffset`
DOM property). Default `0`. Emitted unconditionally.
-}
anchorOffset : Float -> Option msg
anchorOffset px =
    Internal.option (\c -> { c | anchorOffset = px })


{-| Fire `msg` before the panel's toggle state changes (the `beforetoggle` event).
-}
onBeforetoggle : msg -> Option msg
onBeforetoggle msg =
    Internal.option (\c -> { c | onBeforetoggle = Just msg })


{-| Fire `msg` after the panel's toggle state has changed (the `toggle` event).
-}
onToggle : msg -> Option msg
onToggle msg =
    Internal.option (\c -> { c | onToggle = Just msg })



-- VIEW ------------------------------------------------------------------


{-| Render the option panel.

    M3e.OptionPanel.view
        { content = [ optionItems ] }
        [ M3e.OptionPanel.fitAnchorWidth True
        , M3e.OptionPanel.state M3e.OptionPanel.Content
        ]

The panel is shown/hidden imperatively via the JS `show`/`hide`/`toggle`
methods — use a port or a custom event to drive visibility from Elm.

-}
view :
    { content : List (Element any msg) }
    -> List (Option msg)
    -> Element { s | optionPanel : Supported } msg
view req opts =
    let
        cfg : Config msg
        cfg =
            Internal.applyOptions opts defaultConfig
    in
    Internal.fromNode
        (Node.element "m3e-option-panel"
            (List.filterMap identity
                [ Maybe.map (\s -> Node.attribute "state" (Cem.stateToString (toCemState s))) cfg.state
                , Maybe.map (\s -> Node.attribute "scroll-strategy" (Cem.scrollStrategyToString (toCemScrollStrategy s))) cfg.scrollStrategy
                , Just (Node.property "fitAnchorWidth" (Encode.bool cfg.fitAnchorWidth))
                , Just (Node.property "anchorOffset" (Encode.float cfg.anchorOffset))
                , Maybe.map (\msg -> Node.on "beforetoggle" (Decode.succeed msg)) cfg.onBeforetoggle
                , Maybe.map (\msg -> Node.on "toggle" (Decode.succeed msg)) cfg.onToggle
                ]
            )
            (List.map Element.toNode req.content)
        )



-- INTERNAL HELPERS -----------------------------------------------


{-| Map the local `PanelState` to the generated `Cem.M3e.OptionPanel` enum,
whose `stateToString` is the single source of truth for the attribute value
(kept in sync with the element's CEM — #45).
-}
toCemState : PanelState -> Cem.State
toCemState s =
    case s of
        Content ->
            Cem.Content

        Loading ->
            Cem.Loading

        NoData ->
            Cem.NoData


{-| Map the local `ScrollStrategy` to the generated `Cem.M3e.OptionPanel`
enum, whose `scrollStrategyToString` is the single source of truth for the
attribute value (kept in sync with the element's CEM — #45).
-}
toCemScrollStrategy : ScrollStrategy -> Cem.ScrollStrategy
toCemScrollStrategy s =
    case s of
        Hide ->
            Cem.Hide

        Reposition ->
            Cem.Reposition
