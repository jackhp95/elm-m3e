module M3e.Icon exposing (icon)

{-| 
@docs icon
-}


import M3e.Cem.Attr
import M3e.Cem.Icon
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-icon>` element (lazy IR). -}
icon :
    List (M3e.Cem.Attr.Attr { filled : M3e.Value.Supported
    , grade : M3e.Value.Supported
    , opticalSize : M3e.Value.Supported
    , name : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , weight : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | icon : M3e.Value.Supported } msg
icon attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.Icon.icon (List.map M3e.Cem.Attr.forget erased) ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Element.toNode children)
        )