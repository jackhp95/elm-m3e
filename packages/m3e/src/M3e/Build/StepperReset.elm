module M3e.Build.StepperReset exposing
    ( Builder, AttrCaps, SlotCaps, stepperReset, build
    )

{-|
The ⑤ Build shape for `<m3e-stepper-reset>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.StepperReset as StepperReset`.

@docs Builder, AttrCaps, SlotCaps, stepperReset, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.StepperReset
import M3e.Element
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
    { unnamed : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-stepper-reset>`. -}
stepperReset : Builder AttrCaps SlotCaps msg kind
stepperReset =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.StepperReset.stepperReset
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Build the `<m3e-stepper-reset>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { stepperReset : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)