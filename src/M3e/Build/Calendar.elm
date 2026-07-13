module M3e.Build.Calendar exposing
    ( Builder, AttrCaps, SlotCaps, calendar, attr, date
    , maxDate, minDate, rangeEnd, rangeStart, startAt, startView
    , previousMonthLabel, nextMonthLabel, previousYearLabel, nextYearLabel, previousMultiYearLabel, nextMultiYearLabel
    , onChange, header, build
    )

{-| The Build form for `<m3e-calendar>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Calendar as Calendar`.

@docs Builder, AttrCaps, SlotCaps, calendar, attr, date
@docs maxDate, minDate, rangeEnd, rangeStart, startAt, startView
@docs previousMonthLabel, nextMonthLabel, previousYearLabel, nextYearLabel, previousMultiYearLabel, nextMultiYearLabel
@docs onChange, header, build

-}

import M3e.Build.Internal
import M3e.Html.Calendar
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-calendar>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | calendar : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
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


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { header : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-calendar>`.
-}
calendar : Builder AttrCaps SlotCaps msg kind
calendar =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.Calendar.calendar
                    (List.map Markup.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            []
        )


{-| Inject an already-built universal `Attr` (e.g. from `M3e.Aria.*`) into the pipeline, appending it to the accumulated attrs. Unlike the typed per-attribute setters it consumes no phantom capability, so it can be applied any number of times.
-}
attr :
    Markup.Html.Attr.Internal.Attr caps msg
    -> Builder a s msg kind
    -> Builder a s msg kind
attr a_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget a_)
            (M3e.Build.Internal.node_ b_)
        )


{-| The selected date. (default: `null`)
-}
date :
    String
    -> Builder { a | date : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | date : M3e.Build.Internal.Used } s msg kind
date v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Calendar.date v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The maximum date that can be selected. (default: `null`)
-}
maxDate :
    String
    -> Builder { a | maxDate : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | maxDate : M3e.Build.Internal.Used } s msg kind
maxDate v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Calendar.maxDate v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The minimum date that can be selected. (default: `null`)
-}
minDate :
    String
    -> Builder { a | minDate : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | minDate : M3e.Build.Internal.Used } s msg kind
minDate v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Calendar.minDate v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| End of a date range. (default: `null`)
-}
rangeEnd :
    String
    -> Builder { a | rangeEnd : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | rangeEnd : M3e.Build.Internal.Used } s msg kind
rangeEnd v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Calendar.rangeEnd v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Start of a date range. (default: `null`)
-}
rangeStart :
    String
    -> Builder { a | rangeStart : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | rangeStart : M3e.Build.Internal.Used } s msg kind
rangeStart v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Calendar.rangeStart v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`)
-}
startAt :
    String
    -> Builder { a | startAt : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | startAt : M3e.Build.Internal.Used } s msg kind
startAt v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Calendar.startAt v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The initial view used to select a date. (default: `"month"`)
-}
startView :
    M3e.Token.Value
        { month : M3e.Token.Supported
        , multiYear : M3e.Token.Supported
        , year : M3e.Token.Supported
        }
    -> Builder { a | startView : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | startView : M3e.Build.Internal.Used } s msg kind
startView v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Calendar.startView v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to move to the previous month. (default: `"Previous month"`)
-}
previousMonthLabel :
    String
    ->
        Builder
            { a
                | previousMonthLabel : M3e.Build.Internal.Available
            }
            s
            msg
            kind
    -> Builder { a | previousMonthLabel : M3e.Build.Internal.Used } s msg kind
previousMonthLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Calendar.previousMonthLabel v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to move to the next month. (default: `"Next month"`)
-}
nextMonthLabel :
    String
    -> Builder { a | nextMonthLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | nextMonthLabel : M3e.Build.Internal.Used } s msg kind
nextMonthLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Calendar.nextMonthLabel v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to move to the previous year. (default: `"Previous year"`)
-}
previousYearLabel :
    String
    ->
        Builder
            { a
                | previousYearLabel : M3e.Build.Internal.Available
            }
            s
            msg
            kind
    -> Builder { a | previousYearLabel : M3e.Build.Internal.Used } s msg kind
previousYearLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Calendar.previousYearLabel v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to move to the next year. (default: `"Next year"`)
-}
nextYearLabel :
    String
    -> Builder { a | nextYearLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | nextYearLabel : M3e.Build.Internal.Used } s msg kind
nextYearLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Calendar.nextYearLabel v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to move to the previous 24 years. (default: `"Previous 24 years"`)
-}
previousMultiYearLabel :
    String
    ->
        Builder
            { a
                | previousMultiYearLabel : M3e.Build.Internal.Available
            }
            s
            msg
            kind
    ->
        Builder
            { a
                | previousMultiYearLabel : M3e.Build.Internal.Used
            }
            s
            msg
            kind
previousMultiYearLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Calendar.previousMultiYearLabel v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to move to the next 24 years. (default: `"Next 24 years"`)
-}
nextMultiYearLabel :
    String
    ->
        Builder
            { a
                | nextMultiYearLabel : M3e.Build.Internal.Available
            }
            s
            msg
            kind
    -> Builder { a | nextMultiYearLabel : M3e.Build.Internal.Used } s msg kind
nextMultiYearLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.Calendar.nextMultiYearLabel v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected date changes.
-}
onChange :
    (String -> msg)
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Calendar.onChange v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `header` slot.
-}
header :
    Markup.Element.Element any msg
    -> Builder a { s | header : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | header : M3e.Build.Internal.Used } msg kind
header el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "header" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-calendar>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { calendar : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
