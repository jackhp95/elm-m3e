module M3e.Cem.Html.MenuItemRadio exposing (checked, disabled, menuItemRadio, onClick)

{-| 
@docs menuItemRadio, disabled, checked, onClick
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-menu-item-radio>` element — a partial application of `Html.node`. -}
menuItemRadio :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
menuItemRadio =
    Html.node "m3e-menu-item-radio"


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether the element is checked. (default: `false`) -}
checked : Bool -> Html.Attribute msg
checked val_ =
    Html.Attributes.property "checked" (Json.Encode.bool val_)


{-| Listen for `click` events. -}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick =
    Html.Events.on "click"