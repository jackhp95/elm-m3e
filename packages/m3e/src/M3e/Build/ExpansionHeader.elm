module M3e.Build.ExpansionHeader exposing ( Builder, AttrCaps, SlotCaps, expansionHeader )

{-|
The ⑤ Build shape for `<m3e-expansion-header>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ExpansionHeader as ExpansionHeader`.

@docs Builder, AttrCaps, SlotCaps, expansionHeader
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-expansion-header>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | expansionHeader : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { hideToggle : M3e.Build.Internal.Available
    , toggleDirection : M3e.Build.Internal.Available
    , togglePosition : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available
    , toggleIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-expansion-header>`. -}
expansionHeader : Builder AttrCaps SlotCaps msg kind
expansionHeader =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")