module M3e.Cem.Html.DatepickerToggle exposing ( datepickerToggle, for )

{-|
Bottom layer for `<m3e-datepicker-toggle>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs datepickerToggle, for
-}


import Html
import Html.Attributes


{-| The raw `<m3e-datepicker-toggle>` element — a partial application of `Html.node`. -}
datepickerToggle :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
datepickerToggle =
    Html.node "m3e-datepicker-toggle"


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> Html.Attribute msg
for =
    Html.Attributes.attribute "for"