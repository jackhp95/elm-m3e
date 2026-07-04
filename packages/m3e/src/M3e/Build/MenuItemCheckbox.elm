module M3e.Build.MenuItemCheckbox exposing ( Builder, AttrCaps, SlotCaps, menuItemCheckbox )

{-|
The ⑤ Build shape for `<m3e-menu-item-checkbox>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.MenuItemCheckbox as MenuItemCheckbox`.

@docs Builder, AttrCaps, SlotCaps, menuItemCheckbox
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-menu-item-checkbox>`; see `.build` for the terminal. -}
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


{-| Seed a `Builder` for `<m3e-menu-item-checkbox>`. -}
menuItemCheckbox : Builder AttrCaps SlotCaps msg
menuItemCheckbox =
    Builder
        { disabled = Nothing
        , checked = Nothing
        , onClick = Nothing
        , default = Nothing
        , icon = Nothing
        , trailingIcon = Nothing
        }