module M3e.Build.Calendar exposing
    ( Builder, AttrCaps, SlotCaps, calendar, date, maxDate
    , minDate, rangeEnd, rangeStart, startAt, startView, previousMonthLabel, nextMonthLabel
    , previousYearLabel, nextYearLabel, previousMultiYearLabel, nextMultiYearLabel, onChange, build
    )

{-|
The ⑤ Build shape for `<m3e-calendar>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Calendar as Calendar`.

@docs Builder, AttrCaps, SlotCaps, calendar, date, maxDate
@docs minDate, rangeEnd, rangeStart, startAt, startView, previousMonthLabel
@docs nextMonthLabel, previousYearLabel, nextYearLabel, previousMultiYearLabel, nextMultiYearLabel, onChange
@docs build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.Calendar
import M3e.Cem.Html.Calendar
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-calendar>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | calendar : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { date : M3e.Build.Internal.Available
    , maxDate : M3e.Build.Internal.Available
    , minDate : M3e.Build.Internal.Available
    , rangeEnd : M3e.Build.Internal.Available
    , rangeStart : M3e.Build.Internal.Available
    , startAt : M3e.Build.Internal.Available
    , startView : M3e.Build.Internal.Available
    , previousMonthLabel : M3e.Build.Internal.Available
    , nextMonthLabel : M3e.Build.Internal.Available
    , previousYearLabel : M3e.Build.Internal.Available
    , nextYearLabel : M3e.Build.Internal.Available
    , previousMultiYearLabel : M3e.Build.Internal.Available
    , nextMultiYearLabel : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { header : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-calendar>`. -}
calendar : Builder AttrCaps SlotCaps msg kind
calendar =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Calendar.calendar
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             []
        )


{-| The selected date. (default: `null`) -}
date :
    String
    -> Builder { a | date : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | date : M3e.Build.Internal.Used } s msg kind
date v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Calendar.date v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The maximum date that can be selected. (default: `null`) -}
maxDate :
    String
    -> Builder { a | maxDate : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | maxDate : M3e.Build.Internal.Used } s msg kind
maxDate v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Calendar.maxDate v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The minimum date that can be selected. (default: `null`) -}
minDate :
    String
    -> Builder { a | minDate : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | minDate : M3e.Build.Internal.Used } s msg kind
minDate v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Calendar.minDate v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| End of a date range. (default: `null`) -}
rangeEnd :
    String
    -> Builder { a | rangeEnd : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | rangeEnd : M3e.Build.Internal.Used } s msg kind
rangeEnd v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Calendar.rangeEnd v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Start of a date range. (default: `null`) -}
rangeStart :
    String
    -> Builder { a | rangeStart : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | rangeStart : M3e.Build.Internal.Used } s msg kind
rangeStart v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Calendar.rangeStart v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`) -}
startAt :
    String
    -> Builder { a | startAt : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | startAt : M3e.Build.Internal.Used } s msg kind
startAt v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Calendar.startAt v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The initial view used to select a date. (default: `"month"`) -}
startView :
    M3e.Value.Value { month : M3e.Value.Supported
    , multiYear : M3e.Value.Supported
    , year : M3e.Value.Supported
    }
    -> Builder { a | startView : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | startView : M3e.Build.Internal.Used } s msg kind
startView v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Calendar.startView v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to move to the previous month. (default: `"Previous month"`) -}
previousMonthLabel :
    String
    -> Builder { a
        | previousMonthLabel : M3e.Build.Internal.Available
    } s msg kind
    -> Builder { a | previousMonthLabel : M3e.Build.Internal.Used } s msg kind
previousMonthLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Calendar.previousMonthLabel v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to move to the next month. (default: `"Next month"`) -}
nextMonthLabel :
    String
    -> Builder { a | nextMonthLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | nextMonthLabel : M3e.Build.Internal.Used } s msg kind
nextMonthLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Calendar.nextMonthLabel v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to move to the previous year. (default: `"Previous year"`) -}
previousYearLabel :
    String
    -> Builder { a
        | previousYearLabel : M3e.Build.Internal.Available
    } s msg kind
    -> Builder { a | previousYearLabel : M3e.Build.Internal.Used } s msg kind
previousYearLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Calendar.previousYearLabel v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to move to the next year. (default: `"Next year"`) -}
nextYearLabel :
    String
    -> Builder { a | nextYearLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | nextYearLabel : M3e.Build.Internal.Used } s msg kind
nextYearLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Calendar.nextYearLabel v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to move to the previous 24 years. (default: `"Previous 24 years"`) -}
previousMultiYearLabel :
    String
    -> Builder { a
        | previousMultiYearLabel : M3e.Build.Internal.Available
    } s msg kind
    -> Builder { a
        | previousMultiYearLabel : M3e.Build.Internal.Used
    } s msg kind
previousMultiYearLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Calendar.previousMultiYearLabel v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to move to the next 24 years. (default: `"Next 24 years"`) -}
nextMultiYearLabel :
    String
    -> Builder { a
        | nextMultiYearLabel : M3e.Build.Internal.Available
    } s msg kind
    -> Builder { a | nextMultiYearLabel : M3e.Build.Internal.Used } s msg kind
nextMultiYearLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Calendar.nextMultiYearLabel v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected date changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Attr.Internal.attribute
                       M3e.Cem.Html.Calendar.onChange
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-calendar>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { calendar : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)