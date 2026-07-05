module M3e.Build.BottomSheet exposing ( Builder, AttrCaps, SlotCaps, bottomSheet )

{-|
The ⑤ Build shape for `<m3e-bottom-sheet>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.BottomSheet as BottomSheet`.

@docs Builder, AttrCaps, SlotCaps, bottomSheet
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-bottom-sheet>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | bottomSheet : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { detent : M3e.Build.Internal.Available
    , handle : M3e.Build.Internal.Available
    , handleLabel : M3e.Build.Internal.Available
    , hideable : M3e.Build.Internal.Available
    , hideFriction : M3e.Build.Internal.Available
    , modal : M3e.Build.Internal.Available
    , open : M3e.Build.Internal.Available
    , overshootLimit : M3e.Build.Internal.Available
    , onOpening : M3e.Build.Internal.Available
    , onClosing : M3e.Build.Internal.Available
    , onCancel : M3e.Build.Internal.Available
    , onOpened : M3e.Build.Internal.Available
    , onClosed : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { header : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-bottom-sheet>`. -}
bottomSheet : Builder AttrCaps SlotCaps msg kind
bottomSheet =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")