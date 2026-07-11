module M3e.Raw.Calendar exposing
    ( calendar, date, maxDate, minDate, rangeEnd, rangeStart
    , startAt, startView, previousMonthLabel, nextMonthLabel, previousYearLabel, nextYearLabel
    , previousMultiYearLabel, nextMultiYearLabel, onChange
    )

{-| Bottom layer for `<m3e-calendar>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs calendar, date, maxDate, minDate, rangeEnd, rangeStart
@docs startAt, startView, previousMonthLabel, nextMonthLabel, previousYearLabel, nextYearLabel
@docs previousMultiYearLabel, nextMultiYearLabel, onChange

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-calendar>` element — a partial application of `Html.node`.
-}
calendar : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
calendar =
    Html.node "m3e-calendar"


{-| The selected date. (default: `null`)
-}
date : String -> Html.Attribute msg
date =
    Html.Attributes.attribute "date"


{-| The maximum date that can be selected. (default: `null`)
-}
maxDate : String -> Html.Attribute msg
maxDate =
    Html.Attributes.attribute "max-date"


{-| The minimum date that can be selected. (default: `null`)
-}
minDate : String -> Html.Attribute msg
minDate =
    Html.Attributes.attribute "min-date"


{-| End of a date range. (default: `null`)
-}
rangeEnd : String -> Html.Attribute msg
rangeEnd =
    Html.Attributes.attribute "range-end"


{-| Start of a date range. (default: `null`)
-}
rangeStart : String -> Html.Attribute msg
rangeStart =
    Html.Attributes.attribute "range-start"


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`)
-}
startAt : String -> Html.Attribute msg
startAt =
    Html.Attributes.attribute "start-at"


{-| The initial view used to select a date. (default: `"month"`)
-}
startView : String -> Html.Attribute msg
startView =
    Html.Attributes.attribute "start-view"


{-| The accessible label given to the button used to move to the previous month. (default: `"Previous month"`)
-}
previousMonthLabel : String -> Html.Attribute msg
previousMonthLabel =
    Html.Attributes.attribute "previous-month-label"


{-| The accessible label given to the button used to move to the next month. (default: `"Next month"`)
-}
nextMonthLabel : String -> Html.Attribute msg
nextMonthLabel =
    Html.Attributes.attribute "next-month-label"


{-| The accessible label given to the button used to move to the previous year. (default: `"Previous year"`)
-}
previousYearLabel : String -> Html.Attribute msg
previousYearLabel =
    Html.Attributes.attribute "previous-year-label"


{-| The accessible label given to the button used to move to the next year. (default: `"Next year"`)
-}
nextYearLabel : String -> Html.Attribute msg
nextYearLabel =
    Html.Attributes.attribute "next-year-label"


{-| The accessible label given to the button used to move to the previous 24 years. (default: `"Previous 24 years"`)
-}
previousMultiYearLabel : String -> Html.Attribute msg
previousMultiYearLabel =
    Html.Attributes.attribute "previous-multi-year-label"


{-| The accessible label given to the button used to move to the next 24 years. (default: `"Next 24 years"`)
-}
nextMultiYearLabel : String -> Html.Attribute msg
nextMultiYearLabel =
    Html.Attributes.attribute "next-multi-year-label"


{-| Listen for `change` events.
-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange =
    Html.Events.on "change"
