module M3e.Html.TextHighlight exposing (textHighlight, caseSensitive, disabled, mode, term, onHighlight)

{-| Middle layer for `<m3e-text-highlight>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.TextHighlight` module for everyday use.

@docs textHighlight, caseSensitive, disabled, mode, term, onHighlight

-}

import Html
import Json.Decode
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.TextHighlight
import M3e.Token


{-| Highlights text which matches a given search term.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `highlight`: Dispatched when content is highlighted.

-}
textHighlight :
    List
        (M3e.Html.Attr.Attr
            { caseSensitive : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , mode : M3e.Token.Supported
            , term : M3e.Token.Supported
            , onHighlight : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
textHighlight attributes children =
    M3e.Raw.TextHighlight.textHighlight
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| Whether matching is case sensitive. (default: `false`)
-}
caseSensitive : Bool -> M3e.Html.Attr.Attr { c | caseSensitive : M3e.Token.Supported } msg
caseSensitive =
    M3e.Html.Attr.Internal.attribute M3e.Raw.TextHighlight.caseSensitive


{-| A value indicating whether text highlighting is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Attr.Internal.attribute M3e.Raw.TextHighlight.disabled


{-| The mode in which to highlight text. (default: `"contains"`)
-}
mode :
    M3e.Token.Value
        { contains : M3e.Token.Supported
        , endsWith : M3e.Token.Supported
        , startsWith : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
mode v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.TextHighlight.mode
        (M3e.Token.toString v_)


{-| The term to highlight. (default: `""`)
-}
term : String -> M3e.Html.Attr.Attr { c | term : M3e.Token.Supported } msg
term =
    M3e.Html.Attr.Internal.attribute M3e.Raw.TextHighlight.term


{-| Listen for `highlight` events.
-}
onHighlight : msg -> M3e.Html.Attr.Attr { c | onHighlight : M3e.Token.Supported } msg
onHighlight f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.TextHighlight.onHighlight
        (Json.Decode.succeed f_)
