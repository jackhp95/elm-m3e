module M3e.Build.TextOverflow exposing ( Builder, AttrCaps, SlotCaps, textOverflow )

{-|
The ⑤ Build shape for `<m3e-text-overflow>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.TextOverflow as TextOverflow`.

@docs Builder, AttrCaps, SlotCaps, textOverflow
-}


import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-text-overflow>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { default : Maybe (M3e.Element.Element { text : M3e.Value.Supported } msg) }


{-| Seed a `Builder` for `<m3e-text-overflow>`. -}
textOverflow : Builder AttrCaps SlotCaps msg
textOverflow =
    Builder { default = Nothing }