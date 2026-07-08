module M3e.Cem.Html.ExpansionHeader exposing
    ( expansionHeader, hideToggle, toggleDirection, togglePosition, disabled, onClick
    )

{-|
Bottom layer for `<m3e-expansion-header>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs expansionHeader, hideToggle, toggleDirection, togglePosition, disabled, onClick
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-expansion-header>` element — a partial application of `Html.node`. -}
expansionHeader :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
expansionHeader =
    Html.node "m3e-expansion-header"


{-| Whether to hide the expansion toggle. (default: `false`) -}
hideToggle : Bool -> Html.Attribute msg
hideToggle val_ =
    if val_ then
        Html.Attributes.attribute "hide-toggle" ""
    
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


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    if val_ then
        Html.Attributes.attribute "disabled" ""
    
    else
        Html.Attributes.classList []


{-| Listen for `click` events. -}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick =
    Html.Events.on "click"