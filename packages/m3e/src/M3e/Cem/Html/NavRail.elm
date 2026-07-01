module M3e.Cem.Html.NavRail exposing (mode, navRail, onBeforeinput, onChange, onInput)

{-| 
@docs navRail, mode, onBeforeinput, onInput, onChange
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-nav-rail>` element — a partial application of `Html.node`. -}
navRail : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
navRail =
    Html.node "m3e-nav-rail"


{-| The mode in which items in the rail are presented. (default: `"compact"`) -}
mode : String -> Html.Attribute msg
mode =
    Html.Attributes.attribute "mode"


{-| Listen for `beforeinput` events. -}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput =
    Html.Events.on "beforeinput"


{-| Listen for `input` events. -}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput =
    Html.Events.on "input"


{-| Listen for `change` events. -}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange =
    Html.Events.on "change"