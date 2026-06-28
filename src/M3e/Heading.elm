module M3e.Heading exposing
    ( view
    , Option
    , size, emphasized, level
    )

{-| `<m3e-heading>` — a Material 3 typescale heading.

Spec (per docs/CONVENTIONS.md):

  - Required: { label : String, variant : Variant }
    (label is visible text → it IS the accessible name; no separate
    a11y field. Variant is mutually exclusive — required sum field.)
  - Options: size, emphasized, level
  - Slots: default slot ← text content (label as Node.text child)
  - Properties: emphasized — via Node.property (Cem uses Html.Attributes.property)
  - Attrs: variant, size, level — via Node.rawAttr (Cem uses Html.Attributes.attribute)
  - Escape: none (leaf — content is fixed string)
  - Tag: heading

The `level` option is clamped to the CEM-permitted range 1..6 (same as
`Ui.Heading.clampLevel`).

@docs view
@docs Option
@docs size, emphasized, level

-}

import Cem.M3e.Heading as Cem
import Json.Encode as Encode
import M3e.Attr as Attr
import M3e.Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Value as Value exposing (AxisSupports, Value)


{-| Typescale variant (`display`, `headline`, `title`, `label`), supplied as
shared [`M3e.Value`](M3e-Value) tokens. A required field of [`view`](#view).
-}
type alias Variants =
    Value
        { display : Supported
        , headline : Supported
        , title : Supported
        , label : Supported
        }


{-| Three-step size scale (`small`, `medium`, `large`). The supported-value row
for the `size` axis. Mirrors `m3e-heading` `size` enum.
-}
type alias Sizes =
    { small : Supported
    , medium : Supported
    , large : Supported
    }


type alias Config =
    { size : AxisSupports Sizes
    , emphasized : Bool
    , level : Maybe Int
    }


{-| Configuration option for `view`.
-}
type alias Option msg =
    Internal.Option Config msg


{-| Set the heading size (`small`, `medium`, `large`). Omitted when unset.
Re-export of [`M3e.Attr.size`](M3e-Attr#size).
-}
size : Value Sizes -> Option msg
size =
    Attr.size


{-| Toggle the emphasized typescale (default `False`). When `True`, the heading
uses M3's emphasized type tokens for extra prominence. Maps to the `emphasized`
DOM property.
-}
emphasized : Bool -> Option msg
emphasized b =
    Internal.option (\c -> { c | emphasized = b })


{-| Set the accessibility level (clamped to 1..6). Maps to the `level`
attribute.
-}
level : Int -> Option msg
level l =
    Internal.option (\c -> { c | level = Just (clamp 1 6 l) })


{-| Render the heading with its required `label` and `variant`.
-}
view : { label : String, variant : Variants } -> List (Option msg) -> Element { s | heading : Supported } msg
view req opts =
    let
        c : Config
        c =
            Internal.applyOptions opts
                { size = Value.emptyAxis
                , emphasized = False
                , level = Nothing
                }
    in
    Internal.fromNode
        (Node.element "m3e-heading"
            (List.filterMap identity
                [ Just (Node.attribute "variant" (Value.toString req.variant))
                , Maybe.map (Node.attribute "size") (Value.axisString c.size)
                , Just (Node.property "emphasized" (Encode.bool c.emphasized))
                , Maybe.map (\l -> Node.rawAttr (Cem.level (String.fromInt l))) c.level
                ]
            )
            [ Node.text req.label ]
        )
