module M3e.Collapsible exposing
    ( Option, Orientation
    , open, orientation, noAnimate
    , onOpening, onOpened, onClosing, onClosed
    , view
    )

{-| `<m3e-collapsible>` — an animated click-to-expand container (Material 3 Collapsible).

Spec (per docs/CONVENTIONS.md):

  - Required: { content : List (Element any msg) }
    (content renders into the default slot)
  - Options: open, orientation, noAnimate, onOpening, onOpened, onClosing, onClosed
  - Slots: default ← arbitrary content (free row)
  - Properties: open, noAnimate (DOM properties — emitted unconditionally)
  - Attrs: orientation (enum attribute via Cem.M3e.Collapsible.orientationToString)
  - Events: opening, opened, closing, closed
  - Escape: html (default-slot region)
  - Tag: collapsible


# Type

@docs Option, Orientation


# Options

@docs open, orientation, noAnimate
@docs onOpening, onOpened, onClosing, onClosed

@docs view

-}

import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Value as Value exposing (Value)



-- TYPES ------------------------------------------------------------------


{-| Layout orientation of collapsible content, supplied as shared
[`M3e.Value`](M3e-Value) tokens ([`vertical`](M3e-Value#vertical) or
[`horizontal`](M3e-Value#horizontal)). The element default is `vertical`.

Upstream: `orientation` attribute on `<m3e-collapsible>`.

-}
type alias Orientation =
    Value
        { vertical : Supported
        , horizontal : Supported
        }


type alias Config msg =
    { open : Bool
    , orientation : Maybe Orientation
    , noAnimate : Bool
    , onOpening : Maybe msg
    , onOpened : Maybe msg
    , onClosing : Maybe msg
    , onClosed : Maybe msg
    }


{-| An opaque configuration option for [`view`](#view).
-}
type alias Option msg =
    Internal.Option (Config msg) msg


defaultConfig : Config msg
defaultConfig =
    { open = False
    , orientation = Nothing
    , noAnimate = False
    , onOpening = Nothing
    , onOpened = Nothing
    , onClosing = Nothing
    , onClosed = Nothing
    }



-- OPTIONS ------------------------------------------------------------------


{-| Whether the collapsible content is visible (the `open` DOM property).
Default `False`. Emitted unconditionally so the element resets on re-render.
-}
open : Bool -> Option msg
open b =
    Internal.option (\c -> { c | open = b })


{-| Set the orientation of the collapsible animation
([`vertical`](M3e-Value#vertical) or [`horizontal`](M3e-Value#horizontal);
element default `vertical`).

Upstream: `orientation` attribute on `<m3e-collapsible>`.

-}
orientation : Orientation -> Option msg
orientation o =
    Internal.option (\c -> { c | orientation = Just o })


{-| Disable the expand/collapse animation (the `noAnimate` DOM property).
Default `False`. Emitted unconditionally so the element resets on re-render.
-}
noAnimate : Bool -> Option msg
noAnimate b =
    Internal.option (\c -> { c | noAnimate = b })


{-| Fire `msg` when the collapsible begins to open (the `opening` event).
-}
onOpening : msg -> Option msg
onOpening msg =
    Internal.option (\c -> { c | onOpening = Just msg })


{-| Fire `msg` when the collapsible has fully opened (the `opened` event).
-}
onOpened : msg -> Option msg
onOpened msg =
    Internal.option (\c -> { c | onOpened = Just msg })


{-| Fire `msg` when the collapsible begins to close (the `closing` event).
-}
onClosing : msg -> Option msg
onClosing msg =
    Internal.option (\c -> { c | onClosing = Just msg })


{-| Fire `msg` when the collapsible has fully closed (the `closed` event).
-}
onClosed : msg -> Option msg
onClosed msg =
    Internal.option (\c -> { c | onClosed = Just msg })



-- VIEW ------------------------------------------------------------------


{-| Render the collapsible container.

    M3e.Collapsible.view
        { content = [ bodyText ] }
        [ M3e.Collapsible.open True
        , M3e.Collapsible.onOpened PanelOpened
        ]

-}
view :
    { content : List (Element any msg) }
    -> List (Option msg)
    -> Element { s | collapsible : Supported } msg
view req opts =
    let
        cfg : Config msg
        cfg =
            Internal.applyOptions opts defaultConfig
    in
    Internal.fromNode
        (Node.element "m3e-collapsible"
            (List.filterMap identity
                [ Just (Node.property "open" (Encode.bool cfg.open))
                , Maybe.map (\o -> Node.attribute "orientation" (Value.toString o)) cfg.orientation
                , Just (Node.property "noAnimate" (Encode.bool cfg.noAnimate))
                , Maybe.map (\msg -> Node.on "opening" (Decode.succeed msg)) cfg.onOpening
                , Maybe.map (\msg -> Node.on "opened" (Decode.succeed msg)) cfg.onOpened
                , Maybe.map (\msg -> Node.on "closing" (Decode.succeed msg)) cfg.onClosing
                , Maybe.map (\msg -> Node.on "closed" (Decode.succeed msg)) cfg.onClosed
                ]
            )
            (List.map Element.toNode req.content)
        )
