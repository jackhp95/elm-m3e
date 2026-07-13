module M3e.MonthView exposing
    ( view, rangeStart, rangeEnd, active, today, date
    , activeDate, minDate, maxDate, onChange, onActiveChange
    )

{-| An internal component used to display a single month in a calendar.

**Component Info:**

  - **Extends:** `CalendarViewElementBase` from `/src/calendar/CalendarViewElementBase`

**Events:**

  - `change`: No description
  - `active-change`: No description

@docs view, rangeStart, rangeEnd, active, today, date
@docs activeDate, minDate, maxDate, onChange, onActiveChange

-}

import M3e.Html.MonthView
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-month-view>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { rangeStart : M3e.Token.Supported
            , rangeEnd : M3e.Token.Supported
            , active : M3e.Token.Supported
            , today : M3e.Token.Supported
            , date : M3e.Token.Supported
            , activeDate : M3e.Token.Supported
            , minDate : M3e.Token.Supported
            , maxDate : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onActiveChange : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | monthView : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.MonthView.monthView
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Start of a date range. (default: `null`)
-}
rangeStart : String -> Markup.Html.Attr.Attr { c | rangeStart : M3e.Token.Supported } msg
rangeStart =
    M3e.Html.MonthView.rangeStart


{-| End of a date range. (default: `null`)
-}
rangeEnd : String -> Markup.Html.Attr.Attr { c | rangeEnd : M3e.Token.Supported } msg
rangeEnd =
    M3e.Html.MonthView.rangeEnd


{-| Whether the view is active. (default: `false`)
-}
active : Bool -> Markup.Html.Attr.Attr { c | active : M3e.Token.Supported } msg
active =
    M3e.Html.MonthView.active


{-| Today's date. (default: `new Date()`)
-}
today : String -> Markup.Html.Attr.Attr { c | today : M3e.Token.Supported } msg
today =
    M3e.Html.MonthView.today


{-| The selected date. (default: `null`)
-}
date : String -> Markup.Html.Attr.Attr { c | date : M3e.Token.Supported } msg
date =
    M3e.Html.MonthView.date


{-| The active date. (default: `new Date()`)
-}
activeDate : String -> Markup.Html.Attr.Attr { c | activeDate : M3e.Token.Supported } msg
activeDate =
    M3e.Html.MonthView.activeDate


{-| The minimum date that can be selected. (default: `null`)
-}
minDate : String -> Markup.Html.Attr.Attr { c | minDate : M3e.Token.Supported } msg
minDate =
    M3e.Html.MonthView.minDate


{-| The maximum date that can be selected. (default: `null`)
-}
maxDate : String -> Markup.Html.Attr.Attr { c | maxDate : M3e.Token.Supported } msg
maxDate =
    M3e.Html.MonthView.maxDate


{-| Listen for `change` events.
-}
onChange : msg -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.MonthView.onChange


{-| Listen for `active-change` events.
-}
onActiveChange :
    msg
    -> Markup.Html.Attr.Attr { c | onActiveChange : M3e.Token.Supported } msg
onActiveChange =
    M3e.Html.MonthView.onActiveChange
