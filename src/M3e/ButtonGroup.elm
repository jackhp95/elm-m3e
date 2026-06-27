module M3e.ButtonGroup exposing
    ( Option, Variant(..), Size(..)
    , view
    , variant, size, multi
    )

{-| `<m3e-button-group>` — a connected row of buttons (Material 3 Button
groups, M3 Expressive).

Spec (per docs/CONVENTIONS.md):

  - Required: { buttons : List (Element { button : Supported } msg) }
    (homogeneous list slot — a button-group is meaningless without
    buttons; typed list in the required record)
  - Options: variant, size, multi
  - Slots: default slot ← `m3e-button` children (no slot= injection)
  - Properties: multi (Node.property — introspectable)
  - Attrs: variant/size via Cem.M3e.ButtonGroup.\* as rawAttr
  - Escape: none (strict child kind: { button })
  - Tag: buttonGroup


# Types

@docs Option, Variant, Size

@docs view


# Options

@docs variant, size, multi

-}

import Cem.M3e.ButtonGroup as Cem
import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node


{-| Group appearance variant.
-}
type Variant
    = Standard
    | Connected


{-| Size applied to the whole group.
-}
type Size
    = ExtraSmall
    | Small
    | Medium
    | Large
    | ExtraLarge


type alias Config =
    { variant : Variant
    , size : Size
    , multi : Bool
    }


{-| A button group configuration option. Build with the option functions below
and pass a list to [`view`](#view).
-}
type alias Option msg =
    Internal.Option Config msg


{-| Set the group appearance variant (default `Standard`).
-}
variant : Variant -> Option msg
variant v =
    Internal.option (\c -> { c | variant = v })


{-| Set the size applied to the whole group (default `Small`).
-}
size : Size -> Option msg
size s =
    Internal.option (\c -> { c | size = s })


{-| Allow more than one toggle button in the group to be selected at
once (m3e `multi` property, default false).
-}
multi : Bool -> Option msg
multi b =
    Internal.option (\c -> { c | multi = b })


{-| Render the button group wrapping the required `buttons`.
-}
view :
    { buttons : List (Element { button : Supported } msg) }
    -> List (Option msg)
    -> Element { s | buttonGroup : Supported } msg
view req opts =
    let
        c : Config
        c =
            Internal.applyOptions opts
                { variant = Standard, size = Small, multi = False }
    in
    Internal.fromNode
        (Node.element "m3e-button-group"
            [ Node.rawAttr (Cem.variant (toCemVariant c.variant))
            , Node.rawAttr (Cem.size (toCemSize c.size))
            , Node.property "multi" (Encode.bool c.multi)
            ]
            (List.map Element.toNode req.buttons)
        )


toCemVariant : Variant -> Cem.Variant
toCemVariant v =
    case v of
        Standard ->
            Cem.Standard

        Connected ->
            Cem.Connected


toCemSize : Size -> Cem.Size
toCemSize s =
    case s of
        ExtraSmall ->
            Cem.ExtraSmall

        Small ->
            Cem.Small

        Medium ->
            Cem.Medium

        Large ->
            Cem.Large

        ExtraLarge ->
            Cem.ExtraLarge
