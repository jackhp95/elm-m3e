module M3e.Build.ProgressElementIndicatorBase exposing
    ( Builder, AttrCaps, SlotCaps, progressElementIndicatorBase, value, max
    , variant
    )

{-|
The ⑤ Build shape for `<ProgressElementIndicatorBase>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ProgressElementIndicatorBase as ProgressElementIndicatorBase`.

@docs Builder, AttrCaps, SlotCaps, progressElementIndicatorBase, value, max
@docs variant
-}


import M3e.Build.Internal
import M3e.Value


{-| Opaque builder for `<ProgressElementIndicatorBase>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { value : M3e.Build.Internal.Available
    , max : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { value : Maybe Float
    , max : Maybe Float
    , variant :
        Maybe (M3e.Value.Value { flat : M3e.Value.Supported
        , wavy : M3e.Value.Supported
        })
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<ProgressElementIndicatorBase>`. -}
progressElementIndicatorBase : Builder AttrCaps SlotCaps msg
progressElementIndicatorBase =
    Builder
        { value = Nothing
        , max = Nothing
        , variant = Nothing
        , phantomMsg_ = Nothing
        }


{-| A fractional value, between 0 and `max`, indicating progress. (default: `0`) -}
value :
    Float
    -> Builder { a | value : M3e.Build.Internal.Available } s msg
    -> Builder { a | value : M3e.Build.Internal.Used } s msg
value v_ (Builder f_) =
    Builder { f_ | value = Just v_ }


{-| The maximum progress value. (default: `100`) -}
max :
    Float
    -> Builder { a | max : M3e.Build.Internal.Available } s msg
    -> Builder { a | max : M3e.Build.Internal.Used } s msg
max v_ (Builder f_) =
    Builder { f_ | max = Just v_ }


{-| The appearance of the indicator. (default: `"flat"`) -}
variant :
    M3e.Value.Value { flat : M3e.Value.Supported, wavy : M3e.Value.Supported }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg
variant v_ (Builder f_) =
    Builder { f_ | variant = Just v_ }