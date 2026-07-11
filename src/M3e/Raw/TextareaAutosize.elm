module M3e.Raw.TextareaAutosize exposing (textareaAutosize, disabled, for, maxRows, minRows)

{-| Bottom layer for `<m3e-textarea-autosize>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs textareaAutosize, disabled, for, maxRows, minRows

-}

import Html
import Html.Attributes


{-| The raw `<m3e-textarea-autosize>` element — a partial application of `Html.node`.
-}
textareaAutosize : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
textareaAutosize =
    Html.node "m3e-textarea-autosize"


{-| Whether auto-sizing is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    if val_ then
        Html.Attributes.attribute "disabled" ""

    else
        Html.Attributes.classList []


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Html.Attribute msg
for =
    Html.Attributes.attribute "for"


{-| The maximum amount of rows in the `textarea`. (default: `0`)
-}
maxRows : Float -> Html.Attribute msg
maxRows val_ =
    Html.Attributes.attribute "max-rows" (String.fromFloat val_)


{-| The minimum amount of rows in the `textarea`. (default: `0`)
-}
minRows : Float -> Html.Attribute msg
minRows val_ =
    Html.Attributes.attribute "min-rows" (String.fromFloat val_)
