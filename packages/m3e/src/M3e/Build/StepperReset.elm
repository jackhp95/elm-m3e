module M3e.Build.StepperReset exposing ( Builder, AttrCaps, SlotCaps, stepperReset )

{-|
The ⑤ Build shape for `<m3e-stepper-reset>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.StepperReset as StepperReset`.

@docs Builder, AttrCaps, SlotCaps, stepperReset
-}


import M3e.Element


{-| Opaque builder for `<m3e-stepper-reset>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg any_ =
    { default : Maybe (M3e.Element.Element any_ msg) }


{-| Seed a `Builder` for `<m3e-stepper-reset>`. -}
stepperReset : Builder AttrCaps SlotCaps msg
stepperReset =
    Builder { default = Nothing }