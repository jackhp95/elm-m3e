module M3e.FabMenuTrigger exposing (fabMenuTrigger)

{-| 
@docs fabMenuTrigger
-}


import M3e.Cem.Attr
import M3e.Cem.FabMenuTrigger
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-fab-menu-trigger>` element (lazy IR). -}
fabMenuTrigger :
    List (M3e.Cem.Attr.Attr { for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | fabMenuTrigger : M3e.Value.Supported } msg
fabMenuTrigger attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.FabMenuTrigger.fabMenuTrigger
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Element.toNode children)
        )