module M3e.Build.BottomSheetAction exposing ( Builder, AttrCaps, SlotCaps, bottomSheetAction )

{-|
The ⑤ Build shape for `<m3e-bottom-sheet-action>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.BottomSheetAction as BottomSheetAction`.

@docs Builder, AttrCaps, SlotCaps, bottomSheetAction
-}


import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-bottom-sheet-action>`; see `.build` for the terminal. -}
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


{-| Seed a `Builder` for `<m3e-bottom-sheet-action>`. -}
bottomSheetAction : Builder AttrCaps SlotCaps msg
bottomSheetAction =
    Builder { default = Nothing }