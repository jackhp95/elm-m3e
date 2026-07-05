module M3e.Build.ListAction exposing ( Builder, AttrCaps, SlotCaps, listAction )

{-|
The ⑤ Build shape for `<m3e-list-action>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ListAction as ListAction`.

@docs Builder, AttrCaps, SlotCaps, listAction
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-list-action>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | listAction : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , download : M3e.Build.Internal.Available
    , href : M3e.Build.Internal.Available
    , rel : M3e.Build.Internal.Available
    , target : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available
    , leading : M3e.Build.Internal.Available
    , overline : M3e.Build.Internal.Available
    , supportingText : M3e.Build.Internal.Available
    , trailing : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-list-action>`. -}
listAction : Builder AttrCaps SlotCaps msg kind
listAction =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")