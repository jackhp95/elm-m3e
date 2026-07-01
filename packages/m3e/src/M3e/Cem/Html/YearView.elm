module M3e.Cem.Html.YearView exposing (activeDate, date, maxDate, minDate, onActiveChange, onChange, today, yearView)

{-| 
@docs yearView, today, date, activeDate, minDate, maxDate, onChange, onActiveChange
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-year-view>` element — a partial application of `Html.node`. -}
yearView : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
yearView =
    Html.node "m3e-year-view"


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