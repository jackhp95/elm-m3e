module M3e.Raw.SearchView exposing
    ( searchView, contained, mode, open, clearLabel, closeLabel
    , hideSearchIcon, onQuery, onClear, onBeforetoggle, onToggle
    )

{-| Bottom layer for `<m3e-search-view>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs searchView, contained, mode, open, clearLabel, closeLabel
@docs hideSearchIcon, onQuery, onClear, onBeforetoggle, onToggle

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-search-view>` element — a partial application of `Html.node`.
-}
searchView : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
searchView =
    Html.node "m3e-search-view"


{-| Whether the view features a persistent, filled search container. (default: `false`)
-}
contained : Bool -> Html.Attribute msg
contained val_ =
    if val_ then
        Html.Attributes.attribute "contained" ""

    else
        Html.Attributes.classList []


{-| The behavior mode of the view. (default: `"docked"`)
-}
mode : String -> Html.Attribute msg
mode =
    Html.Attributes.attribute "mode"


{-| Whether the view is expanded to show results. (default: `false`)
-}
open : Bool -> Html.Attribute msg
open val_ =
    if val_ then
        Html.Attributes.attribute "open" ""

    else
        Html.Attributes.classList []


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`)
-}
clearLabel : String -> Html.Attribute msg
clearLabel =
    Html.Attributes.attribute "clear-label"


{-| The accessible label given to the button used to collapse the view. (default: `"Close"`)
-}
closeLabel : String -> Html.Attribute msg
closeLabel =
    Html.Attributes.attribute "close-label"


{-| Whether to hide the search icon. (default: `false`)
-}
hideSearchIcon : Bool -> Html.Attribute msg
hideSearchIcon val_ =
    if val_ then
        Html.Attributes.attribute "hide-search-icon" ""

    else
        Html.Attributes.classList []


{-| Listen for `query` events.
-}
onQuery : Json.Decode.Decoder msg -> Html.Attribute msg
onQuery =
    Html.Events.on "query"


{-| Listen for `clear` events.
-}
onClear : Json.Decode.Decoder msg -> Html.Attribute msg
onClear =
    Html.Events.on "clear"


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
