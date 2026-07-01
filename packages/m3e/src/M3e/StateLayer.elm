module M3e.StateLayer exposing (stateLayer)

{-| 
@docs stateLayer
-}


import M3e.Cem.Attr
import M3e.Cem.StateLayer
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-state-layer>` element (lazy IR). -}
stateLayer :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disableHover : M3e.Value.Supported
    , for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | stateLayer : M3e.Value.Supported } msg
stateLayer attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.StateLayer.stateLayer
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Element.toNode children)
        )