module M3e.Build.ChipSet exposing ( Builder, AttrCaps, SlotCaps, chipSet )

{-|
The ⑤ Build shape for `<m3e-chip-set>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ChipSet as ChipSet`.

@docs Builder, AttrCaps, SlotCaps, chipSet
-}


import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-chip-set>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { vertical : Maybe Bool
    , default :
        List (M3e.Element.Element { assistChip : M3e.Value.Supported
        , chip : M3e.Value.Supported
        , filterChip : M3e.Value.Supported
        , inputChip : M3e.Value.Supported
        , suggestionChip : M3e.Value.Supported
        } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-chip-set>`. -}
chipSet : Builder AttrCaps SlotCaps msg
chipSet =
    Builder { vertical = Nothing, default = [], phantomMsg_ = Nothing }