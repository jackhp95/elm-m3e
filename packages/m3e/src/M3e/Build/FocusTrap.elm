module M3e.Build.FocusTrap exposing ( Builder, AttrCaps, SlotCaps, focusTrap )

{-|
The ⑤ Build shape for `<m3e-focus-trap>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.FocusTrap as FocusTrap`.

@docs Builder, AttrCaps, SlotCaps, focusTrap
-}


import M3e.Element


{-| Opaque builder for `<m3e-focus-trap>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg any_ =
    { disabled : Maybe Bool, default : List (M3e.Element.Element any_ msg) }


{-| Seed a `Builder` for `<m3e-focus-trap>`. -}
focusTrap : Builder AttrCaps SlotCaps msg
focusTrap =
    Builder { disabled = Nothing, default = [] }