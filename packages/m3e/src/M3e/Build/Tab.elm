module M3e.Build.Tab exposing ( Builder, AttrCaps, SlotCaps, tab )

{-|
The ⑤ Build shape for `<m3e-tab>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Tab as Tab`.

@docs Builder, AttrCaps, SlotCaps, tab
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-tab>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | tab : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    , selected : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available
    , icon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-tab>`. -}
tab : Builder AttrCaps SlotCaps msg kind
tab =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")