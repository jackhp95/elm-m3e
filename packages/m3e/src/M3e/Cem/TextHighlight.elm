module M3e.Cem.TextHighlight exposing
    ( textHighlight, caseSensitive, disabled, mode, term, onHighlight
    )

{-|
Middle layer for `<m3e-text-highlight>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.TextHighlight` module for everyday use.

@docs textHighlight, caseSensitive, disabled, mode, term, onHighlight
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.TextHighlight
import M3e.Value


{-| Highlights text which matches a given search term.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `highlight`: Dispatched when content is highlighted.
-}
textHighlight :
    List (M3e.Cem.Attr.Attr { caseSensitive : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , mode : M3e.Value.Supported
    , term : M3e.Value.Supported
    , onHighlight : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
textHighlight attributes children =
    M3e.Cem.Html.TextHighlight.textHighlight
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether matching is case sensitive. (default: `false`) -}
caseSensitive :
    Bool -> M3e.Cem.Attr.Attr { c | caseSensitive : M3e.Value.Supported } msg
caseSensitive =
    M3e.Cem.Attr.attribute M3e.Cem.Html.TextHighlight.caseSensitive


{-| A value indicating whether text highlighting is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.TextHighlight.disabled


{-| The mode in which to highlight text. (default: `"contains"`) -}
mode :
    M3e.Value.Value { contains : M3e.Value.Supported
    , endsWith : M3e.Value.Supported
    , startsWith : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | mode : M3e.Value.Supported } msg
mode v_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.TextHighlight.mode
        (M3e.Value.toString v_)


{-| The term to highlight. (default: `""`) -}
term : String -> M3e.Cem.Attr.Attr { c | term : M3e.Value.Supported } msg
term =
    M3e.Cem.Attr.attribute M3e.Cem.Html.TextHighlight.term


{-| Listen for `highlight` events. -}
onHighlight :
    msg -> M3e.Cem.Attr.Attr { c | onHighlight : M3e.Value.Supported } msg
onHighlight f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.TextHighlight.onHighlight
        (Json.Decode.succeed f_)