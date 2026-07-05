module M3e.Build.DatepickerToggle exposing ( Builder, AttrCaps, SlotCaps, datepickerToggle )

{-|
The ⑤ Build shape for `<m3e-datepicker-toggle>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.DatepickerToggle as DatepickerToggle`.

@docs Builder, AttrCaps, SlotCaps, datepickerToggle
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-datepicker-toggle>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | datepickerToggle : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { for : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-datepicker-toggle>`. -}
datepickerToggle : Builder AttrCaps SlotCaps msg kind
datepickerToggle =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")