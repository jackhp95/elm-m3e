module M3e.Optgroup exposing (child, children, label, optgroup)

{-| 
@docs optgroup, child, label, children
-}


import M3e.Cem.Attr
import M3e.Cem.Optgroup
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-optgroup>` element (lazy IR). -}
optgroup :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , label : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | optgroup : M3e.Value.Supported } msg
optgroup attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.Optgroup.optgroup
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Content.toNode content_)
        )


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { option : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place content in the `label` slot. -}
label :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | label : M3e.Value.Supported } msg
label el =
    M3e.Content.slot "label" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { option : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els