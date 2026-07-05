module M3e.Build.MultiYearView exposing ( Builder, AttrCaps, SlotCaps, multiYearView )

{-|
The ⑤ Build shape for `<m3e-multi-year-view>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.MultiYearView as MultiYearView`.

@docs Builder, AttrCaps, SlotCaps, multiYearView
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-multi-year-view>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | multiYearView : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { active : M3e.Build.Internal.Available
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


{-| Seed a `Builder` for `<m3e-multi-year-view>`. -}
multiYearView : Builder AttrCaps SlotCaps msg kind
multiYearView =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")