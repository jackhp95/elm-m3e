module M3e.ThemeIcon exposing (view, color, scheme, variant)

{-| An icon that visually presents a preview of a theme.

**Component Info:**

  - **Extends:** `LitElement`

@docs view, color, scheme, variant

-}

import M3e.Html.ThemeIcon
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-theme-icon>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { color : M3e.Token.Supported
            , scheme : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | themeIcon : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.ThemeIcon.themeIcon
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| The hex color of the theme to preview (default: `"#6750A4"`)
-}
color : String -> Markup.Html.Attr.Attr { c | color : M3e.Token.Supported } msg
color =
    M3e.Html.ThemeIcon.color


{-| The color scheme of the theme. (default: `"auto"`)
-}
scheme :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , dark : M3e.Token.Supported
        , light : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | scheme : M3e.Token.Supported } msg
scheme =
    M3e.Html.ThemeIcon.scheme


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
    -> Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant =
    M3e.Html.ThemeIcon.variant
