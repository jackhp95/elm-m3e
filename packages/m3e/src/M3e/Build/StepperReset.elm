module M3e.Build.StepperReset exposing ( Builder, AttrCaps, SlotCaps, stepperReset )

{-|
The ⑤ Build shape for `<m3e-stepper-reset>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.StepperReset as StepperReset`.

@docs Builder, AttrCaps, SlotCaps, stepperReset
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-stepper-reset>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | stepperReset : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-stepper-reset>`. -}
stepperReset : Builder AttrCaps SlotCaps msg kind
stepperReset =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")