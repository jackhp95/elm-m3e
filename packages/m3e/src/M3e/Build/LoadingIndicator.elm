module M3e.Build.LoadingIndicator exposing ( Builder, AttrCaps, SlotCaps, loadingIndicator )

{-|
The ⑤ Build shape for `<m3e-loading-indicator>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.LoadingIndicator as LoadingIndicator`.

@docs Builder, AttrCaps, SlotCaps, loadingIndicator
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-loading-indicator>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | loadingIndicator : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { variant : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-loading-indicator>`. -}
loadingIndicator : Builder AttrCaps SlotCaps msg kind
loadingIndicator =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")