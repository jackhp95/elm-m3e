module M3e.Cem.TextareaAutosize exposing (disabled, for, maxRows, minRows, textareaAutosize)

{-| 
@docs textareaAutosize, disabled, for, maxRows, minRows
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.TextareaAutosize
import M3e.Value


{-| A non-visual element used to automatically resize a `textarea` to fit its content. -}
textareaAutosize :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , for : M3e.Value.Supported
    , maxRows : M3e.Value.Supported
    , minRows : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
textareaAutosize attributes children =
    M3e.Cem.Html.TextareaAutosize.textareaAutosize
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether auto-sizing is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.TextareaAutosize.disabled


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Attr.attribute M3e.Cem.Html.TextareaAutosize.for


{-| The maximum amount of rows in the `textarea`. (default: `0`) -}
maxRows : Float -> M3e.Cem.Attr.Attr { c | maxRows : M3e.Value.Supported } msg
maxRows =
    M3e.Cem.Attr.attribute M3e.Cem.Html.TextareaAutosize.maxRows


{-| The minimum amount of rows in the `textarea`. (default: `0`) -}
minRows : Float -> M3e.Cem.Attr.Attr { c | minRows : M3e.Value.Supported } msg
minRows =
    M3e.Cem.Attr.attribute M3e.Cem.Html.TextareaAutosize.minRows