module M3e.Elevation exposing (elevation)

{-| 
@docs elevation
-}


import M3e.Cem.Attr
import M3e.Cem.Elevation
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-elevation>` element (lazy IR). -}
elevation :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , for : M3e.Value.Supported
    , level : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | elevation : M3e.Value.Supported } msg
elevation attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.Elevation.elevation
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Element.toNode children)
        )