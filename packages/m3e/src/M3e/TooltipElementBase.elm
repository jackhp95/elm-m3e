module M3e.TooltipElementBase exposing (tooltipElementBase)

{-| 
@docs tooltipElementBase
-}


import M3e.Cem.Attr
import M3e.Cem.TooltipElementBase
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<div>` element (lazy IR). -}
tooltipElementBase :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , showDelay : M3e.Value.Supported
    , hideDelay : M3e.Value.Supported
    , touchGestures : M3e.Value.Supported
    , for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | tooltipElementBase : M3e.Value.Supported } msg
tooltipElementBase attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.TooltipElementBase.tooltipElementBase
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Element.toNode children)
        )