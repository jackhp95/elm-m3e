module M3e.Build.Breadcrumb exposing ( Builder, AttrCaps, SlotCaps, breadcrumb )

{-|
The ⑤ Build shape for `<m3e-breadcrumb>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Breadcrumb as Breadcrumb`.

@docs Builder, AttrCaps, SlotCaps, breadcrumb
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-breadcrumb>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | breadcrumb : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { wrap : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { separator : M3e.Build.Internal.Available
    , default : M3e.Build.Internal.NotFilled
    }


{-| Seed a `Builder` for `<m3e-breadcrumb>`. -}
breadcrumb : Builder AttrCaps SlotCaps msg kind
breadcrumb =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")