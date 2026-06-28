module M3e.Theme exposing
    ( view
    , Option
    , Scheme(..), Contrast(..), Motion(..)
    , seedColor, scheme, variant, contrast, density, strongFocus, motion, onChange
    )

{-| `<m3e-theme>` — a non-visual application-level theme provider. Derives
dynamic color, density, motion, and focus tokens from a seed color and applies
`--md-sys-color-*` (and related) custom properties to its themed subtree.

Spec (per docs/CONVENTIONS.md):

  - Required: { content : List (Element any msg) }
    (the themed subtree — content IS what the element wraps)
  - Options: seedColor, scheme, variant, contrast, density, strongFocus,
    motion, onChange
  - Slots: default slot ← arbitrary themed content (free-row region)
  - Properties: density (float), strongFocus (bool) — via Node.property (introspectable)
  - Attrs: color, scheme, variant, contrast, motion — via Node.rawAttr (Cem enums)
  - Events: change (dispatched when theme recomputes tokens)
  - Escape: html (default-slot region)
  - Tag: theme

@docs view
@docs Option
@docs Scheme, Contrast, Motion
@docs seedColor, scheme, variant, contrast, density, strongFocus, motion, onChange

-}

import Cem.M3e.Theme as Cem
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Value as Value exposing (Value)


{-| Color scheme — follows the OS light/dark preference (`Auto`), or is
forced to `Light` or `Dark`.
-}
type Scheme
    = Auto
    | Light
    | Dark


{-| Dynamic-color palette-generation strategy (default `neutral`), supplied as
shared [`M3e.Value`](M3e-Value) tokens.
-}
type alias Variants =
    Value
        { content : Supported
        , vibrant : Supported
        , expressive : Supported
        , monochrome : Supported
        , neutral : Supported
        , tonalSpot : Supported
        , fidelity : Supported
        , rainbow : Supported
        , fruitSalad : Supported
        }


{-| Contrast level. Default `Standard`.
-}
type Contrast
    = Medium
    | Standard
    | High


{-| Motion scheme — `MotionStandard` for the default easing set,
`MotionExpressive` for the springier M3 Expressive set.
-}
type Motion
    = MotionStandard
    | MotionExpressive


{-| An option configuring the `<m3e-theme>` provider.
-}
type alias Option msg =
    Internal.Option (Config msg) msg


{-| Set the hex seed color from which the dynamic palettes are derived
(the `color` attribute, default `#6750A4`).
-}
seedColor : String -> Option msg
seedColor s =
    Internal.option (\c -> { c | seedColor = Just s })


{-| Set the color scheme (default `Auto` — follow the OS preference).
-}
scheme : Scheme -> Option msg
scheme s =
    Internal.option (\c -> { c | scheme = Just s })


{-| Set the dynamic-color variant (default `neutral`).
-}
variant : Variants -> Option msg
variant v =
    Internal.option (\c -> { c | variant = Just v })


{-| Set the contrast level (default `Standard`).
-}
contrast : Contrast -> Option msg
contrast co =
    Internal.option (\c -> { c | contrast = Just co })


{-| Set the density scale (default `0`; tighter: `-1`, `-2`).
-}
density : Float -> Option msg
density d =
    Internal.option (\c -> { c | density = Just d })


{-| Enable or disable strong focus indicators across the subtree (default
`false`).
-}
strongFocus : Bool -> Option msg
strongFocus sf =
    Internal.option (\c -> { c | strongFocus = Just sf })


{-| Set the motion scheme (default `MotionStandard`).
-}
motion : Motion -> Option msg
motion m =
    Internal.option (\c -> { c | motion = Just m })


{-| Listen for the `change` event — dispatched when the theme recomputes its
derived tokens (e.g. after a scheme or seed-color change).
-}
onChange : Decode.Decoder msg -> Option msg
onChange d =
    Internal.option (\c -> { c | onChange = Just d })


type alias Config msg =
    { seedColor : Maybe String
    , scheme : Maybe Scheme
    , variant : Maybe Variants
    , contrast : Maybe Contrast
    , density : Maybe Float
    , strongFocus : Maybe Bool
    , motion : Maybe Motion
    , onChange : Maybe (Decode.Decoder msg)
    }


{-| Render the theme provider, wrapping `content` in `<m3e-theme>` so the
derived color, density, motion, and focus tokens apply to that subtree.
-}
view : { content : List (Element any msg) } -> List (Option msg) -> Element { s | theme : Supported } msg
view req opts =
    let
        c : Config msg
        c =
            Internal.applyOptions opts
                { seedColor = Nothing
                , scheme = Nothing
                , variant = Nothing
                , contrast = Nothing
                , density = Nothing
                , strongFocus = Nothing
                , motion = Nothing
                , onChange = Nothing
                }
    in
    Internal.fromNode
        (Node.element "m3e-theme"
            (List.filterMap identity
                [ Maybe.map (\col -> Node.rawAttr (Cem.color col)) c.seedColor
                , Maybe.map (\s -> Node.rawAttr (Cem.scheme (toCemScheme s))) c.scheme
                , Maybe.map (\v -> Node.attribute "variant" (Value.toString v)) c.variant
                , Maybe.map (\co -> Node.rawAttr (Cem.contrast (toCemContrast co))) c.contrast
                , Maybe.map (\d -> Node.property "density" (Encode.float d)) c.density
                , Maybe.map (\sf -> Node.property "strongFocus" (Encode.bool sf)) c.strongFocus
                , Maybe.map (\m -> Node.rawAttr (Cem.motion (toCemMotion m))) c.motion
                , Maybe.map (\d -> Node.on "change" d) c.onChange
                ]
            )
            (List.map Element.toNode req.content)
        )


toCemScheme : Scheme -> Cem.Scheme
toCemScheme s =
    case s of
        Auto ->
            Cem.Auto

        Light ->
            Cem.Light

        Dark ->
            Cem.Dark


toCemContrast : Contrast -> Cem.Contrast
toCemContrast co =
    case co of
        Medium ->
            Cem.Medium

        Standard ->
            Cem.ContrastStandard

        High ->
            Cem.High


toCemMotion : Motion -> Cem.Motion
toCemMotion m =
    case m of
        MotionStandard ->
            Cem.MotionStandard

        MotionExpressive ->
            Cem.MotionExpressive
