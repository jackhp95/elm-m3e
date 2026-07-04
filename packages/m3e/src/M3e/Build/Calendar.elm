module M3e.Build.Calendar exposing
    ( Builder, AttrCaps, SlotCaps, calendar, date, maxDate
    , minDate, rangeEnd, rangeStart, startAt, startView, previousMonthLabel, nextMonthLabel
    , previousYearLabel, nextYearLabel, previousMultiYearLabel, nextMultiYearLabel, onChange, header, build
    )

{-|
The ⑤ Build shape for `<m3e-calendar>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Calendar as Calendar`.

@docs Builder, AttrCaps, SlotCaps, calendar, date, maxDate
@docs minDate, rangeEnd, rangeStart, startAt, startView, previousMonthLabel
@docs nextMonthLabel, previousYearLabel, nextYearLabel, previousMultiYearLabel, nextMultiYearLabel, onChange
@docs header, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Calendar
import M3e.Cem.Html.Calendar
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-calendar>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


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


type alias Fields msg =
    { date : Maybe String
    , maxDate : Maybe String
    , minDate : Maybe String
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
    , onChange : Maybe (Json.Decode.Decoder msg)
    , header : Maybe (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-calendar>`. -}
calendar : Builder AttrCaps SlotCaps msg
calendar =
    Builder
        { date = Nothing
        , maxDate = Nothing
        , minDate = Nothing
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
        , onChange = Nothing
        , header = Nothing
        , phantomMsg_ = Nothing
        }


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


{-| Dispatched when the selected date changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg
onChange v_ (Builder f_) =
    Builder { f_ | onChange = Just v_ }


{-| Set the `header` slot. Consumes the `header` slot capability. -}
header :
    M3e.Element.Element {} msg
    -> Builder a { s | header : M3e.Build.Internal.Available } msg
    -> Builder a { s | header : M3e.Build.Internal.Used } msg
header v_ (Builder f_) =
    Builder { f_ | header = Just v_ }


{-| Build the `<m3e-calendar>` element from a `Builder`. -}
build :
    Builder a {} msg
    -> M3e.Element.Element { kind | calendar : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Calendar.calendar
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Calendar.date v_) ]
                         )
                         f_.date
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Calendar.maxDate v_)
                            ]
                         )
                         f_.maxDate
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Calendar.minDate v_)
                            ]
                         )
                         f_.minDate
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Calendar.rangeEnd v_)
                            ]
                         )
                         f_.rangeEnd
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Calendar.rangeStart v_)
                            ]
                         )
                         f_.rangeStart
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Calendar.startAt v_)
                            ]
                         )
                         f_.startAt
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Calendar.startView v_)
                            ]
                         )
                         f_.startView
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Calendar.previousMonthLabel v_)
                            ]
                         )
                         f_.previousMonthLabel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Calendar.nextMonthLabel v_)
                            ]
                         )
                         f_.nextMonthLabel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Calendar.previousYearLabel v_)
                            ]
                         )
                         f_.previousYearLabel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Calendar.nextYearLabel v_)
                            ]
                         )
                         f_.nextYearLabel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Calendar.previousMultiYearLabel v_)
                            ]
                         )
                         f_.previousMultiYearLabel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Calendar.nextMultiYearLabel v_)
                            ]
                         )
                         f_.nextMultiYearLabel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.Calendar.onChange
                                   v_
                                )
                            ]
                         )
                         f_.onChange
                      )
                  ]
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "header" v_)
                            ]
                         )
                         f_.header
                      )
                  ]
             )
        )