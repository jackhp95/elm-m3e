module M3e.Field exposing (view)

{-| Wires `<label for=id>` to `<control id=id>` by stamping the id onto the
control's real element — the relational composition `Ui.Select` got wrong (#13),
here a couple of IR rewrites instead of a slot-name guess.

The `control` field accepts a closed row of the labelable form-control kinds
plus the `element` escape — so a real form control (or a custom element via
`Renderable.element`) is accepted, but the raw `Renderable.html` escape is a
**compile error**: its node is `Raw`, and `Node.setAttribute "id"` no-ops on a
`Raw`/`Text` node, which would silently drop the `for`↔`id` relation (#44/#13).

@docs view

-}

import M3e.Label as Label exposing (Label)
import M3e.Node as Node exposing (Node)
import M3e.Renderable as Renderable exposing (Renderable, Supported)


{-| Render a labeled form field, wiring `<label for=id>` to the control's `id`.
-}
view :
    { id : String
    , label : Label msg
    , control :
        Renderable
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
    -> Node msg
view config =
    Node.element "m3e-form-field"
        []
        [ Node.element "label"
            [ Node.attribute "for" config.id ]
            [ Node.raw (Label.toHtml config.label) ]
        , Renderable.toNode config.control
            |> Node.setAttribute "id" config.id
        ]
