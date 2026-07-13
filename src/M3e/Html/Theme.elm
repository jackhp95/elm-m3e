module M3e.Html.Theme exposing
    ( theme, color, contrast, density, scheme, strongFocus
    , variant, motion, onChange
    )

{-| Middle layer for `<m3e-theme>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Theme` module for everyday use.

@docs theme, color, contrast, density, scheme, strongFocus
@docs variant, motion, onChange

-}

import Html
import Json.Decode
import M3e.Raw.Theme
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| A non-visual element responsible for application-level theming.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `change`: Dispatched when the theme changes.

-}
theme :
    List
        (Markup.Html.Attr.Attr
            { color : M3e.Token.Supported
            , contrast : M3e.Token.Supported
            , density : M3e.Token.Supported
            , scheme : M3e.Token.Supported
            , strongFocus : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , motion : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
theme attributes children =
    M3e.Raw.Theme.theme
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| The hex color from which to derive dynamic color palettes. (default: `"#6750A4"`)
-}
color : String -> Markup.Html.Attr.Attr { c | color : M3e.Token.Supported } msg
color =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Theme.color


{-| The contrast level of the theme. (default: `"standard"`)
-}
contrast :
    M3e.Token.Value
        { high : M3e.Token.Supported
        , medium : M3e.Token.Supported
        , standard : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | contrast : M3e.Token.Supported } msg
contrast v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Theme.contrast
        (M3e.Token.toString v_)


{-| The density scale (0, -1, -2). (default: `0`)
-}
density : Float -> Markup.Html.Attr.Attr { c | density : M3e.Token.Supported } msg
density =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Theme.density


{-| The color scheme of the theme. (default: `"auto"`)
-}
scheme :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , dark : M3e.Token.Supported
        , light : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | scheme : M3e.Token.Supported } msg
scheme v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Theme.scheme
        (M3e.Token.toString v_)


{-| Whether to enable strong focus indicators. (default: `false`)
-}
strongFocus : Bool -> Markup.Html.Attr.Attr { c | strongFocus : M3e.Token.Supported } msg
strongFocus =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Theme.strongFocus


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
variant v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Theme.variant
        (M3e.Token.toString v_)


{-| The motion scheme. (default: `"standard"`)
-}
motion :
    M3e.Token.Value
        { expressive : M3e.Token.Supported
        , standard : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | motion : M3e.Token.Supported } msg
motion v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Theme.motion
        (M3e.Token.toString v_)


{-| Listen for `change` events.
-}
onChange : msg -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Theme.onChange
        (Json.Decode.succeed f_)
