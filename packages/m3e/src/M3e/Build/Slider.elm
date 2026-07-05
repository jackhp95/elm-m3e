module M3e.Build.Slider exposing ( Builder, AttrCaps, SlotCaps, slider )

{-|
The ⑤ Build shape for `<m3e-slider>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Slider as Slider`.

@docs Builder, AttrCaps, SlotCaps, slider
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-slider>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | slider : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , discrete : M3e.Build.Internal.Available
    , labelled : M3e.Build.Internal.Available
    , max : M3e.Build.Internal.Available
    , min : M3e.Build.Internal.Available
    , step : M3e.Build.Internal.Available
    , size : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.NotFilled }


{-| Seed a `Builder` for `<m3e-slider>`. -}
slider : Builder AttrCaps SlotCaps msg kind
slider =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")