module M3e.Build.SelectionList exposing ( Builder, AttrCaps, SlotCaps, selectionList )

{-|
The ⑤ Build shape for `<m3e-selection-list>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SelectionList as SelectionList`.

@docs Builder, AttrCaps, SlotCaps, selectionList
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-selection-list>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | selectionList : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { hideSelectionIndicator : M3e.Build.Internal.Available
    , multi : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-selection-list>`. -}
selectionList : Builder AttrCaps SlotCaps msg kind
selectionList =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")