module M3e.Build.Accordion exposing ( Builder, AttrCaps, SlotCaps, accordion )

{-|
The ⑤ Build shape for `<m3e-accordion>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Accordion as Accordion`.

@docs Builder, AttrCaps, SlotCaps, accordion
-}


import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-accordion>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { multi : Maybe Bool
    , default :
        List (M3e.Element.Element { expansionPanel : M3e.Value.Supported } msg)
    }


{-| Seed a `Builder` for `<m3e-accordion>`. -}
accordion : Builder AttrCaps SlotCaps msg
accordion =
    Builder { multi = Nothing, default = [] }