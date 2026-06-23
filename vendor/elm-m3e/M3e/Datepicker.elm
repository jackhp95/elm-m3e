module M3e.Datepicker exposing (StartView(..), Variant(..), clearLabel, clearable, component, confirmLabel, date, dismissLabel, label, maxDate, minDate, nextMonthLabel, nextMultiYearLabel, nextYearLabel, onBeforetoggle, onChange, onToggle, previousMonthLabel, previousMultiYearLabel, previousYearLabel, range, rangeEnd, rangeStart, startAt, startView, variant)

{-| 
Presents a date picker on a temporary surface.

## Component

@docs component

### Attributes

@docs Variant, variant, clearable, date, maxDate, minDate, range, rangeEnd, rangeStart, startAt, StartView, startView, previousMonthLabel, nextMonthLabel, previousYearLabel, nextYearLabel, previousMultiYearLabel, nextMultiYearLabel, clearLabel, confirmLabel, dismissLabel, label

### Events

@docs onChange, onBeforetoggle, onToggle
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| Presents a date picker on a temporary surface.

**Events:**
- `change`: Dispatched when the selected date changes.
- `beforetoggle`: Dispatched before the toggle state changes.
- `toggle`: Dispatched after the toggle state has changed.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-datepicker" attributes children


{-| Values for the `variant` attribute. -}
type Variant
    = Auto
    | Docked
    | Modal


{-| The appearance variant of the picker. (default: `"docked"`) -}
variant : Variant -> Html.Attribute msg
variant val_ =
    Html.Attributes.attribute "variant" (variantToString val_)


variantToString : Variant -> String
variantToString val_ =
    case val_ of
        Auto ->
            "auto"
    
        Docked ->
            "docked"
    
        Modal ->
            "modal"


{-| Whether the user can clear the selected date and close the picker. (default: `false`) -}
clearable : Bool -> Html.Attribute msg
clearable val_ =
    Html.Attributes.property "clearable" (Json.Encode.bool val_)


{-| The selected date. (default: `null`) -}
date : String -> Html.Attribute msg
date val_ =
    Html.Attributes.attribute "date" val_


{-| The maximum date that can be selected. (default: `null`) -}
maxDate : String -> Html.Attribute msg
maxDate val_ =
    Html.Attributes.attribute "max-date" val_


{-| The minimum date that can be selected. (default: `null`) -}
minDate : String -> Html.Attribute msg
minDate val_ =
    Html.Attributes.attribute "min-date" val_


{-| Whether a range of dates can be selected. (default: `false`) -}
range : Bool -> Html.Attribute msg
range val_ =
    Html.Attributes.property "range" (Json.Encode.bool val_)


{-| End of a date range. (default: `null`) -}
rangeEnd : String -> Html.Attribute msg
rangeEnd val_ =
    Html.Attributes.attribute "range-end" val_


{-| Start of a date range. (default: `null`) -}
rangeStart : String -> Html.Attribute msg
rangeStart val_ =
    Html.Attributes.attribute "range-start" val_


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`) -}
startAt : String -> Html.Attribute msg
startAt val_ =
    Html.Attributes.attribute "start-at" val_


{-| Values for the `start-view` attribute. -}
type StartView
    = Month
    | MultiYear
    | Year


{-| The initial view used to select a date. (default: `"month"`) -}
startView : StartView -> Html.Attribute msg
startView val_ =
    Html.Attributes.attribute "start-view" (startViewToString val_)


startViewToString : StartView -> String
startViewToString val_ =
    case val_ of
        Month ->
            "month"
    
        MultiYear ->
            "multi-year"
    
        Year ->
            "year"


{-| The accessible label given to the button used to move to the previous month. (default: `"Previous month"`) -}
previousMonthLabel : String -> Html.Attribute msg
previousMonthLabel val_ =
    Html.Attributes.attribute "previous-month-label" val_


{-| The accessible label given to the button used to move to the next month. (default: `"Next month"`) -}
nextMonthLabel : String -> Html.Attribute msg
nextMonthLabel val_ =
    Html.Attributes.attribute "next-month-label" val_


{-| The accessible label given to the button used to move to the previous year. (default: `"Previous year"`) -}
previousYearLabel : String -> Html.Attribute msg
previousYearLabel val_ =
    Html.Attributes.attribute "previous-year-label" val_


{-| The accessible label given to the button used to move to the next year. (default: `"Next year"`) -}
nextYearLabel : String -> Html.Attribute msg
nextYearLabel val_ =
    Html.Attributes.attribute "next-year-label" val_


{-| The accessible label given to the button used to move to the previous 24 years. (default: `"Previous 24 years"`) -}
previousMultiYearLabel : String -> Html.Attribute msg
previousMultiYearLabel val_ =
    Html.Attributes.attribute "previous-multi-year-label" val_


{-| The accessible label given to the button used to move to the next 24 years. (default: `"Next 24 years"`) -}
nextMultiYearLabel : String -> Html.Attribute msg
nextMultiYearLabel val_ =
    Html.Attributes.attribute "next-multi-year-label" val_


{-| The label given to the button used clear the selected date and close the picker. (default: `"Clear"`) -}
clearLabel : String -> Html.Attribute msg
clearLabel val_ =
    Html.Attributes.attribute "clear-label" val_


{-| The label given to the button used apply the selected date and close the picker. (default: `"OK"`) -}
confirmLabel : String -> Html.Attribute msg
confirmLabel val_ =
    Html.Attributes.attribute "confirm-label" val_


{-| The label given to the button used discard the selected date and close the picker. (default: `"Cancel"`) -}
dismissLabel : String -> Html.Attribute msg
dismissLabel val_ =
    Html.Attributes.attribute "dismiss-label" val_


{-| The label given to the the picker. (default: `"Select date"`) -}
label : String -> Html.Attribute msg
label val_ =
    Html.Attributes.attribute "label" val_


{-| Dispatched when the selected date changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged M3e.Common.targetValue)`.
-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Dispatched before the toggle state changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onBeforetoggle : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforetoggle decoder =
    Html.Events.on "beforetoggle" decoder


{-| Dispatched after the toggle state has changed.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onToggle : Json.Decode.Decoder msg -> Html.Attribute msg
onToggle decoder =
    Html.Events.on "toggle" decoder