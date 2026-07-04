module M3e.Build.MonthView exposing
    ( Builder, AttrCaps, SlotCaps, monthView, rangeStart, rangeEnd
    , active, today, date, activeDate, minDate, maxDate, onChange
    , onActiveChange, build
    )

{-|
The ⑤ Build shape for `<m3e-month-view>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.MonthView as MonthView`.

@docs Builder, AttrCaps, SlotCaps, monthView, rangeStart, rangeEnd
@docs active, today, date, activeDate, minDate, maxDate
@docs onChange, onActiveChange, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.MonthView
import M3e.Cem.MonthView
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-month-view>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { rangeStart : M3e.Build.Internal.Available
    , rangeEnd : M3e.Build.Internal.Available
    , active : M3e.Build.Internal.Available
    , today : M3e.Build.Internal.Available
    , date : M3e.Build.Internal.Available
    , activeDate : M3e.Build.Internal.Available
    , minDate : M3e.Build.Internal.Available
    , maxDate : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onActiveChange : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { rangeStart : Maybe String
    , rangeEnd : Maybe String
    , active : Maybe Bool
    , today : Maybe String
    , date : Maybe String
    , activeDate : Maybe String
    , minDate : Maybe String
    , maxDate : Maybe String
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onActiveChange : Maybe (Json.Decode.Decoder msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-month-view>`. -}
monthView : Builder AttrCaps SlotCaps msg
monthView =
    Builder
        { rangeStart = Nothing
        , rangeEnd = Nothing
        , active = Nothing
        , today = Nothing
        , date = Nothing
        , activeDate = Nothing
        , minDate = Nothing
        , maxDate = Nothing
        , onChange = Nothing
        , onActiveChange = Nothing
        , phantomMsg_ = Nothing
        }


{-| Start of a date range. (default: `null`) -}
rangeStart :
    String
    -> Builder { a | rangeStart : M3e.Build.Internal.Available } s msg
    -> Builder { a | rangeStart : M3e.Build.Internal.Used } s msg
rangeStart v_ (Builder f_) =
    Builder { f_ | rangeStart = Just v_ }


{-| End of a date range. (default: `null`) -}
rangeEnd :
    String
    -> Builder { a | rangeEnd : M3e.Build.Internal.Available } s msg
    -> Builder { a | rangeEnd : M3e.Build.Internal.Used } s msg
rangeEnd v_ (Builder f_) =
    Builder { f_ | rangeEnd = Just v_ }


{-| Whether the view is active. (default: `false`) -}
active :
    Bool
    -> Builder { a | active : M3e.Build.Internal.Available } s msg
    -> Builder { a | active : M3e.Build.Internal.Used } s msg
active v_ (Builder f_) =
    Builder { f_ | active = Just v_ }


{-| Today's date. (default: `new Date()`) -}
today :
    String
    -> Builder { a | today : M3e.Build.Internal.Available } s msg
    -> Builder { a | today : M3e.Build.Internal.Used } s msg
today v_ (Builder f_) =
    Builder { f_ | today = Just v_ }


{-| The selected date. (default: `null`) -}
date :
    String
    -> Builder { a | date : M3e.Build.Internal.Available } s msg
    -> Builder { a | date : M3e.Build.Internal.Used } s msg
date v_ (Builder f_) =
    Builder { f_ | date = Just v_ }


{-| The active date. (default: `new Date()`) -}
activeDate :
    String
    -> Builder { a | activeDate : M3e.Build.Internal.Available } s msg
    -> Builder { a | activeDate : M3e.Build.Internal.Used } s msg
activeDate v_ (Builder f_) =
    Builder { f_ | activeDate = Just v_ }


{-| The minimum date that can be selected. (default: `null`) -}
minDate :
    String
    -> Builder { a | minDate : M3e.Build.Internal.Available } s msg
    -> Builder { a | minDate : M3e.Build.Internal.Used } s msg
minDate v_ (Builder f_) =
    Builder { f_ | minDate = Just v_ }


{-| The maximum date that can be selected. (default: `null`) -}
maxDate :
    String
    -> Builder { a | maxDate : M3e.Build.Internal.Available } s msg
    -> Builder { a | maxDate : M3e.Build.Internal.Used } s msg
maxDate v_ (Builder f_) =
    Builder { f_ | maxDate = Just v_ }


{-| onChange event handler. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg
onChange v_ (Builder f_) =
    Builder { f_ | onChange = Just v_ }


{-| onActiveChange event handler. -}
onActiveChange :
    Json.Decode.Decoder msg
    -> Builder { a | onActiveChange : M3e.Build.Internal.Available } s msg
    -> Builder { a | onActiveChange : M3e.Build.Internal.Used } s msg
onActiveChange v_ (Builder f_) =
    Builder { f_ | onActiveChange = Just v_ }


{-| Build the `<m3e-month-view>` element from a `Builder`. -}
build :
    Builder a s msg
    -> M3e.Element.Element { kind | monthView : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.MonthView.monthView
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.MonthView.rangeStart v_)
                            ]
                         )
                         f_.rangeStart
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.MonthView.rangeEnd v_)
                            ]
                         )
                         f_.rangeEnd
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.MonthView.active v_)
                            ]
                         )
                         f_.active
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.MonthView.today v_) ]
                         )
                         f_.today
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.MonthView.date v_) ]
                         )
                         f_.date
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.MonthView.activeDate v_)
                            ]
                         )
                         f_.activeDate
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.MonthView.minDate v_)
                            ]
                         )
                         f_.minDate
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.MonthView.maxDate v_)
                            ]
                         )
                         f_.maxDate
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.MonthView.onChange
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
                                   M3e.Cem.Html.MonthView.onActiveChange
                                   v_
                                )
                            ]
                         )
                         f_.onActiveChange
                      )
                  ]
             )
             (List.concat [])
        )