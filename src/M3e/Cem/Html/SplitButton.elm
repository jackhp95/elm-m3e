module M3e.Cem.Html.SplitButton exposing ( splitButton, variant, size )

{-|
Bottom layer for `<m3e-split-button>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

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