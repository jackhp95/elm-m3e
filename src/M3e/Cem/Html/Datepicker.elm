module M3e.Cem.Html.Datepicker exposing
    ( datepicker, variant, clearable, date, maxDate, minDate
    , range, rangeEnd, rangeStart, startAt, startView, previousMonthLabel, nextMonthLabel
    , previousYearLabel, nextYearLabel, previousMultiYearLabel, nextMultiYearLabel, clearLabel, confirmLabel, dismissLabel
    , label, onChange, onBeforetoggle, onToggle
    )

{-|
Bottom layer for `<m3e-datepicker>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs datepicker, variant, clearable, date, maxDate, minDate
@docs range, rangeEnd, rangeStart, startAt, startView, previousMonthLabel
@docs nextMonthLabel, previousYearLabel, nextYearLabel, previousMultiYearLabel, nextMultiYearLabel, clearLabel
@docs confirmLabel, dismissLabel, label, onChange, onBeforetoggle, onToggle
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-datepicker>` element — a partial application of `Html.node`. -}
datepicker : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
datepicker =
    Html.node "m3e-datepicker"


{-| The appearance variant of the picker. (default: `"docked"`) -}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"


{-| Whether the user can clear the selected date and close the picker. (default: `false`) -}
clearable : Bool -> Html.Attribute msg
clearable val_ =
    if val_ then
        Html.Attributes.attribute "clearable" ""
    
    else
        Html.Attributes.classList []


{-| The selected date. (default: `null`) -}
date : String -> Html.Attribute msg
date =
    Html.Attributes.attribute "date"


{-| The maximum date that can be selected. (default: `null`) -}
maxDate : String -> Html.Attribute msg
maxDate =
    Html.Attributes.attribute "max-date"


{-| The minimum date that can be selected. (default: `null`) -}
minDate : String -> Html.Attribute msg
minDate =
    Html.Attributes.attribute "min-date"


{-| Whether a range of dates can be selected. (default: `false`) -}
range : Bool -> Html.Attribute msg
range val_ =
    if val_ then
        Html.Attributes.attribute "range" ""
    
    else
        Html.Attributes.classList []


{-| End of a date range. (default: `null`) -}
rangeEnd : String -> Html.Attribute msg
rangeEnd =
    Html.Attributes.attribute "range-end"


{-| Start of a date range. (default: `null`) -}
rangeStart : String -> Html.Attribute msg
rangeStart =
    Html.Attributes.attribute "range-start"


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`) -}
startAt : String -> Html.Attribute msg
startAt =
    Html.Attributes.attribute "start-at"


{-| The initial view used to select a date. (default: `"month"`) -}
startView : String -> Html.Attribute msg
startView =
    Html.Attributes.attribute "start-view"


{-| The accessible label given to the button used to move to the previous month. (default: `"Previous month"`) -}
previousMonthLabel : String -> Html.Attribute msg
previousMonthLabel =
    Html.Attributes.attribute "previous-month-label"


{-| The accessible label given to the button used to move to the next month. (default: `"Next month"`) -}
nextMonthLabel : String -> Html.Attribute msg
nextMonthLabel =
    Html.Attributes.attribute "next-month-label"


{-| The accessible label given to the button used to move to the previous year. (default: `"Previous year"`) -}
previousYearLabel : String -> Html.Attribute msg
previousYearLabel =
    Html.Attributes.attribute "previous-year-label"


{-| The accessible label given to the button used to move to the next year. (default: `"Next year"`) -}
nextYearLabel : String -> Html.Attribute msg
nextYearLabel =
    Html.Attributes.attribute "next-year-label"


{-| The accessible label given to the button used to move to the previous 24 years. (default: `"Previous 24 years"`) -}
previousMultiYearLabel : String -> Html.Attribute msg
previousMultiYearLabel =
    Html.Attributes.attribute "previous-multi-year-label"


{-| The accessible label given to the button used to move to the next 24 years. (default: `"Next 24 years"`) -}
nextMultiYearLabel : String -> Html.Attribute msg
nextMultiYearLabel =
    Html.Attributes.attribute "next-multi-year-label"


{-| The label given to the button used clear the selected date and close the picker. (default: `"Clear"`) -}
clearLabel : String -> Html.Attribute msg
clearLabel =
    Html.Attributes.attribute "clear-label"


{-| The label given to the button used apply the selected date and close the picker. (default: `"OK"`) -}
confirmLabel : String -> Html.Attribute msg
confirmLabel =
    Html.Attributes.attribute "confirm-label"


{-| The label given to the button used discard the selected date and close the picker. (default: `"Cancel"`) -}
dismissLabel : String -> Html.Attribute msg
dismissLabel =
    Html.Attributes.attribute "dismiss-label"


{-| The label given to the the picker. (default: `"Select date"`) -}
label : String -> Html.Attribute msg
label =
    Html.Attributes.attribute "label"


{-| Listen for `change` events. -}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange =
    Html.Events.on "change"


{-| Listen for `beforetoggle` events. -}
onBeforetoggle : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforetoggle =
    Html.Events.on "beforetoggle"


{-| Listen for `toggle` events. -}
onToggle : Json.Decode.Decoder msg -> Html.Attribute msg
onToggle =
    Html.Events.on "toggle"