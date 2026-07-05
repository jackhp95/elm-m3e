module M3e.Build.Tree exposing ( Builder, AttrCaps, SlotCaps, tree )

{-|
The ⑤ Build shape for `<m3e-tree>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Tree as Tree`.

@docs Builder, AttrCaps, SlotCaps, tree
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-tree>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | tree : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { multi : M3e.Build.Internal.Available
    , cascade : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-tree>`. -}
tree : Builder AttrCaps SlotCaps msg kind
tree =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")