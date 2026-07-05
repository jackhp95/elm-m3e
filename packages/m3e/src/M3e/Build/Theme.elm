module M3e.Build.Theme exposing ( Builder, AttrCaps, SlotCaps, theme )

{-|
The ⑤ Build shape for `<m3e-theme>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Theme as Theme`.

@docs Builder, AttrCaps, SlotCaps, theme
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-theme>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | theme : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { color : M3e.Build.Internal.Available
    , contrast : M3e.Build.Internal.Available
    , density : M3e.Build.Internal.Available
    , scheme : M3e.Build.Internal.Available
    , strongFocus : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    , motion : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-theme>`. -}
theme : Builder AttrCaps SlotCaps msg kind
theme =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")