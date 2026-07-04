module M3e.Build.DrawerContainer exposing ( Builder, AttrCaps, SlotCaps, drawerContainer )

{-|
The ⑤ Build shape for `<m3e-drawer-container>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.DrawerContainer as DrawerContainer`.

@docs Builder, AttrCaps, SlotCaps, drawerContainer
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-drawer-container>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg any_ =
    { end : Maybe Bool
    , endMode :
        Maybe (M3e.Value.Value { auto : M3e.Value.Supported
        , over : M3e.Value.Supported
        , push : M3e.Value.Supported
        , side : M3e.Value.Supported
        })
    , endDivider : Maybe Bool
    , start : Maybe Bool
    , startMode :
        Maybe (M3e.Value.Value { auto : M3e.Value.Supported
        , over : M3e.Value.Supported
        , push : M3e.Value.Supported
        , side : M3e.Value.Supported
        })
    , startDivider : Maybe Bool
    , onChange : Maybe (Json.Decode.Decoder msg)
    , default : Maybe (M3e.Element.Element any_ msg)
    , startSlot : Maybe (M3e.Element.Element any_ msg)
    , endSlot : Maybe (M3e.Element.Element any_ msg)
    }


{-| Seed a `Builder` for `<m3e-drawer-container>`. -}
drawerContainer : Builder AttrCaps SlotCaps msg
drawerContainer =
    Builder
        { end = Nothing
        , endMode = Nothing
        , endDivider = Nothing
        , start = Nothing
        , startMode = Nothing
        , startDivider = Nothing
        , onChange = Nothing
        , default = Nothing
        , startSlot = Nothing
        , endSlot = Nothing
        }