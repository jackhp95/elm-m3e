module M3e.Build.YearView exposing
    ( Builder, AttrCaps, SlotCaps, yearView, active, today
    , date, activeDate, minDate, maxDate, onChange, onActiveChange, build
    )

{-|
The ⑤ Build shape for `<m3e-year-view>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.YearView as YearView`.

@docs Builder, AttrCaps, SlotCaps, yearView, active, today
@docs date, activeDate, minDate, maxDate, onChange, onActiveChange
@docs build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.YearView
import M3e.Cem.YearView
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-year-view>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { active : M3e.Build.Internal.Available
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
    { active : Maybe Bool
    , today : Maybe String
    , date : Maybe String
    , activeDate : Maybe String
    , minDate : Maybe String
    , maxDate : Maybe String
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onActiveChange : Maybe (Json.Decode.Decoder msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-year-view>`. -}
yearView : Builder AttrCaps SlotCaps msg
yearView =
    Builder
        { active = Nothing
        , today = Nothing
        , date = Nothing
        , activeDate = Nothing
        , minDate = Nothing
        , maxDate = Nothing
        , onChange = Nothing
        , onActiveChange = Nothing
        , phantomMsg_ = Nothing
        }


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


{-| Build the `<m3e-year-view>` element from a `Builder`. -}
build :
    Builder a {} msg
    -> M3e.Element.Element { kind | yearView : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.YearView.yearView
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.YearView.active v_) ]
                         )
                         f_.active
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.YearView.today v_) ]
                         )
                         f_.today
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.YearView.date v_) ]
                         )
                         f_.date
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.YearView.activeDate v_)
                            ]
                         )
                         f_.activeDate
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.YearView.minDate v_)
                            ]
                         )
                         f_.minDate
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.YearView.maxDate v_)
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
                                   M3e.Cem.Html.YearView.onChange
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
                                   M3e.Cem.Html.YearView.onActiveChange
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