module M3e.Raw.TocItem exposing (tocItem, disabled, selected, onClick)

{-| Bottom layer for `<m3e-toc-item>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs tocItem, disabled, selected, onClick

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-toc-item>` element — a partial application of `Html.node`.
-}
tocItem : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
tocItem =
    Html.node "m3e-toc-item"


{-| A value indicating whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    if val_ then
        Html.Attributes.attribute "disabled" ""

    else
        Html.Attributes.classList []


{-| Whether the element is selected. (default: `false`)
-}
selected : Bool -> Html.Attribute msg
selected val_ =
    if val_ then
        Html.Attributes.attribute "selected" ""

    else
        Html.Attributes.classList []


{-| Listen for `click` events.
-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick =
    Html.Events.on "click"
