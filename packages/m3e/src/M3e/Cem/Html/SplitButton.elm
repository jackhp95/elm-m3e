module M3e.Cem.Html.SplitButton exposing (size, splitButton, variant)

{-| 
@docs splitButton, variant, size
-}


import Html
import Html.Attributes


{-| The raw `<m3e-split-button>` element — a partial application of `Html.node`. -}
splitButton : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
splitButton =
    Html.node "m3e-split-button"


{-| The appearance variant of the button. (default: `"filled"`) -}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"


{-| The size of the button. (default: `"small"`) -}
size : String -> Html.Attribute msg
size =
    Html.Attributes.attribute "size"