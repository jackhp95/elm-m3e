module M3e.Html.Datepicker exposing
    ( datepicker, variant, clearable, date, maxDate, minDate
    , range, rangeEnd, rangeStart, startAt, startView, previousMonthLabel
    , nextMonthLabel, previousYearLabel, nextYearLabel, previousMultiYearLabel, nextMultiYearLabel, clearLabel
    , confirmLabel, dismissLabel, label, onChange, onBeforetoggle, onToggle
    )

{-| Middle layer for `<m3e-datepicker>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Datepicker` module for everyday use.

@docs datepicker, variant, clearable, date, maxDate, minDate
@docs range, rangeEnd, rangeStart, startAt, startView, previousMonthLabel
@docs nextMonthLabel, previousYearLabel, nextYearLabel, previousMultiYearLabel, nextMultiYearLabel, clearLabel
@docs confirmLabel, dismissLabel, label, onChange, onBeforetoggle, onToggle

-}

import Html
import Json.Decode
import Json.Encode
import M3e.Raw.Datepicker
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| Presents a date picker on a temporary surface.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `change`: Dispatched when the selected date changes.
  - `beforetoggle`: Dispatched before the toggle state changes.
  - `toggle`: Dispatched after the toggle state has changed.

-}
datepicker :
    List
        (Markup.Html.Attr.Attr
            { variant : M3e.Token.Supported
            , clearable : M3e.Token.Supported
            , date : M3e.Token.Supported
            , maxDate : M3e.Token.Supported
            , minDate : M3e.Token.Supported
            , range : M3e.Token.Supported
            , rangeEnd : M3e.Token.Supported
            , rangeStart : M3e.Token.Supported
            , startAt : M3e.Token.Supported
            , startView : M3e.Token.Supported
            , previousMonthLabel : M3e.Token.Supported
            , nextMonthLabel : M3e.Token.Supported
            , previousYearLabel : M3e.Token.Supported
            , nextYearLabel : M3e.Token.Supported
            , previousMultiYearLabel : M3e.Token.Supported
            , nextMultiYearLabel : M3e.Token.Supported
            , clearLabel : M3e.Token.Supported
            , confirmLabel : M3e.Token.Supported
            , dismissLabel : M3e.Token.Supported
            , label : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onBeforetoggle : M3e.Token.Supported
            , onToggle : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
datepicker attributes children =
    M3e.Raw.Datepicker.datepicker
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| The appearance variant of the picker. (default: `"docked"`)
-}
variant :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , docked : M3e.Token.Supported
        , modal : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Datepicker.variant
        (M3e.Token.toString v_)


{-| Whether the user can clear the selected date and close the picker. (default: `false`)
-}
clearable : Bool -> Markup.Html.Attr.Attr { c | clearable : M3e.Token.Supported } msg
clearable =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Datepicker.clearable


{-| The selected date. (default: `null`)
-}
date : String -> Markup.Html.Attr.Attr { c | date : M3e.Token.Supported } msg
date =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Datepicker.date


{-| The maximum date that can be selected. (default: `null`)
-}
maxDate : String -> Markup.Html.Attr.Attr { c | maxDate : M3e.Token.Supported } msg
maxDate =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Datepicker.maxDate


{-| The minimum date that can be selected. (default: `null`)
-}
minDate : String -> Markup.Html.Attr.Attr { c | minDate : M3e.Token.Supported } msg
minDate =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Datepicker.minDate


{-| Whether a range of dates can be selected. (default: `false`)
-}
range : Bool -> Markup.Html.Attr.Attr { c | range : M3e.Token.Supported } msg
range =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Datepicker.range


{-| End of a date range. (default: `null`)
-}
rangeEnd : String -> Markup.Html.Attr.Attr { c | rangeEnd : M3e.Token.Supported } msg
rangeEnd =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Datepicker.rangeEnd


{-| Start of a date range. (default: `null`)
-}
rangeStart : String -> Markup.Html.Attr.Attr { c | rangeStart : M3e.Token.Supported } msg
rangeStart =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Datepicker.rangeStart


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`)
-}
startAt : String -> Markup.Html.Attr.Attr { c | startAt : M3e.Token.Supported } msg
startAt =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Datepicker.startAt


{-| The initial view used to select a date. (default: `"month"`)
-}
startView :
    M3e.Token.Value
        { month : M3e.Token.Supported
        , multiYear : M3e.Token.Supported
        , year : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | startView : M3e.Token.Supported } msg
startView v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Datepicker.startView
        (M3e.Token.toString v_)


{-| The accessible label given to the button used to move to the previous month. (default: `"Previous month"`)
-}
previousMonthLabel :
    String
    ->
        Markup.Html.Attr.Attr
            { c
                | previousMonthLabel : M3e.Token.Supported
            }
            msg
previousMonthLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Datepicker.previousMonthLabel


{-| The accessible label given to the button used to move to the next month. (default: `"Next month"`)
-}
nextMonthLabel :
    String
    -> Markup.Html.Attr.Attr { c | nextMonthLabel : M3e.Token.Supported } msg
nextMonthLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Datepicker.nextMonthLabel


{-| The accessible label given to the button used to move to the previous year. (default: `"Previous year"`)
-}
previousYearLabel :
    String
    -> Markup.Html.Attr.Attr { c | previousYearLabel : M3e.Token.Supported } msg
previousYearLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Datepicker.previousYearLabel


{-| The accessible label given to the button used to move to the next year. (default: `"Next year"`)
-}
nextYearLabel :
    String
    -> Markup.Html.Attr.Attr { c | nextYearLabel : M3e.Token.Supported } msg
nextYearLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Datepicker.nextYearLabel


{-| The accessible label given to the button used to move to the previous 24 years. (default: `"Previous 24 years"`)
-}
previousMultiYearLabel :
    String
    ->
        Markup.Html.Attr.Attr
            { c
                | previousMultiYearLabel : M3e.Token.Supported
            }
            msg
previousMultiYearLabel =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Datepicker.previousMultiYearLabel


{-| The accessible label given to the button used to move to the next 24 years. (default: `"Next 24 years"`)
-}
nextMultiYearLabel :
    String
    ->
        Markup.Html.Attr.Attr
            { c
                | nextMultiYearLabel : M3e.Token.Supported
            }
            msg
nextMultiYearLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Datepicker.nextMultiYearLabel


{-| The label given to the button used clear the selected date and close the picker. (default: `"Clear"`)
-}
clearLabel : String -> Markup.Html.Attr.Attr { c | clearLabel : M3e.Token.Supported } msg
clearLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Datepicker.clearLabel


{-| The label given to the button used apply the selected date and close the picker. (default: `"OK"`)
-}
confirmLabel :
    String
    -> Markup.Html.Attr.Attr { c | confirmLabel : M3e.Token.Supported } msg
confirmLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Datepicker.confirmLabel


{-| The label given to the button used discard the selected date and close the picker. (default: `"Cancel"`)
-}
dismissLabel :
    String
    -> Markup.Html.Attr.Attr { c | dismissLabel : M3e.Token.Supported } msg
dismissLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Datepicker.dismissLabel


{-| The label given to the the picker. (default: `"Select date"`)
-}
label : String -> Markup.Html.Attr.Attr { c | label : M3e.Token.Supported } msg
label =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Datepicker.label


{-| Listen for `change` events.
-}
onChange :
    (String -> msg)
    -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Datepicker.onChange
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


{-| Listen for `beforetoggle` events.
-}
onBeforetoggle :
    msg
    -> Markup.Html.Attr.Attr { c | onBeforetoggle : M3e.Token.Supported } msg
onBeforetoggle f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Datepicker.onBeforetoggle
        (Json.Decode.succeed f_)


{-| Listen for `toggle` events.
-}
onToggle : msg -> Markup.Html.Attr.Attr { c | onToggle : M3e.Token.Supported } msg
onToggle f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Datepicker.onToggle
        (Json.Decode.succeed f_)
