module M3e.Cem.Html.ExpansionHeader exposing (disabled, expansionHeader, hideToggle, onClick, toggleDirection, togglePosition)

{-| 
@docs expansionHeader, hideToggle, toggleDirection, togglePosition, disabled, onClick
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-expansion-header>` element — a partial application of `Html.node`. -}
expansionHeader :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
expansionHeader =
    Html.node "m3e-expansion-header"


{-| Whether to hide the expansion toggle. (default: `false`) -}
hideToggle : Bool -> Html.Attribute msg
hideToggle val_ =
    Html.Attributes.property "hideToggle" (Json.Encode.bool val_)


{-| The direction of the expansion toggle. (default: `"vertical"`) -}
toggleDirection : String -> Html.Attribute msg
toggleDirection =
    Html.Attributes.attribute "toggle-direction"


{-| The position of the expansion toggle. (default: `"after"`) -}
togglePosition : String -> Html.Attribute msg
togglePosition =
    Html.Attributes.attribute "toggle-position"


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Listen for `click` events. -}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick =
    Html.Events.on "click"