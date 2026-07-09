module M3e.Cem.Html.ExpansionPanel exposing
    ( expansionPanel, disabled, hideToggle, open, toggleDirection, togglePosition
    , onOpening, onOpened, onClosing, onClosed
    )

{-|
Bottom layer for `<m3e-expansion-panel>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs expansionPanel, disabled, hideToggle, open, toggleDirection, togglePosition
@docs onOpening, onOpened, onClosing, onClosed
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-expansion-panel>` element — a partial application of `Html.node`. -}
expansionPanel :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
expansionPanel =
    Html.node "m3e-expansion-panel"


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    if val_ then
        Html.Attributes.attribute "disabled" ""
    
    else
        Html.Attributes.classList []


{-| Whether to hide the expansion toggle. (default: `false`) -}
hideToggle : Bool -> Html.Attribute msg
hideToggle val_ =
    if val_ then
        Html.Attributes.attribute "hide-toggle" ""
    
    else
        Html.Attributes.classList []


{-| Whether the panel is expanded. (default: `false`) -}
open : Bool -> Html.Attribute msg
open val_ =
    if val_ then
        Html.Attributes.attribute "open" ""
    
    else
        Html.Attributes.classList []


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