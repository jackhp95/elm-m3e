module M3e.Cem.Html.TocItem exposing (disabled, onClick, selected, tocItem)

{-| 
@docs tocItem, disabled, selected, onClick
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-toc-item>` element — a partial application of `Html.node`. -}
tocItem : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
tocItem =
    Html.node "m3e-toc-item"


{-| A value indicating whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether the element is selected. (default: `false`) -}
selected : Bool -> Html.Attribute msg
selected val_ =
    Html.Attributes.property "selected" (Json.Encode.bool val_)


{-| Listen for `click` events. -}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick =
    Html.Events.on "click"