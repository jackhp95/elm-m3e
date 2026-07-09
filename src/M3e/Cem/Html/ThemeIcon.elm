module M3e.Cem.Html.ThemeIcon exposing ( themeIcon, color, scheme, variant )

{-|
Bottom layer for `<m3e-theme-icon>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs themeIcon, color, scheme, variant
-}


import Html
import Html.Attributes


{-| The raw `<m3e-theme-icon>` element — a partial application of `Html.node`. -}
themeIcon : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
themeIcon =
    Html.node "m3e-theme-icon"


{-| The hex color of the theme to preview (default: `"#6750A4"`) -}
color : String -> Html.Attribute msg
color =
    Html.Attributes.attribute "color"


{-| The color scheme of the theme. (default: `"auto"`) -}
scheme : String -> Html.Attribute msg
scheme =
    Html.Attributes.attribute "scheme"


{-| The color variant of the theme. (default: `"neutral"`) -}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"