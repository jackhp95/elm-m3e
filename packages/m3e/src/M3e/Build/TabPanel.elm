module M3e.Build.TabPanel exposing ( Builder, AttrCaps, SlotCaps, tabPanel )

{-|
The ⑤ Build shape for `<m3e-tab-panel>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.TabPanel as TabPanel`.

@docs Builder, AttrCaps, SlotCaps, tabPanel
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-tab-panel>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | tabPanel : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-tab-panel>`. -}
tabPanel : Builder AttrCaps SlotCaps msg kind
tabPanel =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")