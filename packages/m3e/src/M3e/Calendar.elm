module M3e.Calendar exposing
    ( view, date, maxDate, minDate, rangeEnd, rangeStart
    , startAt, startView, previousMonthLabel, nextMonthLabel, previousYearLabel, nextYearLabel, previousMultiYearLabel
    , nextMultiYearLabel, onChange, header
    )

{-|
A calendar used to select a date.

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
[ M3e.Calendar.view [ M3e.Calendar.date "2026-01-01" ] []
    , Native.div [] []
    ]
```

<!-- elm-cem:example title="Start date" -->
```elm
M3e.Calendar.view [ M3e.Calendar.startAt "2026-01-01" ] []
```

<!-- elm-cem:example title="Start view" -->
```elm
M3e.Calendar.view [ M3e.Calendar.startView M3e.Value.multiYear ] []
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
M3e.Calendar.view [] []
```

<!-- elm-cem:example title="Special dates" -->
```elm
M3e.Calendar.view [ M3e.Calendar.startAt "2026-04-01" ] []
```

@docs view, date, maxDate, minDate, rangeEnd, rangeStart
@docs startAt, startView, previousMonthLabel, nextMonthLabel, previousYearLabel, nextYearLabel
@docs previousMultiYearLabel, nextMultiYearLabel, onChange, header
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Calendar
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-calendar>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { date : M3e.Value.Supported
    , maxDate : M3e.Value.Supported
    , minDate : M3e.Value.Supported
    , rangeEnd : M3e.Value.Supported
    , rangeStart : M3e.Value.Supported
    , startAt : M3e.Value.Supported
    , startView : M3e.Value.Supported
    , previousMonthLabel : M3e.Value.Supported
    , nextMonthLabel : M3e.Value.Supported
    , previousYearLabel : M3e.Value.Supported
    , nextYearLabel : M3e.Value.Supported
    , previousMultiYearLabel : M3e.Value.Supported
    , nextMultiYearLabel : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | calendar : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Calendar.calendar
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| The selected date. (default: `null`) -}
date : String -> M3e.Cem.Attr.Attr { c | date : M3e.Value.Supported } msg
date =
    M3e.Cem.Calendar.date


{-| The maximum date that can be selected. (default: `null`) -}
maxDate : String -> M3e.Cem.Attr.Attr { c | maxDate : M3e.Value.Supported } msg
maxDate =
    M3e.Cem.Calendar.maxDate


{-| The minimum date that can be selected. (default: `null`) -}
minDate : String -> M3e.Cem.Attr.Attr { c | minDate : M3e.Value.Supported } msg
minDate =
    M3e.Cem.Calendar.minDate


{-| End of a date range. (default: `null`) -}
rangeEnd :
    String -> M3e.Cem.Attr.Attr { c | rangeEnd : M3e.Value.Supported } msg
rangeEnd =
    M3e.Cem.Calendar.rangeEnd


{-| Start of a date range. (default: `null`) -}
rangeStart :
    String -> M3e.Cem.Attr.Attr { c | rangeStart : M3e.Value.Supported } msg
rangeStart =
    M3e.Cem.Calendar.rangeStart


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`) -}
startAt : String -> M3e.Cem.Attr.Attr { c | startAt : M3e.Value.Supported } msg
startAt =
    M3e.Cem.Calendar.startAt


{-| The initial view used to select a date. (default: `"month"`) -}
startView :
    M3e.Value.Value { month : M3e.Value.Supported
    , multiYear : M3e.Value.Supported
    , year : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | startView : M3e.Value.Supported } msg
startView =
    M3e.Cem.Calendar.startView


{-| The accessible label given to the button used to move to the previous month. (default: `"Previous month"`) -}
previousMonthLabel :
    String
    -> M3e.Cem.Attr.Attr { c | previousMonthLabel : M3e.Value.Supported } msg
previousMonthLabel =
    M3e.Cem.Calendar.previousMonthLabel


{-| The accessible label given to the button used to move to the next month. (default: `"Next month"`) -}
nextMonthLabel :
    String -> M3e.Cem.Attr.Attr { c | nextMonthLabel : M3e.Value.Supported } msg
nextMonthLabel =
    M3e.Cem.Calendar.nextMonthLabel


{-| The accessible label given to the button used to move to the previous year. (default: `"Previous year"`) -}
previousYearLabel :
    String
    -> M3e.Cem.Attr.Attr { c | previousYearLabel : M3e.Value.Supported } msg
previousYearLabel =
    M3e.Cem.Calendar.previousYearLabel


{-| The accessible label given to the button used to move to the next year. (default: `"Next year"`) -}
nextYearLabel :
    String -> M3e.Cem.Attr.Attr { c | nextYearLabel : M3e.Value.Supported } msg
nextYearLabel =
    M3e.Cem.Calendar.nextYearLabel


{-| The accessible label given to the button used to move to the previous 24 years. (default: `"Previous 24 years"`) -}
previousMultiYearLabel :
    String
    -> M3e.Cem.Attr.Attr { c
        | previousMultiYearLabel : M3e.Value.Supported
    } msg
previousMultiYearLabel =
    M3e.Cem.Calendar.previousMultiYearLabel


{-| The accessible label given to the button used to move to the next 24 years. (default: `"Next 24 years"`) -}
nextMultiYearLabel :
    String
    -> M3e.Cem.Attr.Attr { c | nextMultiYearLabel : M3e.Value.Supported } msg
nextMultiYearLabel =
    M3e.Cem.Calendar.nextMultiYearLabel


{-| Listen for `change` events. -}
onChange :
    (String -> msg)
    -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.Calendar.onChange


{-| Place content in the `header` slot. -}
header : M3e.Element.Element any msg -> M3e.Element.Element k msg
header el =
    M3e.Element.Internal.placeSlot "header" el