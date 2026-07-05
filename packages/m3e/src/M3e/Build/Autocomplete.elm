module M3e.Build.Autocomplete exposing ( Builder, AttrCaps, SlotCaps, autocomplete )

{-|
The ⑤ Build shape for `<m3e-autocomplete>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Autocomplete as Autocomplete`.

@docs Builder, AttrCaps, SlotCaps, autocomplete
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-autocomplete>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | autocomplete : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { autoActivate : M3e.Build.Internal.Available
    , caseSensitive : M3e.Build.Internal.Available
    , hideSelectionIndicator : M3e.Build.Internal.Available
    , hideLoading : M3e.Build.Internal.Available
    , hideNoData : M3e.Build.Internal.Available
    , loading : M3e.Build.Internal.Available
    , loadingLabel : M3e.Build.Internal.Available
    , noDataLabel : M3e.Build.Internal.Available
    , panelClass : M3e.Build.Internal.Available
    , required : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onQuery : M3e.Build.Internal.Available
    , onToggle : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { loading : M3e.Build.Internal.Available
    , noData : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-autocomplete>`. -}
autocomplete : Builder AttrCaps SlotCaps msg kind
autocomplete =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")