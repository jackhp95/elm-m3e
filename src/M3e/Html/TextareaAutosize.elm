module M3e.Html.TextareaAutosize exposing (textareaAutosize, disabled, for, maxRows, minRows)

{-| Middle layer for `<m3e-textarea-autosize>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.TextareaAutosize` module for everyday use.

@docs textareaAutosize, disabled, for, maxRows, minRows

-}

import Html
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.TextareaAutosize
import M3e.Token


{-| A non-visual element used to automatically resize a `textarea` to fit its content.

**Component Info:**

  - **Extends:** `LitElement`

-}
textareaAutosize :
    List
        (M3e.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , for : M3e.Token.Supported
            , maxRows : M3e.Token.Supported
            , minRows : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
textareaAutosize attributes children =
    M3e.Raw.TextareaAutosize.textareaAutosize
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| Whether auto-sizing is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Attr.Internal.attribute M3e.Raw.TextareaAutosize.disabled


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> M3e.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    M3e.Html.Attr.Internal.attribute M3e.Raw.TextareaAutosize.for


{-| The maximum amount of rows in the `textarea`. (default: `0`)
-}
maxRows : Float -> M3e.Html.Attr.Attr { c | maxRows : M3e.Token.Supported } msg
maxRows =
    M3e.Html.Attr.Internal.attribute M3e.Raw.TextareaAutosize.maxRows


{-| The minimum amount of rows in the `textarea`. (default: `0`)
-}
minRows : Float -> M3e.Html.Attr.Attr { c | minRows : M3e.Token.Supported } msg
minRows =
    M3e.Html.Attr.Internal.attribute M3e.Raw.TextareaAutosize.minRows
