module M3e.Build.FabMenu exposing ( Builder, AttrCaps, SlotCaps, fabMenu )

{-|
The ⑤ Build shape for `<m3e-fab-menu>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.FabMenu as FabMenu`.

@docs Builder, AttrCaps, SlotCaps, fabMenu
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-fab-menu>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { variant :
        Maybe (M3e.Value.Value { primary : M3e.Value.Supported
        , secondary : M3e.Value.Supported
        , tertiary : M3e.Value.Supported
        })
    , onBeforetoggle : Maybe (Json.Decode.Decoder msg)
    , onToggle : Maybe (Json.Decode.Decoder msg)
    , default :
        List (M3e.Element.Element { fabMenuItem : M3e.Value.Supported
        , menuItem : M3e.Value.Supported
        } msg)
    }


{-| Seed a `Builder` for `<m3e-fab-menu>`. -}
fabMenu : Builder AttrCaps SlotCaps msg
fabMenu =
    Builder
        { variant = Nothing
        , onBeforetoggle = Nothing
        , onToggle = Nothing
        , default = []
        }