module M3e.Cem.Option exposing
    ( option, disabled, disableHighlight, highlightMode, selected, term
    , value
    )

{-|
Middle layer for `<m3e-option>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Option` module for everyday use.

@docs option, disabled, disableHighlight, highlightMode, selected, term
@docs value
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.Option
import M3e.Value


{-| An option that can be selected.

**Component Info:**
- **Extends:** `LitElement`
-}
option :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disableHighlight : M3e.Value.Supported
    , highlightMode : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , term : M3e.Value.Supported
    , value : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
option attributes children =
    M3e.Cem.Html.Option.option
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Option.disabled


{-| Whether text highlighting is disabled. (default: `false`) -}
disableHighlight :
    Bool -> M3e.Cem.Attr.Attr { c | disableHighlight : M3e.Value.Supported } msg
disableHighlight =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Option.disableHighlight


{-| The mode in which to highlight a term. (default: `"contains"`) -}
highlightMode :
    M3e.Value.Value { contains : M3e.Value.Supported
    , endsWith : M3e.Value.Supported
    , startsWith : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | highlightMode : M3e.Value.Supported } msg
highlightMode v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Option.highlightMode
        (M3e.Value.toString v_)


{-| Whether the element is selected. (default: `false`) -}
selected : Bool -> M3e.Cem.Attr.Attr { c | selected : M3e.Value.Supported } msg
selected =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Option.selected


{-| The search term to highlight. (default: `""`) -}
term : String -> M3e.Cem.Attr.Attr { c | term : M3e.Value.Supported } msg
term =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Option.term


{-| A string representing the value of the option. -}
value : String -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Option.value