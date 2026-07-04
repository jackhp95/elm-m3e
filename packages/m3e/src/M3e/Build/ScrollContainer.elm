module M3e.Build.ScrollContainer exposing ( Builder, AttrCaps, SlotCaps, scrollContainer )

{-|
The ⑤ Build shape for `<m3e-scroll-container>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ScrollContainer as ScrollContainer`.

@docs Builder, AttrCaps, SlotCaps, scrollContainer
-}


import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-scroll-container>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg any_ =
    { dividers :
        Maybe (M3e.Value.Value { above : M3e.Value.Supported
        , aboveBelow : M3e.Value.Supported
        , below : M3e.Value.Supported
        , none : M3e.Value.Supported
        })
    , thin : Maybe Bool
    , default : List (M3e.Element.Element any_ msg)
    }


{-| Seed a `Builder` for `<m3e-scroll-container>`. -}
scrollContainer : Builder AttrCaps SlotCaps msg
scrollContainer =
    Builder { dividers = Nothing, thin = Nothing, default = [] }