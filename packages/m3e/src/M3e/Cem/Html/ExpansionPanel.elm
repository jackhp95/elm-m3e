module M3e.Cem.Html.ExpansionPanel exposing (disabled, expansionPanel, hideToggle, onClosed, onClosing, onOpened, onOpening, open, toggleDirection, togglePosition)

{-| 
@docs expansionPanel, disabled, hideToggle, open, toggleDirection, togglePosition, onOpening, onOpened, onClosing, onClosed
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-expansion-panel>` element — a partial application of `Html.node`. -}
expansionPanel :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
expansionPanel =
    Html.node "m3e-expansion-panel"


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether to hide the expansion toggle. (default: `false`) -}
hideToggle : Bool -> Html.Attribute msg
hideToggle val_ =
    Html.Attributes.property "hideToggle" (Json.Encode.bool val_)


{-| Whether the panel is expanded. (default: `false`) -}
open : Bool -> Html.Attribute msg
open val_ =
    Html.Attributes.property "open" (Json.Encode.bool val_)


{-| The direction of the expansion toggle. (default: `"vertical"`) -}
toggleDirection : String -> Html.Attribute msg
toggleDirection =
    Html.Attributes.attribute "toggle-direction"


{-| The position of the expansion toggle. (default: `"after"`) -}
togglePosition : String -> Html.Attribute msg
togglePosition =
    Html.Attributes.attribute "toggle-position"


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