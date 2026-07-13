module M3e.Raw.InputChip exposing
    ( inputChip, disabled, disabledInteractive, removable, removeLabel, value
    , variant, onRemove, onClick
    )

{-| Bottom layer for `<m3e-input-chip>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs inputChip, disabled, disabledInteractive, removable, removeLabel, value
@docs variant, onRemove, onClick

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-input-chip>` element — a partial application of `Html.node`.
-}
inputChip : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
inputChip =
    Html.node "m3e-input-chip"


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    if val_ then
        Html.Attributes.attribute "disabled" ""

    else
        Html.Attributes.classList []


{-| Whether the element is disabled and interactive. (default: `false`)
-}
disabledInteractive : Bool -> Html.Attribute msg
disabledInteractive val_ =
    if val_ then
        Html.Attributes.attribute "disabled-interactive" ""

    else
        Html.Attributes.classList []


{-| Whether the chip is removable. (default: `false`)
-}
removable : Bool -> Html.Attribute msg
removable val_ =
    if val_ then
        Html.Attributes.attribute "removable" ""

    else
        Html.Attributes.classList []


{-| The accessible label given to the button used to remove the chip. (default: `"Remove"`)
-}
removeLabel : String -> Html.Attribute msg
removeLabel =
    Html.Attributes.attribute "remove-label"


{-| A string representing the value of the chip.
-}
value : String -> Html.Attribute msg
value =
    Html.Attributes.attribute "value"


{-| The appearance variant of the chip. (default: `"outlined"`)
-}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"


{-| Listen for `remove` events.
-}
onRemove : Json.Decode.Decoder msg -> Html.Attribute msg
onRemove =
    Html.Events.on "remove"


{-| Listen for `click` events.
-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick =
    Html.Events.on "click"
