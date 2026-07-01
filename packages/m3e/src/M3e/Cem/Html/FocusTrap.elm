module M3e.Cem.Html.FocusTrap exposing (disabled, focusTrap)

{-| 
@docs focusTrap, disabled
-}


import Html
import Html.Attributes
import Json.Encode


{-| The raw `<m3e-focus-trap>` element — a partial application of `Html.node`. -}
focusTrap : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
focusTrap =
    Html.node "m3e-focus-trap"


{-| Disables the focus trap. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)