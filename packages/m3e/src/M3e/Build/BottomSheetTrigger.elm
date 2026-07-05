module M3e.Build.BottomSheetTrigger exposing ( Builder, AttrCaps, SlotCaps, bottomSheetTrigger )

{-|
The ⑤ Build shape for `<m3e-bottom-sheet-trigger>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.BottomSheetTrigger as BottomSheetTrigger`.

@docs Builder, AttrCaps, SlotCaps, bottomSheetTrigger
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-bottom-sheet-trigger>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | bottomSheetTrigger : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { detent : M3e.Build.Internal.Available
    , secondary : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-bottom-sheet-trigger>`. -}
bottomSheetTrigger : Builder AttrCaps SlotCaps msg kind
bottomSheetTrigger =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")