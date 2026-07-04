module M3e.Build.MenuItemRadio exposing ( Builder, AttrCaps, SlotCaps, menuItemRadio )

{-|
The ⑤ Build shape for `<m3e-menu-item-radio>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.MenuItemRadio as MenuItemRadio`.

@docs Builder, AttrCaps, SlotCaps, menuItemRadio
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-menu-item-radio>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { disabled : Maybe Bool
    , checked : Maybe Bool
    , onClick : Maybe (Json.Decode.Decoder msg)
    , default : Maybe (M3e.Element.Element { text : M3e.Value.Supported } msg)
    , icon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , trailingIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    }


{-| Seed a `Builder` for `<m3e-menu-item-radio>`. -}
menuItemRadio : Builder AttrCaps SlotCaps msg
menuItemRadio =
    Builder
        { disabled = Nothing
        , checked = Nothing
        , onClick = Nothing
        , default = Nothing
        , icon = Nothing
        , trailingIcon = Nothing
        }