module M3e.Raw.DrawerContainer exposing
    ( drawerContainer, end, endMode, endDivider, start, startMode
    , startDivider, onChange
    )

{-| Bottom layer for `<m3e-drawer-container>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs drawerContainer, end, endMode, endDivider, start, startMode
@docs startDivider, onChange

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-drawer-container>` element — a partial application of `Html.node`.
-}
drawerContainer : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
drawerContainer =
    Html.node "m3e-drawer-container"


{-| Whether the end drawer is open. (default: `false`)
-}
end : Bool -> Html.Attribute msg
end val_ =
    if val_ then
        Html.Attributes.attribute "end" ""

    else
        Html.Attributes.classList []


{-| The behavior mode of the end drawer. (default: `"side"`)
-}
endMode : String -> Html.Attribute msg
endMode =
    Html.Attributes.attribute "end-mode"


{-| Whether to show a divider between the end drawer and content for `side` mode. (default: `false`)
-}
endDivider : Bool -> Html.Attribute msg
endDivider val_ =
    if val_ then
        Html.Attributes.attribute "end-divider" ""

    else
        Html.Attributes.classList []


{-| Whether the start drawer is open. (default: `false`)
-}
start : Bool -> Html.Attribute msg
start val_ =
    if val_ then
        Html.Attributes.attribute "start" ""

    else
        Html.Attributes.classList []


{-| The behavior mode of the start drawer. (default: `"side"`)
-}
startMode : String -> Html.Attribute msg
startMode =
    Html.Attributes.attribute "start-mode"


{-| Whether to show a divider between the start drawer and content for `side` mode. (default: `false`)
-}
startDivider : Bool -> Html.Attribute msg
startDivider val_ =
    if val_ then
        Html.Attributes.attribute "start-divider" ""

    else
        Html.Attributes.classList []


{-| Listen for `change` events.
-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange =
    Html.Events.on "change"
