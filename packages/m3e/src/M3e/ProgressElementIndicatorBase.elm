module M3e.ProgressElementIndicatorBase exposing (progressElementIndicatorBase)

{-| 
@docs progressElementIndicatorBase
-}


import M3e.Cem.Attr
import M3e.Cem.ProgressElementIndicatorBase
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<div>` element (lazy IR). -}
progressElementIndicatorBase :
    List (M3e.Cem.Attr.Attr { value : M3e.Value.Supported
    , max : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s
        | progressElementIndicatorBase : M3e.Value.Supported
    } msg
progressElementIndicatorBase attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.ProgressElementIndicatorBase.progressElementIndicatorBase
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Element.toNode children)
        )