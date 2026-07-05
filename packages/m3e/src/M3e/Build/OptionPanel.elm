module M3e.Build.OptionPanel exposing ( Builder, AttrCaps, SlotCaps, optionPanel )

{-|
The ⑤ Build shape for `<m3e-option-panel>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.OptionPanel as OptionPanel`.

@docs Builder, AttrCaps, SlotCaps, optionPanel
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-option-panel>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | optionPanel : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { state : M3e.Build.Internal.Available
    , scrollStrategy : M3e.Build.Internal.Available
    , fitAnchorWidth : M3e.Build.Internal.Available
    , anchorOffset : M3e.Build.Internal.Available
    , onBeforetoggle : M3e.Build.Internal.Available
    , onToggle : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { noData : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-option-panel>`. -}
optionPanel : Builder AttrCaps SlotCaps msg kind
optionPanel =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")