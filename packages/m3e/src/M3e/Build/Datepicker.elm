module M3e.Build.Datepicker exposing ( Builder, AttrCaps, SlotCaps, datepicker )

{-|
The ⑤ Build shape for `<m3e-datepicker>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Datepicker as Datepicker`.

@docs Builder, AttrCaps, SlotCaps, datepicker
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-datepicker>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | datepicker : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { variant : M3e.Build.Internal.Available
    , clearable : M3e.Build.Internal.Available
    , date : M3e.Build.Internal.Available
    , maxDate : M3e.Build.Internal.Available
    , minDate : M3e.Build.Internal.Available
    , range : M3e.Build.Internal.Available
    , rangeEnd : M3e.Build.Internal.Available
    , rangeStart : M3e.Build.Internal.Available
    , startAt : M3e.Build.Internal.Available
    , startView : M3e.Build.Internal.Available
    , previousMonthLabel : M3e.Build.Internal.Available
    , nextMonthLabel : M3e.Build.Internal.Available
    , previousYearLabel : M3e.Build.Internal.Available
    , nextYearLabel : M3e.Build.Internal.Available
    , previousMultiYearLabel : M3e.Build.Internal.Available
    , nextMultiYearLabel : M3e.Build.Internal.Available
    , clearLabel : M3e.Build.Internal.Available
    , confirmLabel : M3e.Build.Internal.Available
    , dismissLabel : M3e.Build.Internal.Available
    , label : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onBeforetoggle : M3e.Build.Internal.Available
    , onToggle : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-datepicker>`. -}
datepicker : Builder AttrCaps SlotCaps msg kind
datepicker =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")