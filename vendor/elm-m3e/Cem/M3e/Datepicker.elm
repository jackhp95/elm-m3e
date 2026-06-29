module Cem.M3e.Datepicker exposing
    ( component, variant, clearable, date, maxDate, minDate
    , range, rangeEnd, rangeStart, startAt, startView, previousMonthLabel
    , nextMonthLabel, previousYearLabel, nextYearLabel, previousMultiYearLabel, nextMultiYearLabel, clearLabel
    , confirmLabel, dismissLabel, label, onChange, onBeforetoggle, onToggle
    )

{-| Presents a date picker on a temporary surface.

@docs component, variant, clearable, date, maxDate, minDate
@docs range, rangeEnd, rangeStart, startAt, startView, previousMonthLabel
@docs nextMonthLabel, previousYearLabel, nextYearLabel, previousMultiYearLabel, nextMultiYearLabel, clearLabel
@docs confirmLabel, dismissLabel, label, onChange, onBeforetoggle, onToggle

-}

import Cem.M3e.Common
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

**CSS Custom Properties:**

  - `--m3e-datepicker-container-padding-block`: Block‑axis padding of the date picker container.
  - `--m3e-datepicker-container-padding-inline`: Inline‑axis padding of the date picker container.
  - `--m3e-datepicker-container-color`: Background color of the standard container surface.
  - `--m3e-datepicker-container-elevation`: Elevation shadow applied to the container surface.
  - `--m3e-datepicker-modal-headline-color`: Color used for the modal headline text.
  - `--m3e-datepicker-modal-headline-font-size`: Font size used for the modal headline text.
  - `--m3e-datepicker-modal-headline-font-weight`: Font weight used for the modal headline text.
  - `--m3e-datepicker-modal-headline-line-height`: Line height used for the modal headline text.
  - `--m3e-datepicker-modal-headline-tracking`: Letter spacing used for the modal headline text.
  - `--m3e-datepicker-modal-supporting-text-color`: Color used for supporting text in modal mode.
  - `--m3e-datepicker-modal-supporting-text-font-size`: Font size used for supporting text in modal mode.
  - `--m3e-datepicker-modal-supporting-text-font-weight`: Font weight used for supporting text in modal mode.
  - `--m3e-datepicker-modal-supporting-text-line-height`: Line height used for supporting text in modal mode.
  - `--m3e-datepicker-modal-supporting-text-tracking`: Letter spacing used for supporting text in modal mode.
  - `--m3e-datepicker-actions-padding-inline`: Inline‑axis padding of the action row.
  - `--m3e-datepicker-docked-container-color`: Background color of the container in docked mode.
  - `--m3e-datepicker-docked-container-shape`: Corner radius of the container in docked mode.
  - `--m3e-datepicker-modal-container-color`: Background color of the container in modal mode.
  - `--m3e-datepicker-modal-container-shape`: Corner radius of the container in modal mode.
  - `--m3e-divider-thickness`: Thickness of divider elements within the picker.
  - `--m3e-divider-color`: Color of divider rules within the picker.
  - `--m3e-dialog-scrim-color`: Base color used for the modal scrim behind the picker.
  - `--m3e-dialog-scrim-opacity`: Opacity applied to the scrim color in modal mode.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-datepicker" attributes children


{-| The appearance variant of the picker. (default: `"docked"`)
-}
variant :
    Cem.M3e.Common.Value
        { auto : Cem.M3e.Common.Supported
        , docked : Cem.M3e.Common.Supported
        , modal : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
variant =
    Cem.M3e.Common.variant


{-| Whether the user can clear the selected date and close the picker. (default: `false`)
-}
clearable : Bool -> Html.Attribute msg
clearable val_ =
    Html.Attributes.property "clearable" (Json.Encode.bool val_)


{-| The selected date. (default: `null`)
-}
date : String -> Html.Attribute msg
date val_ =
    Html.Attributes.attribute "date" val_


{-| The maximum date that can be selected. (default: `null`)
-}
maxDate : String -> Html.Attribute msg
maxDate val_ =
    Html.Attributes.attribute "max-date" val_


{-| The minimum date that can be selected. (default: `null`)
-}
minDate : String -> Html.Attribute msg
minDate val_ =
    Html.Attributes.attribute "min-date" val_


{-| Whether a range of dates can be selected. (default: `false`)
-}
range : Bool -> Html.Attribute msg
range val_ =
    Html.Attributes.property "range" (Json.Encode.bool val_)


{-| End of a date range. (default: `null`)
-}
rangeEnd : String -> Html.Attribute msg
rangeEnd val_ =
    Html.Attributes.attribute "range-end" val_


{-| Start of a date range. (default: `null`)
-}
rangeStart : String -> Html.Attribute msg
rangeStart val_ =
    Html.Attributes.attribute "range-start" val_


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`)
-}
startAt : String -> Html.Attribute msg
startAt val_ =
    Html.Attributes.attribute "start-at" val_


{-| The initial view used to select a date. (default: `"month"`)
-}
startView :
    Cem.M3e.Common.Value
        { month : Cem.M3e.Common.Supported
        , multiYear : Cem.M3e.Common.Supported
        , year : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
startView =
    Cem.M3e.Common.startView


{-| The accessible label given to the button used to move to the previous month. (default: `"Previous month"`)
-}
previousMonthLabel : String -> Html.Attribute msg
previousMonthLabel val_ =
    Html.Attributes.attribute "previous-month-label" val_


{-| The accessible label given to the button used to move to the next month. (default: `"Next month"`)
-}
nextMonthLabel : String -> Html.Attribute msg
nextMonthLabel val_ =
    Html.Attributes.attribute "next-month-label" val_


{-| The accessible label given to the button used to move to the previous year. (default: `"Previous year"`)
-}
previousYearLabel : String -> Html.Attribute msg
previousYearLabel val_ =
    Html.Attributes.attribute "previous-year-label" val_


{-| The accessible label given to the button used to move to the next year. (default: `"Next year"`)
-}
nextYearLabel : String -> Html.Attribute msg
nextYearLabel val_ =
    Html.Attributes.attribute "next-year-label" val_


{-| The accessible label given to the button used to move to the previous 24 years. (default: `"Previous 24 years"`)
-}
previousMultiYearLabel : String -> Html.Attribute msg
previousMultiYearLabel val_ =
    Html.Attributes.attribute "previous-multi-year-label" val_


{-| The accessible label given to the button used to move to the next 24 years. (default: `"Next 24 years"`)
-}
nextMultiYearLabel : String -> Html.Attribute msg
nextMultiYearLabel val_ =
    Html.Attributes.attribute "next-multi-year-label" val_


{-| The label given to the button used clear the selected date and close the picker. (default: `"Clear"`)
-}
clearLabel : String -> Html.Attribute msg
clearLabel val_ =
    Html.Attributes.attribute "clear-label" val_


{-| The label given to the button used apply the selected date and close the picker. (default: `"OK"`)
-}
confirmLabel : String -> Html.Attribute msg
confirmLabel val_ =
    Html.Attributes.attribute "confirm-label" val_


{-| The label given to the button used discard the selected date and close the picker. (default: `"Cancel"`)
-}
dismissLabel : String -> Html.Attribute msg
dismissLabel val_ =
    Html.Attributes.attribute "dismiss-label" val_


{-| The label given to the the picker. (default: `"Select date"`)
-}
label : String -> Html.Attribute msg
label val_ =
    Html.Attributes.attribute "label" val_


{-| Dispatched when the selected date changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

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
