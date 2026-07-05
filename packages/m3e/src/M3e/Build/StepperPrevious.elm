module M3e.Build.StepperPrevious exposing ( Builder, AttrCaps, SlotCaps, stepperPrevious )

{-|
The ⑤ Build shape for `<m3e-stepper-previous>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.StepperPrevious as StepperPrevious`.

@docs Builder, AttrCaps, SlotCaps, stepperPrevious
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.StepperPrevious
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-stepper-previous>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | stepperPrevious : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-stepper-previous>`. -}
stepperPrevious : Builder AttrCaps SlotCaps msg kind
stepperPrevious =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.StepperPrevious.stepperPrevious
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )