module M3e.Cem.Html.Collapsible exposing (collapsible, noAnimate, onClosed, onClosing, onOpened, onOpening, open, orientation)

{-| 
@docs collapsible, open, orientation, noAnimate, onOpening, onOpened, onClosing, onClosed
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-collapsible>` element — a partial application of `Html.node`. -}
collapsible : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
collapsible =
    Html.node "m3e-collapsible"


{-| Whether content is visible. (default: `false`) -}
open : Bool -> Html.Attribute msg
open val_ =
    Html.Attributes.property "open" (Json.Encode.bool val_)


{-| Orientation of collapsible content. (default: `"vertical"`) -}
orientation : String -> Html.Attribute msg
orientation =
    Html.Attributes.attribute "orientation"


{-| Whether to disable animation. (default: `false`) -}
noAnimate : Bool -> Html.Attribute msg
noAnimate val_ =
    Html.Attributes.property "noAnimate" (Json.Encode.bool val_)


{-| Listen for `opening` events. -}
onOpening : Json.Decode.Decoder msg -> Html.Attribute msg
onOpening =
    Html.Events.on "opening"


{-| Listen for `opened` events. -}
onOpened : Json.Decode.Decoder msg -> Html.Attribute msg
onOpened =
    Html.Events.on "opened"


{-| Listen for `closing` events. -}
onClosing : Json.Decode.Decoder msg -> Html.Attribute msg
onClosing =
    Html.Events.on "closing"


{-| Listen for `closed` events. -}
onClosed : Json.Decode.Decoder msg -> Html.Attribute msg
onClosed =
    Html.Events.on "closed"