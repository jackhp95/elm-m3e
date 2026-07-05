module M3e.Build.Datepicker exposing
    ( Builder, AttrCaps, SlotCaps, datepicker, variant, clearable
    , date, maxDate, minDate, range, rangeEnd, rangeStart, startAt
    , startView, previousMonthLabel, nextMonthLabel, previousYearLabel, nextYearLabel, previousMultiYearLabel, nextMultiYearLabel
    , clearLabel, confirmLabel, dismissLabel, label, onChange, onBeforetoggle, onToggle
    )

{-|
The ⑤ Build shape for `<m3e-datepicker>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Datepicker as Datepicker`.

@docs Builder, AttrCaps, SlotCaps, datepicker, variant, clearable
@docs date, maxDate, minDate, range, rangeEnd, rangeStart
@docs startAt, startView, previousMonthLabel, nextMonthLabel, previousYearLabel, nextYearLabel
@docs previousMultiYearLabel, nextMultiYearLabel, clearLabel, confirmLabel, dismissLabel, label
@docs onChange, onBeforetoggle, onToggle
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Datepicker
import M3e.Cem.Html.Datepicker
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-datepicker>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | datepicker : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { variant : M3e.Build.Internal.Available
    , clearable : M3e.Build.Internal.Available
    , date : M3e.Build.Internal.Available
    , maxDate : M3e.Build.Internal.Available
    , minDate : M3e.Build.Internal.Available
    , range : M3e.Build.Internal.Available
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
    , clearLabel : M3e.Build.Internal.Available
    , confirmLabel : M3e.Build.Internal.Available
    , dismissLabel : M3e.Build.Internal.Available
    , label : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onBeforetoggle : M3e.Build.Internal.Available
    , onToggle : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-datepicker>`. -}
datepicker : Builder AttrCaps SlotCaps msg kind
datepicker =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Datepicker.datepicker
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| The appearance variant of the picker. (default: `"docked"`) -}
variant :
    M3e.Value.Value { auto : M3e.Value.Supported
    , docked : M3e.Value.Supported
    , modal : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Datepicker.variant v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the user can clear the selected date and close the picker. (default: `false`) -}
clearable :
    Bool
    -> Builder { a | clearable : M3e.Build.Internal.Available } s msg kind
    -> Builder { clearable : M3e.Build.Internal.Used } s msg kind
clearable v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Datepicker.clearable v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The selected date. (default: `null`) -}
date :
    String
    -> Builder { a | date : M3e.Build.Internal.Available } s msg kind
    -> Builder { date : M3e.Build.Internal.Used } s msg kind
date v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Datepicker.date v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The maximum date that can be selected. (default: `null`) -}
maxDate :
    String
    -> Builder { a | maxDate : M3e.Build.Internal.Available } s msg kind
    -> Builder { maxDate : M3e.Build.Internal.Used } s msg kind
maxDate v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Datepicker.maxDate v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The minimum date that can be selected. (default: `null`) -}
minDate :
    String
    -> Builder { a | minDate : M3e.Build.Internal.Available } s msg kind
    -> Builder { minDate : M3e.Build.Internal.Used } s msg kind
minDate v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Datepicker.minDate v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether a range of dates can be selected. (default: `false`) -}
range :
    Bool
    -> Builder { a | range : M3e.Build.Internal.Available } s msg kind
    -> Builder { range : M3e.Build.Internal.Used } s msg kind
range v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Datepicker.range v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| End of a date range. (default: `null`) -}
rangeEnd :
    String
    -> Builder { a | rangeEnd : M3e.Build.Internal.Available } s msg kind
    -> Builder { rangeEnd : M3e.Build.Internal.Used } s msg kind
rangeEnd v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Datepicker.rangeEnd v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Start of a date range. (default: `null`) -}
rangeStart :
    String
    -> Builder { a | rangeStart : M3e.Build.Internal.Available } s msg kind
    -> Builder { rangeStart : M3e.Build.Internal.Used } s msg kind
rangeStart v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Datepicker.rangeStart v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`) -}
startAt :
    String
    -> Builder { a | startAt : M3e.Build.Internal.Available } s msg kind
    -> Builder { startAt : M3e.Build.Internal.Used } s msg kind
