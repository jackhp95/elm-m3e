module M3e.Build.NavRail exposing ( Builder, AttrCaps, SlotCaps, navRail )

{-|
The ⑤ Build shape for `<m3e-nav-rail>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.NavRail as NavRail`.

@docs Builder, AttrCaps, SlotCaps, navRail
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-nav-rail>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { mode :
        Maybe (M3e.Value.Value { auto : M3e.Value.Supported
        , compact : M3e.Value.Supported
        , expanded : M3e.Value.Supported
        })
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , onChange : Maybe (Json.Decode.Decoder msg)
    , default :
        List (M3e.Element.Element { navItem : M3e.Value.Supported
        , iconButton : M3e.Value.Supported
        , fab : M3e.Value.Supported
        } msg)
    }


{-| Seed a `Builder` for `<m3e-nav-rail>`. -}
navRail : Builder AttrCaps SlotCaps msg
navRail =
    Builder
        { mode = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , onChange = Nothing
        , default = []
        }