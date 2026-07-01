module M3e.Cem.Html.FabMenu exposing (fabMenu, onBeforetoggle, onToggle, variant)

{-| 
@docs fabMenu, variant, onBeforetoggle, onToggle
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-fab-menu>` element — a partial application of `Html.node`. -}
fabMenu : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
fabMenu =
    Html.node "m3e-fab-menu"


{-| The appearance variant of the menu. (default: `"primary"`) -}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"


{-| Listen for `beforetoggle` events. -}
onBeforetoggle : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforetoggle =
    Html.Events.on "beforetoggle"


{-| Listen for `toggle` events. -}
onToggle : Json.Decode.Decoder msg -> Html.Attribute msg
onToggle =
    Html.Events.on "toggle"