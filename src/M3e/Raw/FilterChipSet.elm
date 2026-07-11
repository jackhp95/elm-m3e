module M3e.Raw.FilterChipSet exposing
    ( filterChipSet, disabled, hideSelectionIndicator, multi, name, vertical
    , onChange, onBeforeinput, onInput
    )

{-| Bottom layer for `<m3e-filter-chip-set>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs filterChipSet, disabled, hideSelectionIndicator, multi, name, vertical
@docs onChange, onBeforeinput, onInput

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-filter-chip-set>` element, with the library's fixed host attribute (role="group") stamped ahead of the caller's attributes.
-}
filterChipSet : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
filterChipSet attributes children =
    Html.node
        "m3e-filter-chip-set"
        (Html.Attributes.attribute "role" "group" :: attributes)
        children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    if val_ then
        Html.Attributes.attribute "disabled" ""

    else
        Html.Attributes.classList []


{-| Whether to hide the selection indicator. (default: `false`)
-}
hideSelectionIndicator : Bool -> Html.Attribute msg
hideSelectionIndicator val_ =
    if val_ then
        Html.Attributes.attribute "hide-selection-indicator" ""

    else
        Html.Attributes.classList []


{-| Whether multiple chips can be selected. (default: `false`)
-}
multi : Bool -> Html.Attribute msg
multi val_ =
    if val_ then
        Html.Attributes.attribute "multi" ""

    else
        Html.Attributes.classList []


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Html.Attribute msg
name =
    Html.Attributes.attribute "name"


{-| Whether the element is oriented vertically. (default: `false`)
-}
vertical : Bool -> Html.Attribute msg
vertical val_ =
    if val_ then
        Html.Attributes.attribute "vertical" ""

    else
        Html.Attributes.classList []


{-| Listen for `change` events.
-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange =
    Html.Events.on "change"


{-| Listen for `beforeinput` events.
-}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput =
    Html.Events.on "beforeinput"


{-| Listen for `input` events.
-}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput =
    Html.Events.on "input"
