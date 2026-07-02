module M3e.Cem.Html.SearchBar exposing ( searchBar, clearable, clearLabel, onClear )

{-|
Bottom layer for `<m3e-search-bar>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs searchBar, clearable, clearLabel, onClear
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-search-bar>` element — a partial application of `Html.node`. -}
searchBar : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
searchBar =
    Html.node "m3e-search-bar"


{-| Whether the bar presents a button used to clear the search term. (default: `false`) -}
clearable : Bool -> Html.Attribute msg
clearable val_ =
    Html.Attributes.property "clearable" (Json.Encode.bool val_)


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`) -}
clearLabel : String -> Html.Attribute msg
clearLabel =
    Html.Attributes.attribute "clear-label"


{-| Listen for `clear` events. -}
onClear : Json.Decode.Decoder msg -> Html.Attribute msg
onClear =
    Html.Events.on "clear"