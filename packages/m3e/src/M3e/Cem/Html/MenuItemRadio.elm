module M3e.Cem.Html.MenuItemRadio exposing ( menuItemRadio, disabled, checked, onClick )

{-|
Bottom layer for `<m3e-menu-item-radio>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs menuItemRadio, disabled, checked, onClick
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-menu-item-radio>` element — a partial application of `Html.node`. -}
menuItemRadio :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
menuItemRadio =
    Html.node "m3e-menu-item-radio"


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    if val_ then
        Html.Attributes.attribute "disabled" ""
    
    else
        Html.Attributes.classList []


{-| Whether the element is checked. (default: `false`) -}
checked : Bool -> Html.Attribute msg
checked val_ =
    if val_ then
        Html.Attributes.attribute "checked" ""
    
    else
        Html.Attributes.classList []


{-| Listen for `click` events. -}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick =
    Html.Events.on "click"