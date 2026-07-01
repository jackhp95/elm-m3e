module M3e.PseudoCheckbox exposing (pseudoCheckbox)

{-| 
@docs pseudoCheckbox
-}


import M3e.Cem.Attr
import M3e.Cem.PseudoCheckbox
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-pseudo-checkbox>` element (lazy IR). -}
pseudoCheckbox :
    List (M3e.Cem.Attr.Attr { checked : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , indeterminate : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | pseudoCheckbox : M3e.Value.Supported } msg
pseudoCheckbox attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.PseudoCheckbox.pseudoCheckbox
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Element.toNode children)
        )