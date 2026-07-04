module M3e.Build.Optgroup exposing ( Builder, AttrCaps, SlotCaps, optgroup )

{-|
The ⑤ Build shape for `<m3e-optgroup>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Optgroup as Optgroup`.

@docs Builder, AttrCaps, SlotCaps, optgroup
-}


import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-optgroup>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { label : Maybe (M3e.Element.Element { text : M3e.Value.Supported } msg)
    , default : List (M3e.Element.Element { option : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-optgroup>`. -}
optgroup : Builder AttrCaps SlotCaps msg
optgroup =
    Builder { label = Nothing, default = [], phantomMsg_ = Nothing }