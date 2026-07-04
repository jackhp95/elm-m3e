module M3e.Build.Elevation exposing ( Builder, AttrCaps, SlotCaps, elevation )

{-|
The ⑤ Build shape for `<m3e-elevation>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Elevation as Elevation`.

@docs Builder, AttrCaps, SlotCaps, elevation
-}



{-| Opaque builder for `<m3e-elevation>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields =
    { disabled : Maybe Bool, for : Maybe String, level : Maybe String }


{-| Seed a `Builder` for `<m3e-elevation>`. -}
elevation : Builder AttrCaps SlotCaps msg
elevation =
    Builder { disabled = Nothing, for = Nothing, level = Nothing }