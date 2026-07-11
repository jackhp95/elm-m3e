module M3e.Html.ThemeIcon exposing (themeIcon, color, scheme, variant)

{-| Middle layer for `<m3e-theme-icon>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.ThemeIcon` module for everyday use.

@docs themeIcon, color, scheme, variant

-}

import Html
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.ThemeIcon
import M3e.Token


{-| An icon that visually presents a preview of a theme.

**Component Info:**

  - **Extends:** `LitElement`

-}
themeIcon :
    List
        (M3e.Html.Attr.Attr
            { color : M3e.Token.Supported
            , scheme : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
themeIcon attributes children =
    M3e.Raw.ThemeIcon.themeIcon
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| The hex color of the theme to preview (default: `"#6750A4"`)
-}
color : String -> M3e.Html.Attr.Attr { c | color : M3e.Token.Supported } msg
color =
    M3e.Html.Attr.Internal.attribute M3e.Raw.ThemeIcon.color


{-| The color scheme of the theme. (default: `"auto"`)
-}
scheme :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , dark : M3e.Token.Supported
        , light : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | scheme : M3e.Token.Supported } msg
scheme v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.ThemeIcon.scheme
        (M3e.Token.toString v_)


{-| The color variant of the theme. (default: `"neutral"`)
-}
variant :
    M3e.Token.Value
        { content : M3e.Token.Supported
        , expressive : M3e.Token.Supported
        , fidelity : M3e.Token.Supported
        , fruitSalad : M3e.Token.Supported
        , monochrome : M3e.Token.Supported
        , neutral : M3e.Token.Supported
        , rainbow : M3e.Token.Supported
        , tonalSpot : M3e.Token.Supported
        , vibrant : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.ThemeIcon.variant
        (M3e.Token.toString v_)
