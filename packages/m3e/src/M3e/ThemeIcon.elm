module M3e.ThemeIcon exposing (color, scheme, themeIcon, variant)

{-| 
@docs themeIcon, color, scheme, variant
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


{-| The hex color of the theme to preview (default: `"#6750A4"`) -}
color : String -> M3e.Cem.Attr.Attr { c | color : M3e.Value.Supported } msg
color =
    M3e.Cem.ThemeIcon.color


{-| The color scheme of the theme. (default: `"auto"`) -}
scheme :
    M3e.Value.Value { auto : M3e.Value.Supported
    , dark : M3e.Value.Supported
    , light : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | scheme : M3e.Value.Supported } msg
scheme =
    M3e.Cem.ThemeIcon.scheme


{-| The color variant of the theme. (default: `"neutral"`) -}
variant :
    M3e.Value.Value { content : M3e.Value.Supported
    , expressive : M3e.Value.Supported
    , fidelity : M3e.Value.Supported
    , fruitSalad : M3e.Value.Supported
    , monochrome : M3e.Value.Supported
    , neutral : M3e.Value.Supported
    , rainbow : M3e.Value.Supported
    , tonalSpot : M3e.Value.Supported
    , vibrant : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.ThemeIcon.variant