module M3e.Build.StepPanel exposing
    ( Builder, AttrCaps, SlotCaps, stepPanel, build
    )

{-|
The ⑤ Build shape for `<m3e-step-panel>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.StepPanel as StepPanel`.

@docs Builder, AttrCaps, SlotCaps, stepPanel, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.StepPanel
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-step-panel>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | stepPanel : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.Available
    , actions : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-step-panel>`. -}
stepPanel : Builder AttrCaps SlotCaps msg kind
stepPanel =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.StepPanel.stepPanel
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Build the `<m3e-step-panel>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { stepPanel : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)