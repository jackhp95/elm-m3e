module M3e.Html.Calendar exposing
    ( calendar, date, maxDate, minDate, rangeEnd, rangeStart
    , startAt, startView, previousMonthLabel, nextMonthLabel, previousYearLabel, nextYearLabel
    , previousMultiYearLabel, nextMultiYearLabel, onChange
    )

{-| Middle layer for `<m3e-calendar>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Calendar` module for everyday use.

@docs calendar, date, maxDate, minDate, rangeEnd, rangeStart
@docs startAt, startView, previousMonthLabel, nextMonthLabel, previousYearLabel, nextYearLabel
@docs previousMultiYearLabel, nextMultiYearLabel, onChange

-}

import Html
import Json.Decode
import Json.Encode
import M3e.Raw.Calendar
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| A calendar used to select a date.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `change`: Dispatched when the selected date changes.

**Slots:**

  - `header`: Renders the header of the calendar.

-}
calendar :
    List
        (Markup.Html.Attr.Attr
            { date : M3e.Token.Supported
            , maxDate : M3e.Token.Supported
            , minDate : M3e.Token.Supported
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
            , onChange : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
calendar attributes children =
    M3e.Raw.Calendar.calendar
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| The selected date. (default: `null`)
-}
date : String -> Markup.Html.Attr.Attr { c | date : M3e.Token.Supported } msg
date =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Calendar.date


{-| The maximum date that can be selected. (default: `null`)
-}
maxDate : String -> Markup.Html.Attr.Attr { c | maxDate : M3e.Token.Supported } msg
maxDate =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Calendar.maxDate


{-| The minimum date that can be selected. (default: `null`)
-}
minDate : String -> Markup.Html.Attr.Attr { c | minDate : M3e.Token.Supported } msg
minDate =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Calendar.minDate


{-| End of a date range. (default: `null`)
-}
rangeEnd : String -> Markup.Html.Attr.Attr { c | rangeEnd : M3e.Token.Supported } msg
rangeEnd =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Calendar.rangeEnd


{-| Start of a date range. (default: `null`)
-}
rangeStart : String -> Markup.Html.Attr.Attr { c | rangeStart : M3e.Token.Supported } msg
rangeStart =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Calendar.rangeStart


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`)
-}
startAt : String -> Markup.Html.Attr.Attr { c | startAt : M3e.Token.Supported } msg
startAt =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Calendar.startAt


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
        M3e.Raw.Calendar.startView
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
    Markup.Html.Attr.Internal.attribute M3e.Raw.Calendar.previousMonthLabel


{-| The accessible label given to the button used to move to the next month. (default: `"Next month"`)
-}
nextMonthLabel :
    String
    -> Markup.Html.Attr.Attr { c | nextMonthLabel : M3e.Token.Supported } msg
nextMonthLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Calendar.nextMonthLabel


{-| The accessible label given to the button used to move to the previous year. (default: `"Previous year"`)
-}
previousYearLabel :
    String
    -> Markup.Html.Attr.Attr { c | previousYearLabel : M3e.Token.Supported } msg
previousYearLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Calendar.previousYearLabel


{-| The accessible label given to the button used to move to the next year. (default: `"Next year"`)
-}
nextYearLabel :
    String
    -> Markup.Html.Attr.Attr { c | nextYearLabel : M3e.Token.Supported } msg
nextYearLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Calendar.nextYearLabel


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
    Markup.Html.Attr.Internal.attribute M3e.Raw.Calendar.previousMultiYearLabel


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
    Markup.Html.Attr.Internal.attribute M3e.Raw.Calendar.nextMultiYearLabel


{-| Listen for `change` events.
-}
onChange :
    (String -> msg)
    -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Calendar.onChange
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
