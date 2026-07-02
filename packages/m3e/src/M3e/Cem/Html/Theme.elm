module M3e.Cem.Html.Theme exposing
    ( theme, color, contrast, density, scheme, strongFocus
    , variant, motion, onChange
    )

{-|
Bottom layer for `<m3e-theme>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs theme, color, contrast, density, scheme, strongFocus
@docs variant, motion, onChange
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-theme>` element — a partial application of `Html.node`. -}
theme : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
theme =
    Html.node "m3e-theme"


{-| The hex color from which to derive dynamic color palettes. (default: `"#6750A4"`) -}
color : String -> Html.Attribute msg
color =
    Html.Attributes.attribute "color"


{-| The contrast level of the theme. (default: `"standard"`) -}
contrast : String -> Html.Attribute msg
contrast =
    Html.Attributes.attribute "contrast"


{-| The density scale (0, -1, -2). (default: `0`) -}
density : Float -> Html.Attribute msg
density val_ =
    Html.Attributes.property "density" (Json.Encode.float val_)


{-| The color scheme of the theme. (default: `"auto"`) -}
scheme : String -> Html.Attribute msg
scheme =
    Html.Attributes.attribute "scheme"


{-| Whether to enable strong focus indicators. (default: `false`) -}
strongFocus : Bool -> Html.Attribute msg
strongFocus val_ =
    Html.Attributes.property "strongFocus" (Json.Encode.bool val_)


{-| The color variant of the theme. (default: `"neutral"`) -}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"


{-| The motion scheme. (default: `"standard"`) -}
motion : String -> Html.Attribute msg
motion =
    Html.Attributes.attribute "motion"


{-| Listen for `change` events. -}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange =
    Html.Events.on "change"