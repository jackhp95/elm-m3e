module M3e.Build.Icon exposing ( Builder, AttrCaps, SlotCaps, icon )

{-|
The ⑤ Build shape for `<m3e-icon>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Icon as Icon`.

@docs Builder, AttrCaps, SlotCaps, icon
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-icon>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | icon : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { filled : M3e.Build.Internal.Available
    , grade : M3e.Build.Internal.Available
    , opticalSize : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    , weight : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-icon>`. -}
icon : Builder AttrCaps SlotCaps msg kind
icon =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")