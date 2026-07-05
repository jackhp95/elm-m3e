module M3e.Build.Stepper exposing ( Builder, AttrCaps, SlotCaps, stepper )

{-|
The ⑤ Build shape for `<m3e-stepper>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Stepper as Stepper`.

@docs Builder, AttrCaps, SlotCaps, stepper
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-stepper>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | stepper : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { headerPosition : M3e.Build.Internal.Available
    , labelPosition : M3e.Build.Internal.Available
    , linear : M3e.Build.Internal.Available
    , orientation : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-stepper>`. -}
stepper : Builder AttrCaps SlotCaps msg kind
stepper =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")