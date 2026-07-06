module M3e.Cem.Datepicker exposing
    ( datepicker, variant, clearable, date, maxDate, minDate
    , range, rangeEnd, rangeStart, startAt, startView, previousMonthLabel, nextMonthLabel
    , previousYearLabel, nextYearLabel, previousMultiYearLabel, nextMultiYearLabel, clearLabel, confirmLabel, dismissLabel
    , label, onChange, onBeforetoggle, onToggle
    )

{-|
Middle layer for `<m3e-datepicker>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Datepicker` module for everyday use.

@docs datepicker, variant, clearable, date, maxDate, minDate
@docs range, rangeEnd, rangeStart, startAt, startView, previousMonthLabel
@docs nextMonthLabel, previousYearLabel, nextYearLabel, previousMultiYearLabel, nextMultiYearLabel, clearLabel
@docs confirmLabel, dismissLabel, label, onChange, onBeforetoggle, onToggle
-}


import Html
import Json.Decode
import Json.Encode
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.Datepicker
import M3e.Value


{-| Presents a date picker on a temporary surface.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `change`: Dispatched when the selected date changes.
- `beforetoggle`: Dispatched before the toggle state changes.
- `toggle`: Dispatched after the toggle state has changed.
-}
datepicker :
    List (M3e.Cem.Attr.Attr { variant : M3e.Value.Supported
    , clearable : M3e.Value.Supported
    , date : M3e.Value.Supported
    , maxDate : M3e.Value.Supported
    , minDate : M3e.Value.Supported
    , range : M3e.Value.Supported
    , rangeEnd : M3e.Value.Supported
    , rangeStart : M3e.Value.Supported
    , startAt : M3e.Value.Supported
    , startView : M3e.Value.Supported
    , previousMonthLabel : M3e.Value.Supported
    , nextMonthLabel : M3e.Value.Supported
    , previousYearLabel : M3e.Value.Supported
    , nextYearLabel : M3e.Value.Supported
    , previousMultiYearLabel : M3e.Value.Supported
    , nextMultiYearLabel : M3e.Value.Supported
    , clearLabel : M3e.Value.Supported
    , confirmLabel : M3e.Value.Supported
    , dismissLabel : M3e.Value.Supported
    , label : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onBeforetoggle : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
datepicker attributes children =
    M3e.Cem.Html.Datepicker.datepicker
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The appearance variant of the picker. (default: `"docked"`) -}
variant :
    M3e.Value.Value { auto : M3e.Value.Supported
    , docked : M3e.Value.Supported
    , modal : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Datepicker.variant
        (M3e.Value.toString v_)


{-| Whether the user can clear the selected date and close the picker. (default: `false`) -}
clearable :
    Bool -> M3e.Cem.Attr.Attr { c | clearable : M3e.Value.Supported } msg
clearable =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Datepicker.clearable


{-| The selected date. (default: `null`) -}
date : String -> M3e.Cem.Attr.Attr { c | date : M3e.Value.Supported } msg
date =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Datepicker.date


{-| The maximum date that can be selected. (default: `null`) -}
maxDate : String -> M3e.Cem.Attr.Attr { c | maxDate : M3e.Value.Supported } msg
maxDate =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Datepicker.maxDate


{-| The minimum date that can be selected. (default: `null`) -}
minDate : String -> M3e.Cem.Attr.Attr { c | minDate : M3e.Value.Supported } msg
minDate =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Datepicker.minDate


{-| Whether a range of dates can be selected. (default: `false`) -}
range : Bool -> M3e.Cem.Attr.Attr { c | range : M3e.Value.Supported } msg
range =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Datepicker.range


{-| End of a date range. (default: `null`) -}
rangeEnd :
    String -> M3e.Cem.Attr.Attr { c | rangeEnd : M3e.Value.Supported } msg
rangeEnd =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Datepicker.rangeEnd


{-| Start of a date range. (default: `null`) -}
rangeStart :
    String -> M3e.Cem.Attr.Attr { c | rangeStart : M3e.Value.Supported } msg
rangeStart =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Datepicker.rangeStart


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`) -}
startAt : String -> M3e.Cem.Attr.Attr { c | startAt : M3e.Value.Supported } msg
startAt =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Datepicker.startAt


{-| The initial view used to select a date. (default: `"month"`) -}
startView :
    M3e.Value.Value { month : M3e.Value.Supported
    , multiYear : M3e.Value.Supported
    , year : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | startView : M3e.Value.Supported } msg
startView v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Datepicker.startView
        (M3e.Value.toString v_)


{-| The accessible label given to the button used to move to the previous month. (default: `"Previous month"`) -}
previousMonthLabel :
    String
    -> M3e.Cem.Attr.Attr { c | previousMonthLabel : M3e.Value.Supported } msg
previousMonthLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Datepicker.previousMonthLabel


{-| The accessible label given to the button used to move to the next month. (default: `"Next month"`) -}
nextMonthLabel :
    String -> M3e.Cem.Attr.Attr { c | nextMonthLabel : M3e.Value.Supported } msg
nextMonthLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Datepicker.nextMonthLabel


{-| The accessible label given to the button used to move to the previous year. (default: `"Previous year"`) -}
previousYearLabel :
    String
    -> M3e.Cem.Attr.Attr { c | previousYearLabel : M3e.Value.Supported } msg
previousYearLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Datepicker.previousYearLabel


{-| The accessible label given to the button used to move to the next year. (default: `"Next year"`) -}
nextYearLabel :
    String -> M3e.Cem.Attr.Attr { c | nextYearLabel : M3e.Value.Supported } msg
nextYearLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Datepicker.nextYearLabel


{-| The accessible label given to the button used to move to the previous 24 years. (default: `"Previous 24 years"`) -}
previousMultiYearLabel :
    String
    -> M3e.Cem.Attr.Attr { c
        | previousMultiYearLabel : M3e.Value.Supported
    } msg
previousMultiYearLabel =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Datepicker.previousMultiYearLabel


{-| The accessible label given to the button used to move to the next 24 years. (default: `"Next 24 years"`) -}
nextMultiYearLabel :
    String
    -> M3e.Cem.Attr.Attr { c | nextMultiYearLabel : M3e.Value.Supported } msg
nextMultiYearLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Datepicker.nextMultiYearLabel


{-| The label given to the button used clear the selected date and close the picker. (default: `"Clear"`) -}
clearLabel :
    String -> M3e.Cem.Attr.Attr { c | clearLabel : M3e.Value.Supported } msg
clearLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Datepicker.clearLabel


{-| The label given to the button used apply the selected date and close the picker. (default: `"OK"`) -}
confirmLabel :
    String -> M3e.Cem.Attr.Attr { c | confirmLabel : M3e.Value.Supported } msg
confirmLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Datepicker.confirmLabel


{-| The label given to the button used discard the selected date and close the picker. (default: `"Cancel"`) -}
dismissLabel :
    String -> M3e.Cem.Attr.Attr { c | dismissLabel : M3e.Value.Supported } msg
dismissLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Datepicker.dismissLabel


{-| The label given to the the picker. (default: `"Select date"`) -}
label : String -> M3e.Cem.Attr.Attr { c | label : M3e.Value.Supported } msg
label =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Datepicker.label


{-| Listen for `change` events. -}
onChange :
    (String -> msg)
    -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Datepicker.onChange
        (Json.Decode.map
             f_
             (Json.Decode.andThen
                  (\v_ ->
                       case
                           Json.Decode.decodeString
                               Json.Decode.string
                               (Json.Encode.encode 0 v_)
                       of
                           Ok s_ ->
                               Json.Decode.succeed s_
                       
                           Err e_ ->
                               Json.Decode.fail "expected a Date value"
                  )
                  (Json.Decode.at [ "target", "date" ] Json.Decode.value)
             )
        )


{-| Listen for `beforetoggle` events. -}
onBeforetoggle :
    msg -> M3e.Cem.Attr.Attr { c | onBeforetoggle : M3e.Value.Supported } msg
onBeforetoggle f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Datepicker.onBeforetoggle
        (Json.Decode.succeed f_)


{-| Listen for `toggle` events. -}
onToggle : msg -> M3e.Cem.Attr.Attr { c | onToggle : M3e.Value.Supported } msg
onToggle f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Datepicker.onToggle
        (Json.Decode.succeed f_)