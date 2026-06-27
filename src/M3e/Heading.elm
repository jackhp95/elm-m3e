module M3e.Heading exposing
    ( view
    , Option, Size(..), Variant(..)
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
@docs Option, Size, Variant
@docs size, emphasized, level

-}

import Cem.M3e.Heading as Cem
import Json.Encode as Encode
import M3e.Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node


{-| Typescale variant. Mirrors `m3e-heading` `variant` enum. Default `Display`.
-}
type Variant
    = Display
    | Headline
    | Title
    | Label


{-| Three-step size scale. Mirrors `m3e-heading` `size` enum. Default `Medium`.
-}
type Size
    = Small
    | Medium
    | Large


type alias Config =
    { size : Maybe Size
    , emphasized : Bool
    , level : Maybe Int
    }


{-| Configuration option for `view`.
-}
type alias Option msg =
    Internal.Option Config msg


{-| Set the heading size (`Small`, `Medium`, `Large`). Default `Medium`.
-}
size : Size -> Option msg
size s =
    Internal.option (\c -> { c | size = Just s })


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
view : { label : String, variant : Variant } -> List (Option msg) -> Element { s | heading : Supported } msg
view req opts =
    let
        c : Config
        c =
            Internal.applyOptions opts
                { size = Nothing
                , emphasized = False
                , level = Nothing
                }
    in
    Internal.fromNode
        (Node.element "m3e-heading"
            (List.filterMap identity
                [ Just (Node.rawAttr (Cem.variant (toCemVariant req.variant)))
                , Maybe.map (\s -> Node.rawAttr (Cem.size (toCemSize s))) c.size
                , if c.emphasized then
                    Just (Node.property "emphasized" (Encode.bool True))

                  else
                    Nothing
                , Maybe.map (\l -> Node.rawAttr (Cem.level (String.fromInt l))) c.level
                ]
            )
            [ Node.text req.label ]
        )


toCemVariant : Variant -> Cem.Variant
toCemVariant v =
    case v of
        Display ->
            Cem.Display

        Headline ->
            Cem.Headline

        Title ->
            Cem.Title

        Label ->
            Cem.Label


toCemSize : Size -> Cem.Size
toCemSize s =
    case s of
        Small ->
            Cem.Small

        Medium ->
            Cem.Medium

        Large ->
            Cem.Large
