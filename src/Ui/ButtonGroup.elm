module Ui.ButtonGroup exposing
    ( ButtonGroup
    , Size(..), Variant(..)
    , new
    , withAttributes
    , withSize, withMulti, withVariant
    , view
    )

{-| Typed builder for `<m3e-button-group>` — a connected row of buttons.
Mirrors the Material 3 [Button groups][m3] surface.

[m3]: https://m3.material.io/components/button-groups/overview

In M3 Expressive, button groups replace segmented buttons for most
button-row patterns. Each button keeps its own action wiring; the group
provides connected visual treatment (shared rounded ends, no gaps).


# Type

@docs ButtonGroup


# Configuration

@docs Size, Variant


# Constructor

@docs new


# Host attributes

@docs withAttributes


# Modifiers

@docs withSize, withMulti, withVariant


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Cem.M3e.ButtonGroup
import Ui.Button


{-| A button group.
-}
type ButtonGroup msg
    = ButtonGroup (Config msg)


type alias Config msg =
    { size : Size
    , attributes : List (Attribute msg)
    , multi : Bool
    , variant : Variant
    , buttons : List (Ui.Button.Button msg)
    }


{-| Size applied to the whole group (m3e `size`). The m3e element
defaults to `small`; this builder's `new` defaults to `Medium`.
-}
type Size
    = ExtraSmall
    | Small
    | Medium
    | Large
    | ExtraLarge


{-| Group variant. `Connected` gives the M3 Expressive connected
treatment (shared rounded ends, no gaps); `Standard` is the default
separated row.
-}
type Variant
    = Standard
    | Connected


{-| Construct a button group.
-}
new : List (Ui.Button.Button msg) -> ButtonGroup msg
new buttons =
    ButtonGroup { size = Medium, attributes = [], multi = False, variant = Standard, buttons = buttons }


{-| Append attributes to the underlying `<m3e-button-group>` host element — the
escape hatch for styling the component itself. Structural attributes are emitted
after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> ButtonGroup msg -> ButtonGroup msg
withAttributes attributes (ButtonGroup cfg) =
    ButtonGroup { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the size for the whole group (m3e `size`; builder default
`Medium`).
-}
withSize : Size -> ButtonGroup msg -> ButtonGroup msg
withSize s (ButtonGroup cfg) =
    ButtonGroup { cfg | size = s }


{-| Allow more than one toggle button in the group to be selected at
once (m3e `multi`, default false).
-}
withMulti : Bool -> ButtonGroup msg -> ButtonGroup msg
withMulti b (ButtonGroup cfg) =
    ButtonGroup { cfg | multi = b }


{-| Set the variant. Use `Connected` for the M3 Expressive connected
button row.
-}
withVariant : Variant -> ButtonGroup msg -> ButtonGroup msg
withVariant v (ButtonGroup cfg) =
    ButtonGroup { cfg | variant = v }


{-| Render the button group.
-}
view : ButtonGroup msg -> Html msg
view (ButtonGroup cfg) =
    Cem.M3e.ButtonGroup.component
        (cfg.attributes
            ++ [ sizeAttr cfg.size
               , Cem.M3e.ButtonGroup.multi cfg.multi
               , variantAttr cfg.variant
               ]
        )
        (List.map Ui.Button.view cfg.buttons)


variantAttr : Variant -> Html.Attribute msg
variantAttr v =
    case v of
        Standard ->
            Cem.M3e.ButtonGroup.variant Cem.M3e.ButtonGroup.Standard

        Connected ->
            Cem.M3e.ButtonGroup.variant Cem.M3e.ButtonGroup.Connected


sizeAttr : Size -> Html.Attribute msg
sizeAttr s =
    case s of
        ExtraSmall ->
            Cem.M3e.ButtonGroup.size Cem.M3e.ButtonGroup.ExtraSmall

        Small ->
            Cem.M3e.ButtonGroup.size Cem.M3e.ButtonGroup.Small

        Medium ->
            Cem.M3e.ButtonGroup.size Cem.M3e.ButtonGroup.Medium

        Large ->
            Cem.M3e.ButtonGroup.size Cem.M3e.ButtonGroup.Large

        ExtraLarge ->
            Cem.M3e.ButtonGroup.size Cem.M3e.ButtonGroup.ExtraLarge
