module M3e.Build.DialogAction exposing ( Builder, AttrCaps, SlotCaps, dialogAction )

{-|
The ⑤ Build shape for `<m3e-dialog-action>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.DialogAction as DialogAction`.

@docs Builder, AttrCaps, SlotCaps, dialogAction
-}


import M3e.Element


{-| Opaque builder for `<m3e-dialog-action>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg any_ =
    { returnValue : Maybe String
    , default : Maybe (M3e.Element.Element any_ msg)
    }


{-| Seed a `Builder` for `<m3e-dialog-action>`. -}
dialogAction : Builder AttrCaps SlotCaps msg
dialogAction =
    Builder { returnValue = Nothing, default = Nothing }