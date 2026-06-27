module M3e.Toolbar exposing
    ( view
    , Option
    , Shape(..), Variant(..)
    , elevated, vertical, shape, variant
    )

{-| `<m3e-toolbar>` — an in-flow row of contextual action controls (Material 3
Toolbars).

Spec (per docs/CONVENTIONS.md):

  - Required: { content : List (Renderable any msg) }
    A spec-heterogeneous free row — buttons, icon buttons, dividers,
    custom controls, etc. No slot injection (default slot; html
    escape is valid).
  - Options: elevated, vertical, shape, variant
  - Slots: default (content region — free row)
  - Properties: elevated, vertical (Bool DOM properties)
  - Attrs: shape, variant (rawAttr enums via Cem.M3e.Toolbar)
  - Escape: html (default-slot region; include via Renderable.html)
  - Tag: toolbar

@docs view
@docs Option
@docs Shape, Variant
@docs elevated, vertical, shape, variant

-}

import Cem.M3e.Toolbar as Cem
import Json.Encode as Encode
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


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
                |> M3e.Renderable.map identity
            ]
        }
        [ M3e.Toolbar.elevated True ]

Content is a free row — any `Renderable` kind is accepted, including the
`Renderable.html` escape for raw Html.

-}
view :
    { content : List (Renderable any msg) }
    -> List (Option msg)
    -> Renderable { s | toolbar : Supported } msg
view req opts =
    let
        c =
            Internal.applyOptions opts defaultConfig
    in
    Internal.fromNode
        (Node.element "m3e-toolbar"
            (List.filterMap identity
                [ if c.elevated then
                    Just (Node.property "elevated" (Encode.bool True))

                  else
                    Nothing
                , if c.vertical then
                    Just (Node.property "vertical" (Encode.bool True))

                  else
                    Nothing
                , Just (Node.rawAttr (Cem.shape (toCemShape c.shape)))
                , Just (Node.rawAttr (Cem.variant (toCemVariant c.variant)))
                ]
            )
            (List.map Renderable.toNode req.content)
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
