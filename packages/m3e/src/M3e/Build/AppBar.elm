module M3e.Build.AppBar exposing ( Builder, AttrCaps, SlotCaps, appBar )

{-|
The ⑤ Build shape for `<m3e-app-bar>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.AppBar as AppBar`.

@docs Builder, AttrCaps, SlotCaps, appBar
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-app-bar>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | appBar : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { centered : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    , size : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { leading : M3e.Build.Internal.Available
    , title : M3e.Build.Internal.Available
    , subtitle : M3e.Build.Internal.Available
    , leadingIcon : M3e.Build.Internal.Available
    , trailingIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-app-bar>`. -}
appBar : Builder AttrCaps SlotCaps msg kind
appBar =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")