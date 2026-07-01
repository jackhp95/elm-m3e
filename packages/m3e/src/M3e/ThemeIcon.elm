module M3e.ThemeIcon exposing (themeIcon)

{-| 
@docs themeIcon
-}


import M3e.Cem.Attr
import M3e.Cem.ThemeIcon
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-theme-icon>` element (lazy IR). -}
themeIcon :
    List (M3e.Cem.Attr.Attr { color : M3e.Value.Supported
    , scheme : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | themeIcon : M3e.Value.Supported } msg
themeIcon attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.ThemeIcon.themeIcon
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Element.toNode children)
        )