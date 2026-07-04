module M3e.Build.StepperPrevious exposing ( Builder, AttrCaps, SlotCaps, stepperPrevious )

{-|
The ⑤ Build shape for `<m3e-stepper-previous>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.StepperPrevious as StepperPrevious`.

@docs Builder, AttrCaps, SlotCaps, stepperPrevious
-}


import M3e.Element


{-| Opaque builder for `<m3e-stepper-previous>`; see `.build` for the terminal. -}
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


{-| Seed a `Builder` for `<m3e-stepper-previous>`. -}
stepperPrevious : Builder AttrCaps SlotCaps msg
stepperPrevious =
    Builder { default = Nothing }