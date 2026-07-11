module M3e.Calendar exposing
    ( view, date, maxDate, minDate, rangeEnd, rangeStart
    , startAt, startView, previousMonthLabel, nextMonthLabel, previousYearLabel, nextYearLabel
    , previousMultiYearLabel, nextMultiYearLabel, onChange, header
    )

{-| A calendar used to select a date.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `change`: Dispatched when the selected date changes.

**Slots:**

  - `header`: Renders the header of the calendar.

<!-- elm-cem:docmeta category=Text inputs -->


## Examples


### Examples

<!-- elm-cem:example title="Date selection" -->
```elm
[ M3e.Calendar.view [ M3e.Attributes.id "calendar", M3e.Calendar.date "2026-01-01" ] []
    , Native.div [ Native.attribute "id" "selected-date" ] []
    ]
```

<!-- elm-cem:example title="Start date" -->
```elm
M3e.Calendar.view [ M3e.Calendar.startAt "2026-01-01" ] []
```

<!-- elm-cem:example title="Start view" -->
```elm
M3e.Calendar.view [ M3e.Calendar.startView M3e.Token.multiYear ] []
```

<!-- elm-cem:example title="Date ranges" -->
```elm
M3e.Calendar.view [ M3e.Calendar.rangeStart "2026-01-01", M3e.Calendar.rangeEnd "2026-01-09", M3e.Calendar.startAt "2026-01-01" ] []
```

<!-- elm-cem:example title="Min and max dates" -->
```elm
M3e.Calendar.view [ M3e.Calendar.startAt "2026-04-01", M3e.Calendar.minDate "2026-01-01", M3e.Calendar.maxDate "2026-04-30" ] []
```

<!-- elm-cem:example title="Blackout dates" -->
```elm
M3e.Calendar.view [ M3e.Attributes.id "blackout-dates" ] []
```

<!-- elm-cem:example title="Special dates" -->
```elm
M3e.Calendar.view [ M3e.Attributes.id "special-dates", M3e.Calendar.startAt "2026-04-01" ] []
```

@docs view, date, maxDate, minDate, rangeEnd, rangeStart
@docs startAt, startView, previousMonthLabel, nextMonthLabel, previousYearLabel, nextYearLabel
@docs previousMultiYearLabel, nextMultiYearLabel, onChange, header

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.Calendar
import M3e.Node
import M3e.Token


{-| Build the `<m3e-calendar>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | calendar : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.Calendar.calendar
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| The selected date. (default: `null`)
-}
date : String -> M3e.Html.Attr.Attr { c | date : M3e.Token.Supported } msg
date =
    M3e.Html.Calendar.date


{-| The maximum date that can be selected. (default: `null`)
-}
maxDate : String -> M3e.Html.Attr.Attr { c | maxDate : M3e.Token.Supported } msg
maxDate =
    M3e.Html.Calendar.maxDate


{-| The minimum date that can be selected. (default: `null`)
-}
minDate : String -> M3e.Html.Attr.Attr { c | minDate : M3e.Token.Supported } msg
minDate =
    M3e.Html.Calendar.minDate


{-| End of a date range. (default: `null`)
-}
rangeEnd : String -> M3e.Html.Attr.Attr { c | rangeEnd : M3e.Token.Supported } msg
rangeEnd =
    M3e.Html.Calendar.rangeEnd


{-| Start of a date range. (default: `null`)
-}
rangeStart : String -> M3e.Html.Attr.Attr { c | rangeStart : M3e.Token.Supported } msg
rangeStart =
    M3e.Html.Calendar.rangeStart


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`)
-}
startAt : String -> M3e.Html.Attr.Attr { c | startAt : M3e.Token.Supported } msg
startAt =
    M3e.Html.Calendar.startAt


{-| The initial view used to select a date. (default: `"month"`)
-}
startView :
    M3e.Token.Value
        { month : M3e.Token.Supported
        , multiYear : M3e.Token.Supported
        , year : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | startView : M3e.Token.Supported } msg
startView =
    M3e.Html.Calendar.startView


{-| The accessible label given to the button used to move to the previous month. (default: `"Previous month"`)
-}
previousMonthLabel :
    String
    -> M3e.Html.Attr.Attr { c | previousMonthLabel : M3e.Token.Supported } msg
previousMonthLabel =
    M3e.Html.Calendar.previousMonthLabel


{-| The accessible label given to the button used to move to the next month. (default: `"Next month"`)
-}
nextMonthLabel :
    String
    -> M3e.Html.Attr.Attr { c | nextMonthLabel : M3e.Token.Supported } msg
nextMonthLabel =
    M3e.Html.Calendar.nextMonthLabel


{-| The accessible label given to the button used to move to the previous year. (default: `"Previous year"`)
-}
previousYearLabel :
    String
    -> M3e.Html.Attr.Attr { c | previousYearLabel : M3e.Token.Supported } msg
previousYearLabel =
    M3e.Html.Calendar.previousYearLabel


{-| The accessible label given to the button used to move to the next year. (default: `"Next year"`)
-}
nextYearLabel : String -> M3e.Html.Attr.Attr { c | nextYearLabel : M3e.Token.Supported } msg
nextYearLabel =
    M3e.Html.Calendar.nextYearLabel


{-| The accessible label given to the button used to move to the previous 24 years. (default: `"Previous 24 years"`)
-}
previousMultiYearLabel :
    String
    ->
        M3e.Html.Attr.Attr
            { c
                | previousMultiYearLabel : M3e.Token.Supported
            }
            msg
previousMultiYearLabel =
    M3e.Html.Calendar.previousMultiYearLabel


{-| The accessible label given to the button used to move to the next 24 years. (default: `"Next 24 years"`)
-}
nextMultiYearLabel :
    String
    -> M3e.Html.Attr.Attr { c | nextMultiYearLabel : M3e.Token.Supported } msg
nextMultiYearLabel =
    M3e.Html.Calendar.nextMultiYearLabel


{-| Listen for `change` events.
-}
onChange :
    (String -> msg)
    -> M3e.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.Calendar.onChange


{-| Place content in the `header` slot.
-}
header : M3e.Element.Element any msg -> M3e.Element.Element k msg
header el =
    M3e.Element.Internal.placeSlot "header" el
