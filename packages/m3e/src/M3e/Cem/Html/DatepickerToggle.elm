module M3e.Cem.Html.DatepickerToggle exposing (datepickerToggle, for)

{-| 
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