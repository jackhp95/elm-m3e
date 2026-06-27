module Cem.M3e.DialogAction exposing
    ( component
    , returnValue
    )

{-| An element, nested within a clickable element, used to close a parenting dialog.


## Component

@docs component


### Attributes

@docs returnValue

-}

import Html
import Html.Attributes


{-| An element, nested within a clickable element, used to close a parenting dialog.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-dialog-action" attributes children


{-| The value to return from the dialog. (default: `""`)
-}
returnValue : String -> Html.Attribute msg
returnValue val_ =
    Html.Attributes.attribute "return-value" val_
