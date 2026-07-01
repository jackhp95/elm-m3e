module M3e.Cem.Theme exposing (color, contrast, density, motion, onChange, scheme, strongFocus, theme, variant)

{-| 
@docs theme, color, contrast, density, scheme, strongFocus, variant, motion, onChange
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.Theme
import M3e.Value


{-| A non-visual element responsible for application-level theming.

**Events:**
- `change`: Dispatched when the theme changes.
-}
theme :
    List (M3e.Cem.Attr.Attr { color : M3e.Value.Supported
    , contrast : M3e.Value.Supported
    , density : M3e.Value.Supported
    , scheme : M3e.Value.Supported
    , strongFocus : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , motion : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
theme attributes children =
    M3e.Cem.Html.Theme.theme
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The hex color from which to derive dynamic color palettes. (default: `"#6750A4"`) -}
color : String -> M3e.Cem.Attr.Attr { c | color : M3e.Value.Supported } msg
color =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Theme.color


{-| The contrast level of the theme. (default: `"standard"`) -}
contrast :
    M3e.Value.Value { high : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | contrast : M3e.Value.Supported } msg
contrast v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Theme.contrast (M3e.Value.toString v_)


{-| The density scale (0, -1, -2). (default: `0`) -}
density : Float -> M3e.Cem.Attr.Attr { c | density : M3e.Value.Supported } msg
density =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Theme.density


{-| The color scheme of the theme. (default: `"auto"`) -}
scheme :
    M3e.Value.Value { auto : M3e.Value.Supported
    , dark : M3e.Value.Supported
    , light : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | scheme : M3e.Value.Supported } msg
scheme v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Theme.scheme (M3e.Value.toString v_)


{-| Whether to enable strong focus indicators. (default: `false`) -}
strongFocus :
    Bool -> M3e.Cem.Attr.Attr { c | strongFocus : M3e.Value.Supported } msg
strongFocus =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Theme.strongFocus


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
    M3e.Cem.Attr.attribute M3e.Cem.Html.Theme.variant (M3e.Value.toString v_)


{-| The motion scheme. (default: `"standard"`) -}
motion :
    M3e.Value.Value { expressive : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | motion : M3e.Value.Supported } msg
motion v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Theme.motion (M3e.Value.toString v_)


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange f_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Theme.onChange (Json.Decode.succeed f_)