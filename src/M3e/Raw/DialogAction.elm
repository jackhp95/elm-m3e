module M3e.Raw.DialogAction exposing (dialogAction, returnValue)

{-| Bottom layer for `<m3e-dialog-action>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs dialogAction, returnValue

-}

import Html
import Html.Attributes


{-| The raw `<m3e-dialog-action>` element — a partial application of `Html.node`.
-}
dialogAction : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
dialogAction =
    Html.node "m3e-dialog-action"


{-| The value to return from the dialog. (default: `""`)
-}
returnValue : String -> Html.Attribute msg
returnValue =
    Html.Attributes.attribute "return-value"
