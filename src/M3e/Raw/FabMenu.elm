module M3e.Raw.FabMenu exposing (fabMenu, variant, onBeforetoggle, onToggle)

{-| Bottom layer for `<m3e-fab-menu>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs fabMenu, variant, onBeforetoggle, onToggle

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-fab-menu>` element — a partial application of `Html.node`.
-}
fabMenu : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
fabMenu =
    Html.node "m3e-fab-menu"


{-| The appearance variant of the menu. (default: `"primary"`)
-}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"


{-| Listen for `beforetoggle` events.
-}
onBeforetoggle : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforetoggle =
    Html.Events.on "beforetoggle"


{-| Listen for `toggle` events.
-}
onToggle : Json.Decode.Decoder msg -> Html.Attribute msg
onToggle =
    Html.Events.on "toggle"
