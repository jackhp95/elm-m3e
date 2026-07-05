module M3e.Build.ActionElementBase exposing ( Builder, AttrCaps, SlotCaps, actionElementBase )

{-|
The ⑤ Build shape for `<ActionElementBase>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ActionElementBase as ActionElementBase`.

@docs Builder, AttrCaps, SlotCaps, actionElementBase
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<ActionElementBase>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | actionElementBase : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<ActionElementBase>`. -}
actionElementBase : Builder AttrCaps SlotCaps msg kind
actionElementBase =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")