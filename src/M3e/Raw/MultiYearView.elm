module M3e.Raw.MultiYearView exposing
    ( multiYearView, active, today, date, activeDate, minDate
    , maxDate, onChange, onActiveChange
    )

{-| Bottom layer for `<m3e-multi-year-view>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs multiYearView, active, today, date, activeDate, minDate
@docs maxDate, onChange, onActiveChange

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-multi-year-view>` element — a partial application of `Html.node`.
-}
multiYearView : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
multiYearView =
    Html.node "m3e-multi-year-view"


{-| Whether the view is active. (default: `false`)
-}
active : Bool -> Html.Attribute msg
active val_ =
    if val_ then
        Html.Attributes.attribute "active" ""

    else
        Html.Attributes.classList []


{-| Today's date. (default: `new Date()`)
-}
today : String -> Html.Attribute msg
today =
    Html.Attributes.attribute "today"


{-| The selected date. (default: `null`)
-}
date : String -> Html.Attribute msg
date =
    Html.Attributes.attribute "date"


{-| The active date. (default: `new Date()`)
-}
activeDate : String -> Html.Attribute msg
activeDate =
    Html.Attributes.attribute "active-date"


{-| The minimum date that can be selected. (default: `null`)
-}
minDate : String -> Html.Attribute msg
minDate =
    Html.Attributes.attribute "min-date"


{-| The maximum date that can be selected. (default: `null`)
-}
maxDate : String -> Html.Attribute msg
maxDate =
    Html.Attributes.attribute "max-date"


{-| Listen for `change` events.
-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange =
    Html.Events.on "change"


{-| Listen for `active-change` events.
-}
onActiveChange : Json.Decode.Decoder msg -> Html.Attribute msg
onActiveChange =
    Html.Events.on "active-change"
