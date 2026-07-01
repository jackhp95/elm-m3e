module M3e.Cem.Html.MenuItemElementBase exposing (disabled, menuItemElementBase, onClick)

{-| 
@docs menuItemElementBase, disabled, onClick
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<div>` element — a partial application of `Html.node`. -}
menuItemElementBase :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
menuItemElementBase =
    Html.node "div"


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Listen for `click` events. -}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick =
    Html.Events.on "click"