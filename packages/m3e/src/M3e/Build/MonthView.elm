module M3e.Build.MonthView exposing ( Builder, AttrCaps, SlotCaps, monthView )

{-|
The ⑤ Build shape for `<m3e-month-view>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.MonthView as MonthView`.

@docs Builder, AttrCaps, SlotCaps, monthView
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-month-view>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | monthView : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { rangeStart : M3e.Build.Internal.Available
    , rangeEnd : M3e.Build.Internal.Available
    , active : M3e.Build.Internal.Available
    , today : M3e.Build.Internal.Available
    , date : M3e.Build.Internal.Available
    , activeDate : M3e.Build.Internal.Available
    , minDate : M3e.Build.Internal.Available
    , maxDate : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onActiveChange : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-month-view>`. -}
monthView : Builder AttrCaps SlotCaps msg kind
monthView =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")