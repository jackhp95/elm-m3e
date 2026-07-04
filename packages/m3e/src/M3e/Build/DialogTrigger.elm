module M3e.Build.DialogTrigger exposing ( Builder, AttrCaps, SlotCaps, dialogTrigger )

{-|
The ⑤ Build shape for `<m3e-dialog-trigger>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.DialogTrigger as DialogTrigger`.

@docs Builder, AttrCaps, SlotCaps, dialogTrigger
-}


import M3e.Element


{-| Opaque builder for `<m3e-dialog-trigger>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg any_ =
    { for : Maybe String, default : Maybe (M3e.Element.Element any_ msg) }


{-| Seed a `Builder` for `<m3e-dialog-trigger>`. -}
dialogTrigger : Builder AttrCaps SlotCaps msg
dialogTrigger =
    Builder { for = Nothing, default = Nothing }