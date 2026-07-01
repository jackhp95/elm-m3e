module M3e.Cem.Html.DialogTrigger exposing (dialogTrigger, for)

{-| 
@docs dialogTrigger, for
-}


import Html
import Html.Attributes


{-| The raw `<m3e-dialog-trigger>` element — a partial application of `Html.node`. -}
dialogTrigger :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
dialogTrigger =
    Html.node "m3e-dialog-trigger"


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> Html.Attribute msg
for =
    Html.Attributes.attribute "for"