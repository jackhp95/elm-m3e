module M3e.Raw.Menu exposing
    ( menu, positionX, positionY, variant, submenu, onBeforetoggle
    , onToggle
    )

{-| Bottom layer for `<m3e-menu>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs menu, positionX, positionY, variant, submenu, onBeforetoggle
@docs onToggle

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-menu>` element — a partial application of `Html.node`.
-}
menu : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
menu =
    Html.node "m3e-menu"


{-| The position of the menu, on the x-axis. (default: `"after"`)
-}
positionX : String -> Html.Attribute msg
positionX =
    Html.Attributes.attribute "position-x"


{-| The position of the menu, on the y-axis. (default: `"below"`)
-}
positionY : String -> Html.Attribute msg
positionY =
    Html.Attributes.attribute "position-y"


{-| The appearance variant of the menu. (default: `"standard"`)
-}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"


{-| A value indicating whether the menu is a submenu. (default: `false`)
-}
submenu : Bool -> Html.Attribute msg
submenu val_ =
    if val_ then
        Html.Attributes.attribute "submenu" ""

    else
        Html.Attributes.classList []


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
