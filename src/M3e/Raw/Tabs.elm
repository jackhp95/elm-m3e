module M3e.Raw.Tabs exposing
    ( tabs, disablePagination, headerPosition, nextPageLabel, previousPageLabel, stretch
    , variant, onChange, onBeforeinput, onInput
    )

{-| Bottom layer for `<m3e-tabs>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs tabs, disablePagination, headerPosition, nextPageLabel, previousPageLabel, stretch
@docs variant, onChange, onBeforeinput, onInput

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-tabs>` element — a partial application of `Html.node`.
-}
tabs : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
tabs =
    Html.node "m3e-tabs"


{-| Whether scroll buttons are disabled.
-}
disablePagination : String -> Html.Attribute msg
disablePagination =
    Html.Attributes.attribute "disable-pagination"


{-| The position of the tab headers. (default: `"before"`)
-}
headerPosition : String -> Html.Attribute msg
headerPosition =
    Html.Attributes.attribute "header-position"


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`)
-}
nextPageLabel : String -> Html.Attribute msg
nextPageLabel =
    Html.Attributes.attribute "next-page-label"


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`)
-}
previousPageLabel : String -> Html.Attribute msg
previousPageLabel =
    Html.Attributes.attribute "previous-page-label"


{-| Whether tabs are stretched to fill the header. (default: `false`)
-}
stretch : Bool -> Html.Attribute msg
stretch val_ =
    if val_ then
        Html.Attributes.attribute "stretch" ""

    else
        Html.Attributes.classList []


{-| The appearance variant of the tabs. (default: `"secondary"`)
-}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"


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
