module M3e.PseudoRadio exposing (pseudoRadio)

{-| 
@docs pseudoRadio
-}


import M3e.Cem.Attr
import M3e.Cem.PseudoRadio
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-pseudo-radio>` element (lazy IR). -}
pseudoRadio :
    List (M3e.Cem.Attr.Attr { checked : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | pseudoRadio : M3e.Value.Supported } msg
pseudoRadio attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.PseudoRadio.pseudoRadio
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Element.toNode children)
        )