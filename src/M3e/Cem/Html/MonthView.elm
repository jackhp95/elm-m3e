module M3e.Cem.Html.MonthView exposing
    ( monthView, rangeStart, rangeEnd, active, today, date
    , activeDate, minDate, maxDate, onChange, onActiveChange
    )

{-|
Bottom layer for `<m3e-month-view>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs monthView, rangeStart, rangeEnd, active, today, date
@docs activeDate, minDate, maxDate, onChange, onActiveChange
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-month-view>` element — a partial application of `Html.node`. -}
monthView : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
monthView =
    Html.node "m3e-month-view"


{-| Start of a date range. (default: `null`) -}
rangeStart : String -> Html.Attribute msg
rangeStart =
    Html.Attributes.attribute "range-start"


{-| End of a date range. (default: `null`) -}
rangeEnd : String -> Html.Attribute msg
rangeEnd =
    Html.Attributes.attribute "range-end"


{-| Whether the view is active. (default: `false`) -}
active : Bool -> Html.Attribute msg
active val_ =
    if val_ then
        Html.Attributes.attribute "active" ""
    
    else
        Html.Attributes.classList []


{-| Today's date. (default: `new Date()`) -}
today : String -> Html.Attribute msg
today =
    Html.Attributes.attribute "today"


{-| The selected date. (default: `null`) -}
date : String -> Html.Attribute msg
date =
    Html.Attributes.attribute "date"


{-| The active date. (default: `new Date()`) -}
activeDate : String -> Html.Attribute msg
activeDate =
    Html.Attributes.attribute "active-date"


{-| The minimum date that can be selected. (default: `null`) -}
minDate : String -> Html.Attribute msg
minDate =
    Html.Attributes.attribute "min-date"


{-| The maximum date that can be selected. (default: `null`) -}
maxDate : String -> Html.Attribute msg
maxDate =
    Html.Attributes.attribute "max-date"


{-| Listen for `change` events. -}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange =
    Html.Events.on "change"


{-| Listen for `active-change` events. -}
onActiveChange : Json.Decode.Decoder msg -> Html.Attribute msg
onActiveChange =
    Html.Events.on "active-change"