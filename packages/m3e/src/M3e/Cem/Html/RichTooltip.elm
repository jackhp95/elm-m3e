module M3e.Cem.Html.RichTooltip exposing (disabled, for, hideDelay, onBeforetoggle, onToggle, position, richTooltip, showDelay, touchGestures)

{-| 
@docs richTooltip, disabled, for, hideDelay, position, showDelay, touchGestures, onBeforetoggle, onToggle
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-rich-tooltip>` element — a partial application of `Html.node`. -}
richTooltip : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
richTooltip =
    Html.node "m3e-rich-tooltip"


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> Html.Attribute msg
for =
    Html.Attributes.attribute "for"


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`) -}
hideDelay : Float -> Html.Attribute msg
hideDelay val_ =
    Html.Attributes.property "hideDelay" (Json.Encode.float val_)


{-| The position of the tooltip. (default: `"below-after"`) -}
position : String -> Html.Attribute msg
position =
    Html.Attributes.attribute "position"


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`) -}
showDelay : Float -> Html.Attribute msg
showDelay val_ =
    Html.Attributes.property "showDelay" (Json.Encode.float val_)


{-| The mode in which to handle touch gestures. (default: `"auto"`) -}
touchGestures : String -> Html.Attribute msg
touchGestures =
    Html.Attributes.attribute "touch-gestures"


{-| Listen for `beforetoggle` events. -}
onBeforetoggle : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforetoggle =
    Html.Events.on "beforetoggle"


{-| Listen for `toggle` events. -}
onToggle : Json.Decode.Decoder msg -> Html.Attribute msg
onToggle =
    Html.Events.on "toggle"