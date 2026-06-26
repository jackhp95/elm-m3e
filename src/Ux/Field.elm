module Ux.Field exposing (view)

{-| Wires `<label for=id>` to `<control id=id>` by stamping the id onto the
control's real element — the relational composition `Ui.Select` got wrong (#13),
here a couple of IR rewrites instead of a slot-name guess.
-}

import Ux.Label as Label exposing (Label)
import Ux.Node as Node exposing (Node)
import Ux.Renderable as Renderable exposing (Renderable)


view : { id : String, label : Label msg, control : Renderable any msg } -> Node msg
view config =
    Node.element "m3e-form-field"
        []
        [ Node.element "label"
            [ Node.attribute "for" config.id ]
            [ Node.raw (Label.toHtml config.label) ]
        , Renderable.toNode config.control
            |> Node.setAttribute "id" config.id
        ]
