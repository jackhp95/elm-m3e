module M3e.FloatingPanel exposing
    ( Option, ScrollStrategy
    , scrollStrategy, fitAnchorWidth, anchorOffset
    , onBeforetoggle, onToggle
    , view
    )

{-| `<m3e-floating-panel>` — a lightweight generic floating surface positioned
relative to an anchor element (Material 3 Floating Panel).

Spec (per docs/CONVENTIONS.md):

  - Required: { content : List (Element any msg) }
    (content renders into the default slot)
  - Options: scrollStrategy, fitAnchorWidth, anchorOffset,
    onBeforetoggle, onToggle
  - Slots: default ← arbitrary content (free row)
  - Properties: fitAnchorWidth, anchorOffset (DOM properties — emitted unconditionally)
  - Attrs: scroll-strategy (enum attribute via Cem.M3e.FloatingPanel.scrollStrategyToString)
  - Events: beforetoggle, toggle
  - Escape: html (default-slot region)
  - Tag: floatingPanel

Note: `show`, `hide`, and `toggle` are imperative JS methods on the element —
they are not modelled here (use a port or custom event to drive them from Elm).


# Type

@docs Option, ScrollStrategy


# Options

@docs scrollStrategy, fitAnchorWidth, anchorOffset
@docs onBeforetoggle, onToggle

@docs view

-}

import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Value as Value exposing (Value)



-- TYPES ------------------------------------------------------------------


{-| How the panel behaves when its trigger scrolls out of view, supplied as
shared [`M3e.Value`](M3e-Value) tokens.

  - [`hide`](M3e-Value#hide) — panel is hidden when the trigger scrolls (default).
  - [`reposition`](M3e-Value#reposition) — panel repositions to follow the trigger.

Upstream: `scroll-strategy` attribute on `<m3e-floating-panel>`.

-}
type alias ScrollStrategy =
    Value
        { hide : Supported
        , reposition : Supported
        }


type alias Config msg =
    { scrollStrategy : Maybe ScrollStrategy
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
    { scrollStrategy = Nothing
    , fitAnchorWidth = False
    , anchorOffset = 0
    , onBeforetoggle = Nothing
    , onToggle = Nothing
    }



-- OPTIONS ------------------------------------------------------------------


{-| Set the scroll strategy ([`hide`](M3e-Value#hide) or
[`reposition`](M3e-Value#reposition); default `hide`).

Upstream: `scroll-strategy` attribute on `<m3e-floating-panel>`.

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


{-| Render the floating panel.

    M3e.FloatingPanel.view
        { content = [ menuItems ] }
        [ M3e.FloatingPanel.fitAnchorWidth True
        , M3e.FloatingPanel.anchorOffset 4
        ]

The panel is shown/hidden imperatively via the JS `show`/`hide`/`toggle`
methods — use a port or a custom event to drive visibility from Elm.

-}
view :
    { content : List (Element any msg) }
    -> List (Option msg)
    -> Element { s | floatingPanel : Supported } msg
view req opts =
    let
        cfg : Config msg
        cfg =
            Internal.applyOptions opts defaultConfig
    in
    Internal.fromNode
        (Node.element "m3e-floating-panel"
            (List.filterMap identity
                [ Maybe.map (\s -> Node.attribute "scroll-strategy" (Value.toString s)) cfg.scrollStrategy
                , Just (Node.property "fitAnchorWidth" (Encode.bool cfg.fitAnchorWidth))
                , Just (Node.property "anchorOffset" (Encode.float cfg.anchorOffset))
                , Maybe.map (\msg -> Node.on "beforetoggle" (Decode.succeed msg)) cfg.onBeforetoggle
                , Maybe.map (\msg -> Node.on "toggle" (Decode.succeed msg)) cfg.onToggle
                ]
            )
            (List.map Element.toNode req.content)
        )
