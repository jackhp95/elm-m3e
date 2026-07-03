module M3e.Cem.YearView exposing
    ( yearView, active, today, date, activeDate, minDate
    , maxDate, onChange, onActiveChange
    )

{-|
Middle layer for `<m3e-year-view>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.YearView` module for everyday use.

@docs yearView, active, today, date, activeDate, minDate
@docs maxDate, onChange, onActiveChange
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.YearView
import M3e.Value


{-| An internal component used to display a single year in a calendar.

**Component Info:**
- **Extends:** `CalendarViewElementBase` from `/src/calendar/CalendarViewElementBase`

**Events:**
- `change`: No description
- `active-change`: No description
-}
yearView :
    List (M3e.Cem.Attr.Attr { active : M3e.Value.Supported
    , today : M3e.Value.Supported
    , date : M3e.Value.Supported
    , activeDate : M3e.Value.Supported
    , minDate : M3e.Value.Supported
    , maxDate : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onActiveChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
yearView attributes children =
    M3e.Cem.Html.YearView.yearView
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the view is active. (default: `false`) -}
active : Bool -> M3e.Cem.Attr.Attr { c | active : M3e.Value.Supported } msg
active =
    M3e.Cem.Attr.attribute M3e.Cem.Html.YearView.active


{-| Today's date. (default: `new Date()`) -}
today : String -> M3e.Cem.Attr.Attr { c | today : M3e.Value.Supported } msg
today =
    M3e.Cem.Attr.attribute M3e.Cem.Html.YearView.today


{-| The selected date. (default: `null`) -}
date : String -> M3e.Cem.Attr.Attr { c | date : M3e.Value.Supported } msg
date =
    M3e.Cem.Attr.attribute M3e.Cem.Html.YearView.date


{-| The active date. (default: `new Date()`) -}
activeDate :
    String -> M3e.Cem.Attr.Attr { c | activeDate : M3e.Value.Supported } msg
activeDate =
    M3e.Cem.Attr.attribute M3e.Cem.Html.YearView.activeDate


{-| The minimum date that can be selected. (default: `null`) -}
minDate : String -> M3e.Cem.Attr.Attr { c | minDate : M3e.Value.Supported } msg
minDate =
    M3e.Cem.Attr.attribute M3e.Cem.Html.YearView.minDate


{-| The maximum date that can be selected. (default: `null`) -}
maxDate : String -> M3e.Cem.Attr.Attr { c | maxDate : M3e.Value.Supported } msg
maxDate =
    M3e.Cem.Attr.attribute M3e.Cem.Html.YearView.maxDate


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.YearView.onChange
        (Json.Decode.succeed f_)


{-| Listen for `active-change` events. -}
onActiveChange :
    msg -> M3e.Cem.Attr.Attr { c | onActiveChange : M3e.Value.Supported } msg
onActiveChange f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.YearView.onActiveChange
        (Json.Decode.succeed f_)