module M3e.Build.MultiYearView exposing
    ( Builder, AttrCaps, SlotCaps, multiYearView, active, today
    , date, activeDate, minDate, maxDate, onChange, onActiveChange
    )

{-|
The ⑤ Build shape for `<m3e-multi-year-view>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.MultiYearView as MultiYearView`.

@docs Builder, AttrCaps, SlotCaps, multiYearView, active, today
@docs date, activeDate, minDate, maxDate, onChange, onActiveChange
-}


import Json.Decode
import M3e.Build.Internal


{-| Opaque builder for `<m3e-multi-year-view>`; see `.build` for the terminal. -}
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


{-| Seed a `Builder` for `<m3e-multi-year-view>`. -}
multiYearView : Builder AttrCaps SlotCaps msg
multiYearView =
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