startAt v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Datepicker.startAt v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The initial view used to select a date. (default: `"month"`) -}
startView :
    M3e.Value.Value { month : M3e.Value.Supported
    , multiYear : M3e.Value.Supported
    , year : M3e.Value.Supported
    }
    -> Builder { a | startView : M3e.Build.Internal.Available } s msg kind
    -> Builder { startView : M3e.Build.Internal.Used } s msg kind
startView v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Datepicker.startView v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to move to the previous month. (default: `"Previous month"`) -}
previousMonthLabel :
    String
    -> Builder { a
        | previousMonthLabel : M3e.Build.Internal.Available
    } s msg kind
    -> Builder { previousMonthLabel : M3e.Build.Internal.Used } s msg kind
previousMonthLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Datepicker.previousMonthLabel v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to move to the next month. (default: `"Next month"`) -}
nextMonthLabel :
    String
    -> Builder { a | nextMonthLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { nextMonthLabel : M3e.Build.Internal.Used } s msg kind
nextMonthLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Datepicker.nextMonthLabel v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to move to the previous year. (default: `"Previous year"`) -}
previousYearLabel :
    String
    -> Builder { a
        | previousYearLabel : M3e.Build.Internal.Available
    } s msg kind
    -> Builder { previousYearLabel : M3e.Build.Internal.Used } s msg kind
previousYearLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Datepicker.previousYearLabel v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to move to the next year. (default: `"Next year"`) -}
nextYearLabel :
    String
    -> Builder { a | nextYearLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { nextYearLabel : M3e.Build.Internal.Used } s msg kind
nextYearLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Datepicker.nextYearLabel v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to move to the previous 24 years. (default: `"Previous 24 years"`) -}
previousMultiYearLabel :
    String
    -> Builder { a
        | previousMultiYearLabel : M3e.Build.Internal.Available
    } s msg kind
    -> Builder { previousMultiYearLabel : M3e.Build.Internal.Used } s msg kind
previousMultiYearLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Datepicker.previousMultiYearLabel v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to move to the next 24 years. (default: `"Next 24 years"`) -}
nextMultiYearLabel :
    String
    -> Builder { a
        | nextMultiYearLabel : M3e.Build.Internal.Available
    } s msg kind
    -> Builder { nextMultiYearLabel : M3e.Build.Internal.Used } s msg kind
nextMultiYearLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Datepicker.nextMultiYearLabel v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The label given to the button used clear the selected date and close the picker. (default: `"Clear"`) -}
clearLabel :
    String
    -> Builder { a | clearLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { clearLabel : M3e.Build.Internal.Used } s msg kind
clearLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Datepicker.clearLabel v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The label given to the button used apply the selected date and close the picker. (default: `"OK"`) -}
confirmLabel :
    String
    -> Builder { a | confirmLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { confirmLabel : M3e.Build.Internal.Used } s msg kind
confirmLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Datepicker.confirmLabel v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The label given to the button used discard the selected date and close the picker. (default: `"Cancel"`) -}
dismissLabel :
    String
    -> Builder { a | dismissLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { dismissLabel : M3e.Build.Internal.Used } s msg kind
dismissLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Datepicker.dismissLabel v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The label given to the the picker. (default: `"Select date"`) -}
label :
    String
    -> Builder { a | label : M3e.Build.Internal.Available } s msg kind
    -> Builder { label : M3e.Build.Internal.Used } s msg kind
label v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Datepicker.label v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the selected date changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.Datepicker.onChange v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the toggle state changes. -}
onBeforetoggle :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforetoggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { onBeforetoggle : M3e.Build.Internal.Used } s msg kind
onBeforetoggle v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute
                       M3e.Cem.Html.Datepicker.onBeforetoggle
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched after the toggle state has changed. -}
onToggle :
    Json.Decode.Decoder msg
    -> Builder { a | onToggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { onToggle : M3e.Build.Internal.Used } s msg kind
onToggle v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.Datepicker.onToggle v_)
             )
             (M3e.Build.Internal.node_ b_)
        )