module M3e.Build.Step exposing ( Builder, AttrCaps, SlotCaps, step )

{-|
The ⑤ Build shape for `<m3e-step>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Step as Step`.

@docs Builder, AttrCaps, SlotCaps, step
-}


import M3e.Build.Internal
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-step>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | step : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { completed : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , editable : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    , optional : M3e.Build.Internal.Available
    , selected : M3e.Build.Internal.Available
    , invalid : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { icon : M3e.Build.Internal.Available
    , doneIcon : M3e.Build.Internal.Available
    , editIcon : M3e.Build.Internal.Available
    , errorIcon : M3e.Build.Internal.Available
    , hint : M3e.Build.Internal.Available
    , error : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-step>` with the required fields. -}
step :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> Builder AttrCaps SlotCaps msg kind
step req_ =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")