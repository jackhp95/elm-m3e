module M3e.Build.ExpandableListItem exposing ( Builder, AttrCaps, SlotCaps, expandableListItem )

{-|
The ⑤ Build shape for `<m3e-expandable-list-item>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ExpandableListItem as ExpandableListItem`.

@docs Builder, AttrCaps, SlotCaps, expandableListItem
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-expandable-list-item>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | expandableListItem : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , open : M3e.Build.Internal.Available
    , onOpening : M3e.Build.Internal.Available
    , onOpened : M3e.Build.Internal.Available
    , onClosing : M3e.Build.Internal.Available
    , onClosed : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available
    , leading : M3e.Build.Internal.Available
    , overline : M3e.Build.Internal.Available
    , supportingText : M3e.Build.Internal.Available
    , toggleIcon : M3e.Build.Internal.Available
    , items : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-expandable-list-item>`. -}
expandableListItem : Builder AttrCaps SlotCaps msg kind
expandableListItem =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")