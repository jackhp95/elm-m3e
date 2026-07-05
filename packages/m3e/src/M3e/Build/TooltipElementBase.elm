module M3e.Build.TooltipElementBase exposing ( Builder, AttrCaps, SlotCaps, tooltipElementBase )

{-|
The ⑤ Build shape for `<TooltipElementBase>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.TooltipElementBase as TooltipElementBase`.

@docs Builder, AttrCaps, SlotCaps, tooltipElementBase
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<TooltipElementBase>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | tooltipElementBase : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , showDelay : M3e.Build.Internal.Available
    , hideDelay : M3e.Build.Internal.Available
    , touchGestures : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<TooltipElementBase>`. -}
tooltipElementBase : Builder AttrCaps SlotCaps msg kind
tooltipElementBase =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")