module M3e.Build.StateLayer exposing ( Builder, AttrCaps, SlotCaps, stateLayer )

{-|
The ⑤ Build shape for `<m3e-state-layer>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.StateLayer as StateLayer`.

@docs Builder, AttrCaps, SlotCaps, stateLayer
-}



{-| Opaque builder for `<m3e-state-layer>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields =
    { disabled : Maybe Bool, disableHover : Maybe Bool, for : Maybe String }


{-| Seed a `Builder` for `<m3e-state-layer>`. -}
stateLayer : Builder AttrCaps SlotCaps msg
stateLayer =
    Builder { disabled = Nothing, disableHover = Nothing, for = Nothing }