module M3e.Toolbar exposing
    ( view
    , Option
    , Shape(..), Variant(..)
    , elevated, vertical, shape, variant
    )

{-| `<m3e-toolbar>` — an in-flow row of contextual action controls (Material 3
Toolbars).

Spec (per docs/CONVENTIONS.md):

  - Required: { content : List (Element any msg) }
    A spec-heterogeneous free row — buttons, icon buttons, dividers,
    custom controls, etc. No slot injection (default slot; html
    escape is valid).
  - Options: elevated, vertical, shape, variant
  - Slots: default (content region — free row)
  - Properties: elevated, vertical (Bool DOM properties)
  - Attrs: shape, variant (rawAttr enums via Cem.M3e.Toolbar)
  - Escape: html (default-slot region; include via Element.html)
  - Tag: toolbar

@docs view
@docs Option
@docs Shape, Variant
@docs elevated, vertical, shape, variant

-}

import Cem.M3e.Toolbar as Cem
import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node


{-| The shape of the toolbar corners. `Square` is the element default.
-}
type Shape
    = Square
    | Rounded


{-| The appearance variant of the toolbar. `Standard` is the element default.
-}
type Variant
    = Standard
    | Vibrant


{-| An option configuring the `<m3e-toolbar>` element.
-}
type alias Option msg =
    Internal.Option Config msg


{-| Raise the toolbar above content with a shadow. Default false (flat).
-}
elevated : Bool -> Option msg
elevated b =
    Internal.option (\c -> { c | elevated = b })


{-| Orient the toolbar vertically (stacks children as a column). Default false
(horizontal row).
-}
vertical : Bool -> Option msg
vertical b =
    Internal.option (\c -> { c | vertical = b })


{-| Set the toolbar's corner shape. Default `Square`.
-}
shape : Shape -> Option msg
shape s =
    Internal.option (\c -> { c | shape = s })


{-| Set the appearance variant. Default `Standard`.
-}
variant : Variant -> Option msg
variant v =
    Internal.option (\c -> { c | variant = v })


type alias Config =
    { elevated : Bool
    , vertical : Bool
    , shape : Shape
    , variant : Variant
    }


defaultConfig : Config
defaultConfig =
    { elevated = False
    , vertical = False
    , shape = Square
    , variant = Standard
    }


{-| Render the toolbar as an introspectable IR node.

    M3e.Toolbar.view
        { content =
            [ M3e.Button.view { label = "Save", variant = M3e.Button.Filled }
                [ M3e.Button.onClick Saved ]
                |> M3e.Element.map identity
            ]
        }
        [ M3e.Toolbar.elevated True ]

Content is a free row — any `Element` kind is accepted, including the
`Element.html` escape for raw Html.

-}
view :
    { content : List (Element any msg) }
    -> List (Option msg)
    -> Element { s | toolbar : Supported } msg
view req opts =
    let
        c : Config
        c =
            Internal.applyOptions opts defaultConfig
    in
    Internal.fromNode
        (Node.element "m3e-toolbar"
            [ Node.property "elevated" (Encode.bool c.elevated)
            , Node.property "vertical" (Encode.bool c.vertical)
            , Node.rawAttr (Cem.shape (toCemShape c.shape))
            , Node.rawAttr (Cem.variant (toCemVariant c.variant))
            ]
            (List.map Element.toNode req.content)
        )


toCemShape : Shape -> Cem.Shape
toCemShape s =
    case s of
        Square ->
            Cem.Square

        Rounded ->
            Cem.Rounded


toCemVariant : Variant -> Cem.Variant
toCemVariant v =
    case v of
        Standard ->
            Cem.Standard

        Vibrant ->
            Cem.Vibrant
