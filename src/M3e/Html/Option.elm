module M3e.Html.Option exposing
    ( option, disabled, disableHighlight, highlightMode, selected, term
    , value
    )

{-| Middle layer for `<m3e-option>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Option` module for everyday use.

@docs option, disabled, disableHighlight, highlightMode, selected, term
@docs value

-}

import Html
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.Option
import M3e.Token


{-| An option that can be selected.

**Component Info:**

  - **Extends:** `LitElement`

-}
option :
    List
        (M3e.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , disableHighlight : M3e.Token.Supported
            , highlightMode : M3e.Token.Supported
            , selected : M3e.Token.Supported
            , term : M3e.Token.Supported
            , value : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
option attributes children =
    M3e.Raw.Option.option
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Option.disabled


{-| Whether text highlighting is disabled. (default: `false`)
-}
disableHighlight :
    Bool
    -> M3e.Html.Attr.Attr { c | disableHighlight : M3e.Token.Supported } msg
disableHighlight =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Option.disableHighlight


{-| The mode in which to highlight a term. (default: `"contains"`)
-}
highlightMode :
    M3e.Token.Value
        { contains : M3e.Token.Supported
        , endsWith : M3e.Token.Supported
        , startsWith : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | highlightMode : M3e.Token.Supported } msg
highlightMode v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Option.highlightMode
        (M3e.Token.toString v_)


{-| Whether the element is selected. (default: `false`)
-}
selected : Bool -> M3e.Html.Attr.Attr { c | selected : M3e.Token.Supported } msg
selected =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Option.selected


{-| The search term to highlight. (default: `""`)
-}
term : String -> M3e.Html.Attr.Attr { c | term : M3e.Token.Supported } msg
term =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Option.term


{-| A string representing the value of the option.
-}
value : String -> M3e.Html.Attr.Attr { c | value : M3e.Token.Supported } msg
value =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Option.value
