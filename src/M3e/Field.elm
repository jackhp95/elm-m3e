module M3e.Field exposing
    ( Option
    , variant
    , view
    )

{-| Wires `<label for=id>` to `<control id=id>` by stamping the id onto the
control's real element — the relational composition `Ui.Select` got wrong (#13),
here a couple of IR rewrites instead of a slot-name guess.

The `control` field accepts a closed row of the labelable form-control kinds
plus the `element` escape — so a real form control (or a custom element via
`Element.element`) is accepted, but the raw `Element.html` escape is a
**compile error**: its node is `Raw`, and `Node.setAttribute "id"` no-ops on a
`Raw`/`Text` node, which would silently drop the `for`↔`id` relation (#44/#13).


# Types

@docs Option


# Options

@docs variant

@docs view

-}

import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Label as Label exposing (Label)
import M3e.Node as Node exposing (Node)
import M3e.Value as Value exposing (Value)



-- TYPES -----------------------------------------------------------------------


{-| Visual variant for the field container, supplied as shared
[`M3e.Value`](M3e-Value) tokens.

  - `outlined` — default; field with an outline border.
  - `filled` — field with a filled background.

Upstream: `variant` attribute on `<m3e-form-field>`.
CEM: `FormFieldVariant` — default `"outlined"`.

-}
type alias Variants =
    Value
        { outlined : Supported
        , filled : Supported
        }


type alias Config =
    { variant : Maybe Variants }


{-| An opaque option for [`view`](#view).
-}
type alias Option msg =
    Internal.Option Config msg



-- OPTIONS ---------------------------------------------------------------------


{-| Set the field variant (`outlined` or `filled`; default `outlined`).

Upstream: `variant` attribute on `<m3e-form-field>`.

-}
variant : Variants -> Option msg
variant v =
    Internal.option (\c -> { c | variant = Just v })



-- VIEW ------------------------------------------------------------------------


{-| Render a labeled form field, wiring `<label for=id>` to the control's `id`.
-}
view :
    { id : String
    , label : Label msg
    , control :
        Element
            { switch : Supported
            , checkbox : Supported
            , slider : Supported
            , radioButton : Supported
            , select : Supported
            , textField : Supported
            , timePicker : Supported
            , datePicker : Supported
            , segment : Supported
            , element : Supported
            }
            msg
    }
    -> List (Option msg)
    -> Node msg
view config opts =
    let
        c : Config
        c =
            Internal.applyOptions opts { variant = Nothing }
    in
    Node.element "m3e-form-field"
        (List.filterMap identity
            [ Maybe.map (\v -> Node.attribute "variant" (Value.toString v)) c.variant
            ]
        )
        [ Node.element "label"
            [ Node.attribute "for" config.id ]
            [ Node.raw (Label.toHtml config.label) ]
        , Element.toNode config.control
            |> Node.setAttribute "id" config.id
        ]
