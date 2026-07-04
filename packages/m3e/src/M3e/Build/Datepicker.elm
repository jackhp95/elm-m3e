module M3e.Build.Datepicker exposing
    ( Builder, AttrCaps, SlotCaps, datepicker, variant, clearable
    , date, maxDate, minDate, range, rangeEnd, rangeStart, startAt
    , startView, previousMonthLabel, nextMonthLabel, previousYearLabel, nextYearLabel, previousMultiYearLabel, nextMultiYearLabel
    , clearLabel, confirmLabel, dismissLabel, label, onChange, onBeforetoggle, onToggle
    , build
    )

{-|
The ⑤ Build shape for `<m3e-datepicker>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Datepicker as Datepicker`.

@docs Builder, AttrCaps, SlotCaps, datepicker, variant, clearable
@docs date, maxDate, minDate, range, rangeEnd, rangeStart
@docs startAt, startView, previousMonthLabel, nextMonthLabel, previousYearLabel, nextYearLabel
@docs previousMultiYearLabel, nextMultiYearLabel, clearLabel, confirmLabel, dismissLabel, label
@docs onChange, onBeforetoggle, onToggle, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Datepicker
import M3e.Cem.Html.Datepicker
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-datepicker>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


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


type alias Fields msg =
    { variant :
        Maybe (M3e.Value.Value { auto : M3e.Value.Supported
        , docked : M3e.Value.Supported
        , modal : M3e.Value.Supported
        })
    , clearable : Maybe Bool
    , date : Maybe String
    , maxDate : Maybe String
    , minDate : Maybe String
    , range : Maybe Bool
    , rangeEnd : Maybe String
    , rangeStart : Maybe String
    , startAt : Maybe String
    , startView :
        Maybe (M3e.Value.Value { month : M3e.Value.Supported
        , multiYear : M3e.Value.Supported
        , year : M3e.Value.Supported
        })
    , previousMonthLabel : Maybe String
    , nextMonthLabel : Maybe String
    , previousYearLabel : Maybe String
    , nextYearLabel : Maybe String
    , previousMultiYearLabel : Maybe String
    , nextMultiYearLabel : Maybe String
    , clearLabel : Maybe String
    , confirmLabel : Maybe String
    , dismissLabel : Maybe String
    , label : Maybe String
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onBeforetoggle : Maybe (Json.Decode.Decoder msg)
    , onToggle : Maybe (Json.Decode.Decoder msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-datepicker>`. -}
datepicker : Builder AttrCaps SlotCaps msg
datepicker =
    Builder
        { variant = Nothing
        , clearable = Nothing
        , date = Nothing
        , maxDate = Nothing
        , minDate = Nothing
        , range = Nothing
        , rangeEnd = Nothing
        , rangeStart = Nothing
        , startAt = Nothing
        , startView = Nothing
        , previousMonthLabel = Nothing
        , nextMonthLabel = Nothing
        , previousYearLabel = Nothing
        , nextYearLabel = Nothing
        , previousMultiYearLabel = Nothing
        , nextMultiYearLabel = Nothing
        , clearLabel = Nothing
        , confirmLabel = Nothing
        , dismissLabel = Nothing
        , label = Nothing
        , onChange = Nothing
        , onBeforetoggle = Nothing
        , onToggle = Nothing
        , phantomMsg_ = Nothing
        }


{-| The appearance variant of the picker. (default: `"docked"`) -}
variant :
    M3e.Value.Value { auto : M3e.Value.Supported
    , docked : M3e.Value.Supported
    , modal : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg
variant v_ (Builder f_) =
    Builder { f_ | variant = Just v_ }


{-| Whether the user can clear the selected date and close the picker. (default: `false`) -}
clearable :
    Bool
    -> Builder { a | clearable : M3e.Build.Internal.Available } s msg
    -> Builder { a | clearable : M3e.Build.Internal.Used } s msg
clearable v_ (Builder f_) =
    Builder { f_ | clearable = Just v_ }


{-| The selected date. (default: `null`) -}
date :
    String
    -> Builder { a | date : M3e.Build.Internal.Available } s msg
    -> Builder { a | date : M3e.Build.Internal.Used } s msg
date v_ (Builder f_) =
    Builder { f_ | date = Just v_ }


{-| The maximum date that can be selected. (default: `null`) -}
maxDate :
    String
    -> Builder { a | maxDate : M3e.Build.Internal.Available } s msg
    -> Builder { a | maxDate : M3e.Build.Internal.Used } s msg
maxDate v_ (Builder f_) =
    Builder { f_ | maxDate = Just v_ }


{-| The minimum date that can be selected. (default: `null`) -}
minDate :
    String
    -> Builder { a | minDate : M3e.Build.Internal.Available } s msg
    -> Builder { a | minDate : M3e.Build.Internal.Used } s msg
minDate v_ (Builder f_) =
    Builder { f_ | minDate = Just v_ }


{-| Whether a range of dates can be selected. (default: `false`) -}
range :
    Bool
    -> Builder { a | range : M3e.Build.Internal.Available } s msg
    -> Builder { a | range : M3e.Build.Internal.Used } s msg
range v_ (Builder f_) =
    Builder { f_ | range = Just v_ }


{-| End of a date range. (default: `null`) -}
rangeEnd :
    String
    -> Builder { a | rangeEnd : M3e.Build.Internal.Available } s msg
    -> Builder { a | rangeEnd : M3e.Build.Internal.Used } s msg
rangeEnd v_ (Builder f_) =
    Builder { f_ | rangeEnd = Just v_ }


{-| Start of a date range. (default: `null`) -}
rangeStart :
    String
    -> Builder { a | rangeStart : M3e.Build.Internal.Available } s msg
    -> Builder { a | rangeStart : M3e.Build.Internal.Used } s msg
rangeStart v_ (Builder f_) =
    Builder { f_ | rangeStart = Just v_ }


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`) -}
startAt :
    String
    -> Builder { a | startAt : M3e.Build.Internal.Available } s msg
    -> Builder { a | startAt : M3e.Build.Internal.Used } s msg
startAt v_ (Builder f_) =
    Builder { f_ | startAt = Just v_ }


{-| The initial view used to select a date. (default: `"month"`) -}
startView :
    M3e.Value.Value { month : M3e.Value.Supported
    , multiYear : M3e.Value.Supported
    , year : M3e.Value.Supported
    }
    -> Builder { a | startView : M3e.Build.Internal.Available } s msg
    -> Builder { a | startView : M3e.Build.Internal.Used } s msg
startView v_ (Builder f_) =
    Builder { f_ | startView = Just v_ }


{-| The accessible label given to the button used to move to the previous month. (default: `"Previous month"`) -}
previousMonthLabel :
    String
    -> Builder { a | previousMonthLabel : M3e.Build.Internal.Available } s msg
    -> Builder { a | previousMonthLabel : M3e.Build.Internal.Used } s msg
previousMonthLabel v_ (Builder f_) =
    Builder { f_ | previousMonthLabel = Just v_ }


{-| The accessible label given to the button used to move to the next month. (default: `"Next month"`) -}
nextMonthLabel :
    String
    -> Builder { a | nextMonthLabel : M3e.Build.Internal.Available } s msg
    -> Builder { a | nextMonthLabel : M3e.Build.Internal.Used } s msg
nextMonthLabel v_ (Builder f_) =
    Builder { f_ | nextMonthLabel = Just v_ }


{-| The accessible label given to the button used to move to the previous year. (default: `"Previous year"`) -}
previousYearLabel :
    String
    -> Builder { a | previousYearLabel : M3e.Build.Internal.Available } s msg
    -> Builder { a | previousYearLabel : M3e.Build.Internal.Used } s msg
previousYearLabel v_ (Builder f_) =
    Builder { f_ | previousYearLabel = Just v_ }


{-| The accessible label given to the button used to move to the next year. (default: `"Next year"`) -}
nextYearLabel :
    String
    -> Builder { a | nextYearLabel : M3e.Build.Internal.Available } s msg
    -> Builder { a | nextYearLabel : M3e.Build.Internal.Used } s msg
nextYearLabel v_ (Builder f_) =
    Builder { f_ | nextYearLabel = Just v_ }


{-| The accessible label given to the button used to move to the previous 24 years. (default: `"Previous 24 years"`) -}
previousMultiYearLabel :
    String
    -> Builder { a
        | previousMultiYearLabel : M3e.Build.Internal.Available
    } s msg
    -> Builder { a | previousMultiYearLabel : M3e.Build.Internal.Used } s msg
previousMultiYearLabel v_ (Builder f_) =
    Builder { f_ | previousMultiYearLabel = Just v_ }


{-| The accessible label given to the button used to move to the next 24 years. (default: `"Next 24 years"`) -}
nextMultiYearLabel :
    String
    -> Builder { a | nextMultiYearLabel : M3e.Build.Internal.Available } s msg
    -> Builder { a | nextMultiYearLabel : M3e.Build.Internal.Used } s msg
nextMultiYearLabel v_ (Builder f_) =
    Builder { f_ | nextMultiYearLabel = Just v_ }


{-| The label given to the button used clear the selected date and close the picker. (default: `"Clear"`) -}
clearLabel :
    String
    -> Builder { a | clearLabel : M3e.Build.Internal.Available } s msg
    -> Builder { a | clearLabel : M3e.Build.Internal.Used } s msg
clearLabel v_ (Builder f_) =
    Builder { f_ | clearLabel = Just v_ }


{-| The label given to the button used apply the selected date and close the picker. (default: `"OK"`) -}
confirmLabel :
    String
    -> Builder { a | confirmLabel : M3e.Build.Internal.Available } s msg
    -> Builder { a | confirmLabel : M3e.Build.Internal.Used } s msg
confirmLabel v_ (Builder f_) =
    Builder { f_ | confirmLabel = Just v_ }


{-| The label given to the button used discard the selected date and close the picker. (default: `"Cancel"`) -}
dismissLabel :
    String
    -> Builder { a | dismissLabel : M3e.Build.Internal.Available } s msg
    -> Builder { a | dismissLabel : M3e.Build.Internal.Used } s msg
dismissLabel v_ (Builder f_) =
    Builder { f_ | dismissLabel = Just v_ }


{-| The label given to the the picker. (default: `"Select date"`) -}
label :
    String
    -> Builder { a | label : M3e.Build.Internal.Available } s msg
    -> Builder { a | label : M3e.Build.Internal.Used } s msg
label v_ (Builder f_) =
    Builder { f_ | label = Just v_ }


{-| Dispatched when the selected date changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg
onChange v_ (Builder f_) =
    Builder { f_ | onChange = Just v_ }


{-| Dispatched before the toggle state changes. -}
onBeforetoggle :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforetoggle : M3e.Build.Internal.Available } s msg
    -> Builder { a | onBeforetoggle : M3e.Build.Internal.Used } s msg
onBeforetoggle v_ (Builder f_) =
    Builder { f_ | onBeforetoggle = Just v_ }


{-| Dispatched after the toggle state has changed. -}
onToggle :
    Json.Decode.Decoder msg
    -> Builder { a | onToggle : M3e.Build.Internal.Available } s msg
    -> Builder { a | onToggle : M3e.Build.Internal.Used } s msg
onToggle v_ (Builder f_) =
    Builder { f_ | onToggle = Just v_ }


{-| Build the `<m3e-datepicker>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind | datepicker : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Datepicker.datepicker
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Datepicker.variant v_)
                            ]
                         )
                         f_.variant
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Datepicker.clearable v_)
                            ]
                         )
                         f_.clearable
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Datepicker.date v_) ]
                         )
                         f_.date
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Datepicker.maxDate v_)
                            ]
                         )
                         f_.maxDate
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Datepicker.minDate v_)
                            ]
                         )
                         f_.minDate
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Datepicker.range v_)
                            ]
                         )
                         f_.range
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Datepicker.rangeEnd v_)
                            ]
                         )
                         f_.rangeEnd
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Datepicker.rangeStart v_)
                            ]
                         )
                         f_.rangeStart
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Datepicker.startAt v_)
                            ]
                         )
                         f_.startAt
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Datepicker.startView v_)
                            ]
                         )
                         f_.startView
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Datepicker.previousMonthLabel v_)
                            ]
                         )
                         f_.previousMonthLabel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Datepicker.nextMonthLabel v_)
                            ]
                         )
                         f_.nextMonthLabel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Datepicker.previousYearLabel v_)
                            ]
                         )
                         f_.previousYearLabel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Datepicker.nextYearLabel v_)
                            ]
                         )
                         f_.nextYearLabel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Datepicker.previousMultiYearLabel v_)
                            ]
                         )
                         f_.previousMultiYearLabel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Datepicker.nextMultiYearLabel v_)
                            ]
                         )
                         f_.nextMultiYearLabel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Datepicker.clearLabel v_)
                            ]
                         )
                         f_.clearLabel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Datepicker.confirmLabel v_)
                            ]
                         )
                         f_.confirmLabel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Datepicker.dismissLabel v_)
                            ]
                         )
                         f_.dismissLabel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Datepicker.label v_)
                            ]
                         )
                         f_.label
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.Datepicker.onChange
                                   v_
                                )
                            ]
                         )
                         f_.onChange
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.Datepicker.onBeforetoggle
                                   v_
                                )
                            ]
                         )
                         f_.onBeforetoggle
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.Datepicker.onToggle
                                   v_
                                )
                            ]
                         )
                         f_.onToggle
                      )
                  ]
             )
             (List.concat [])
        )