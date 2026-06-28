module M3e.Field exposing
    ( Option, Variant(..)
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

@docs Option, Variant


# Options

@docs variant

@docs view

-}

import Cem.M3e.FormField as CemField
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Label as Label exposing (Label)
import M3e.Node as Node exposing (Node)



-- TYPES -----------------------------------------------------------------------


{-| Visual variant for the field container.

  - `Outlined` — default; field with an outline border.
  - `Filled` — field with a filled background.

Upstream: `variant` attribute on `<m3e-form-field>`.
CEM: `FormFieldVariant` — default `"outlined"`.

-}
type Variant
    = Outlined
    | Filled


type alias Config =
    { variant : Maybe Variant }


{-| An opaque option for [`view`](#view).
-}
type alias Option msg =
    Internal.Option Config msg



-- OPTIONS ---------------------------------------------------------------------


{-| Set the field variant (`Outlined` or `Filled`; default `Outlined`).

Upstream: `variant` attribute on `<m3e-form-field>`.

-}
variant : Variant -> Option msg
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
            [ Maybe.map (\v -> Node.attribute "variant" (CemField.variantToString (toCemVariant v))) c.variant
            ]
        )
        [ Node.element "label"
            [ Node.attribute "for" config.id ]
            [ Node.raw (Label.toHtml config.label) ]
        , Element.toNode config.control
            |> Node.setAttribute "id" config.id
        ]



-- INTERNAL --------------------------------------------------------------------


toCemVariant : Variant -> CemField.Variant
toCemVariant v =
    case v of
        Outlined ->
            CemField.Outlined

        Filled ->
            CemField.Filled
