module M3e.Build.Menu exposing ( Builder, AttrCaps, SlotCaps, menu )

{-|
The ⑤ Build shape for `<m3e-menu>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Menu as Menu`.

@docs Builder, AttrCaps, SlotCaps, menu
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-menu>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { positionX :
        Maybe (M3e.Value.Value { after : M3e.Value.Supported
        , before : M3e.Value.Supported
        })
    , positionY :
        Maybe (M3e.Value.Value { above : M3e.Value.Supported
        , below : M3e.Value.Supported
        })
    , variant :
        Maybe (M3e.Value.Value { standard : M3e.Value.Supported
        , vibrant : M3e.Value.Supported
        })
    , submenu : Maybe Bool
    , onBeforetoggle : Maybe (Json.Decode.Decoder msg)
    , onToggle : Maybe (Json.Decode.Decoder msg)
    , default :
        List (M3e.Element.Element { menuItem : M3e.Value.Supported
        , menuItemCheckbox : M3e.Value.Supported
        , menuItemRadio : M3e.Value.Supported
        , menuItemGroup : M3e.Value.Supported
        , divider : M3e.Value.Supported
        } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-menu>`. -}
menu : Builder AttrCaps SlotCaps msg
menu =
    Builder
        { positionX = Nothing
        , positionY = Nothing
        , variant = Nothing
        , submenu = Nothing
        , onBeforetoggle = Nothing
        , onToggle = Nothing
        , default = []
        , phantomMsg_ = Nothing
        }