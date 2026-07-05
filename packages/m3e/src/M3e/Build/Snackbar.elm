module M3e.Build.Snackbar exposing ( Builder, AttrCaps, SlotCaps, snackbar )

{-|
The ⑤ Build shape for `<m3e-snackbar>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Snackbar as Snackbar`.

@docs Builder, AttrCaps, SlotCaps, snackbar
-}


import M3e.Build.Internal
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-snackbar>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | snackbar : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { action : M3e.Build.Internal.Available
    , closeLabel : M3e.Build.Internal.Available
    , dismissible : M3e.Build.Internal.Available
    , duration : M3e.Build.Internal.Available
    , onBeforetoggle : M3e.Build.Internal.Available
    , onToggle : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { closeIcon : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-snackbar>` with the required fields. -}
snackbar :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> Builder AttrCaps SlotCaps msg kind
snackbar req_ =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")