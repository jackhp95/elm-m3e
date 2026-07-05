module M3e.Build.FormField exposing ( Builder, AttrCaps, SlotCaps, formField )

{-|
The ⑤ Build shape for `<m3e-form-field>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.FormField as FormField`.

@docs Builder, AttrCaps, SlotCaps, formField
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-form-field>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | formField : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { floatLabel : M3e.Build.Internal.Available
    , hideRequiredMarker : M3e.Build.Internal.Available
    , hideSubscript : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { prefix : M3e.Build.Internal.Available
    , prefixText : M3e.Build.Internal.Available
    , label : M3e.Build.Internal.Available
    , suffix : M3e.Build.Internal.Available
    , suffixText : M3e.Build.Internal.Available
    , hint : M3e.Build.Internal.Available
    , error : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-form-field>`. -}
formField : Builder AttrCaps SlotCaps msg kind
formField =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")