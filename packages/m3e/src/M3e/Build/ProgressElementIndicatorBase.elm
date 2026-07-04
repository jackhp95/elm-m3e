module M3e.Build.ProgressElementIndicatorBase exposing ( Builder, AttrCaps, SlotCaps, progressElementIndicatorBase )

{-|
The ⑤ Build shape for `<ProgressElementIndicatorBase>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ProgressElementIndicatorBase as ProgressElementIndicatorBase`.

@docs Builder, AttrCaps, SlotCaps, progressElementIndicatorBase
-}


import M3e.Value


{-| Opaque builder for `<ProgressElementIndicatorBase>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields =
    { value : Maybe Float
    , max : Maybe Float
    , variant :
        Maybe (M3e.Value.Value { flat : M3e.Value.Supported
        , wavy : M3e.Value.Supported
        })
    }


{-| Seed a `Builder` for `<ProgressElementIndicatorBase>`. -}
progressElementIndicatorBase : Builder AttrCaps SlotCaps msg
progressElementIndicatorBase =
    Builder { value = Nothing, max = Nothing, variant = Nothing }