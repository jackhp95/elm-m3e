module M3e.Build.StepPanel exposing ( Builder, AttrCaps, SlotCaps, stepPanel )

{-|
The ⑤ Build shape for `<m3e-step-panel>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.StepPanel as StepPanel`.

@docs Builder, AttrCaps, SlotCaps, stepPanel
-}


import M3e.Element


{-| Opaque builder for `<m3e-step-panel>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { default : Maybe (M3e.Element.Element {} msg)
    , actions : Maybe (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-step-panel>`. -}
stepPanel : Builder AttrCaps SlotCaps msg
stepPanel =
    Builder { default = Nothing, actions = Nothing, phantomMsg_ = Nothing }