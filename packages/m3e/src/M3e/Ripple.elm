module M3e.Ripple exposing (ripple)

{-| 
@docs ripple
-}


import M3e.Cem.Attr
import M3e.Cem.Ripple
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-ripple>` element (lazy IR). -}
ripple :
    List (M3e.Cem.Attr.Attr { centered : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , for : M3e.Value.Supported
    , radius : M3e.Value.Supported
    , unbounded : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | ripple : M3e.Value.Supported } msg
ripple attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.Ripple.ripple (List.map M3e.Cem.Attr.forget erased) ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Element.toNode children)
        )