module M3e.Cem.ThemeIcon exposing ( themeIcon, color, scheme, variant )

{-|
Middle layer for `<m3e-theme-icon>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.ThemeIcon` module for everyday use.

@docs themeIcon, color, scheme, variant
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.ThemeIcon
import M3e.Value


{-| An icon that visually presents a preview of a theme.

**Component Info:**
- **Extends:** `LitElement`
-}
themeIcon :
    List (M3e.Cem.Attr.Attr { color : M3e.Value.Supported
    , scheme : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
themeIcon attributes children =
    M3e.Cem.Html.ThemeIcon.themeIcon
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The hex color of the theme to preview (default: `"#6750A4"`) -}
color : String -> M3e.Cem.Attr.Attr { c | color : M3e.Value.Supported } msg
color =
    M3e.Cem.Attr.attribute M3e.Cem.Html.ThemeIcon.color


{-| The color scheme of the theme. (default: `"auto"`) -}
scheme :
    M3e.Value.Value { auto : M3e.Value.Supported
    , dark : M3e.Value.Supported
    , light : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | scheme : M3e.Value.Supported } msg
scheme v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.ThemeIcon.scheme (M3e.Value.toString v_)


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
variant v_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.ThemeIcon.variant
        (M3e.Value.toString v_)