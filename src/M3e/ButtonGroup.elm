module M3e.ButtonGroup exposing
    ( Option, Variant(..)
    , view
    , variant, size, multi
    )

{-| `<m3e-button-group>` — a connected row of buttons (Material 3 Button
groups, M3 Expressive).

Spec (per docs/CONVENTIONS.md):

  - Required: { buttons : List (Element { button : Supported, iconButton : Supported } msg) }
    (heterogeneous list slot — accepts both `m3e-button` and
    `m3e-icon-button` per the upstream `m3e-button-group` default slot)
  - Options: variant, size, multi
  - Slots: default slot ← `m3e-button` / `m3e-icon-button` children
  - Properties: multi (Node.property — introspectable)
  - Attrs: variant/size via Cem.M3e.ButtonGroup.\* as rawAttr
  - Escape: slot type is `any` — accepts both buttons and icon buttons
  - Tag: buttonGroup


# Types

@docs Option, Variant

@docs view


# Options

@docs variant, size, multi

-}

import Cem.M3e.ButtonGroup as Cem
import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Value as Value exposing (Value)


{-| Group appearance variant.
-}
type Variant
    = Standard
    | Connected


{-| Sizes applied to the whole group, supplied as shared
[`M3e.Value`](M3e-Value) tokens.
-}
type alias Sizes =
    Value
        { extraSmall : Supported
        , small : Supported
        , medium : Supported
        , large : Supported
        , extraLarge : Supported
        }


type alias Config =
    { variant : Variant
    , size : Sizes
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


{-| Set the size applied to the whole group (default
[`M3e.Value.small`](M3e-Value#small)).
-}
size : Sizes -> Option msg
size s =
    Internal.option (\c -> { c | size = s })


{-| Allow more than one toggle button in the group to be selected at
once (m3e `multi` property, default false).
-}
multi : Bool -> Option msg
multi b =
    Internal.option (\c -> { c | multi = b })


{-| Render the button group wrapping the required `buttons`.

The upstream `<m3e-button-group>` default slot accepts both `<m3e-button>` and
`<m3e-icon-button>`. The slot type is `any` to reflect this — pass buttons
from `M3e.Button.view` or icon buttons from `M3e.IconButton.view`.

-}
view :
    { buttons : List (Element { button : Supported, iconButton : Supported } msg) }
    -> List (Option msg)
    -> Element { s | buttonGroup : Supported } msg
view req opts =
    let
        c : Config
        c =
            Internal.applyOptions opts
                { variant = Standard, size = Value.small, multi = False }
    in
    Internal.fromNode
        (Node.element "m3e-button-group"
            [ Node.rawAttr (Cem.variant (toCemVariant c.variant))
            , Node.attribute "size" (Value.toString c.size)
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
