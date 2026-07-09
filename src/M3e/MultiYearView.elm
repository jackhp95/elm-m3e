module M3e.MultiYearView exposing
    ( view, active, today, date, activeDate, minDate
    , maxDate, onChange, onActiveChange
    )

{-|
An internal component used to display a year selector in a calendar.

**Component Info:**
- **Extends:** `CalendarViewElementBase` from `/src/calendar/CalendarViewElementBase`

**Events:**
- `change`: No description
- `active-change`: No description

@docs view, active, today, date, activeDate, minDate
@docs maxDate, onChange, onActiveChange
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.MultiYearView
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-multi-year-view>` element (lazy IR). -}
view :
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | multiYearView : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.MultiYearView.multiYearView
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| Whether the view is active. (default: `false`) -}
active : Bool -> M3e.Cem.Attr.Attr { c | active : M3e.Value.Supported } msg
active =
    M3e.Cem.MultiYearView.active


{-| Today's date. (default: `new Date()`) -}
today : String -> M3e.Cem.Attr.Attr { c | today : M3e.Value.Supported } msg
today =
    M3e.Cem.MultiYearView.today


{-| The selected date. (default: `null`) -}
date : String -> M3e.Cem.Attr.Attr { c | date : M3e.Value.Supported } msg
date =
    M3e.Cem.MultiYearView.date


{-| The active date. (default: `new Date()`) -}
activeDate :
    String -> M3e.Cem.Attr.Attr { c | activeDate : M3e.Value.Supported } msg
activeDate =
    M3e.Cem.MultiYearView.activeDate


{-| The minimum date that can be selected. (default: `null`) -}
minDate : String -> M3e.Cem.Attr.Attr { c | minDate : M3e.Value.Supported } msg
minDate =
    M3e.Cem.MultiYearView.minDate


{-| The maximum date that can be selected. (default: `null`) -}
maxDate : String -> M3e.Cem.Attr.Attr { c | maxDate : M3e.Value.Supported } msg
maxDate =
    M3e.Cem.MultiYearView.maxDate


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.MultiYearView.onChange


{-| Listen for `active-change` events. -}
onActiveChange :
    msg -> M3e.Cem.Attr.Attr { c | onActiveChange : M3e.Value.Supported } msg
onActiveChange =
    M3e.Cem.MultiYearView.onActiveChange