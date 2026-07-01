module M3e.Cem.Html.ActionList exposing (actionList, variant)

{-| 
@docs actionList, variant
-}


import Html
import Html.Attributes


{-| The raw `<m3e-action-list>` element — a partial application of `Html.node`. -}
actionList : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
actionList =
    Html.node "m3e-action-list"


{-| The appearance variant of the list. (default: `"standard"`) -}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"