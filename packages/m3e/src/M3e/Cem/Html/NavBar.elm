module M3e.Cem.Html.NavBar exposing (mode, navBar, onBeforeinput, onChange, onInput)

{-| 
@docs navBar, mode, onChange, onBeforeinput, onInput
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-nav-bar>` element — a partial application of `Html.node`. -}
navBar : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
navBar =
    Html.node "m3e-nav-bar"


{-| The mode in which items in the bar are presented. (default: `"compact"`) -}
mode : String -> Html.Attribute msg
mode =
    Html.Attributes.attribute "mode"


{-| Listen for `change` events. -}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange =
    Html.Events.on "change"


{-| Listen for `beforeinput` events. -}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput =
    Html.Events.on "beforeinput"


{-| Listen for `input` events. -}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput =
    Html.Events.on "input"