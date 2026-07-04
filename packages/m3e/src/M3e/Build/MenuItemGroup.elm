module M3e.Build.MenuItemGroup exposing
    ( Builder, AttrCaps, SlotCaps, menuItemGroup, default
    )

{-|
The ⑤ Build shape for `<m3e-menu-item-group>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.MenuItemGroup as MenuItemGroup`.

@docs Builder, AttrCaps, SlotCaps, menuItemGroup, default
-}


import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-menu-item-group>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { default :
        List (M3e.Element.Element { menuItem : M3e.Value.Supported
        , menuItemCheckbox : M3e.Value.Supported
        , menuItemRadio : M3e.Value.Supported
        } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-menu-item-group>`. -}
menuItemGroup : Builder AttrCaps SlotCaps msg
menuItemGroup =
    Builder { default = [], phantomMsg_ = Nothing }


{-| Add an element to the `unnamed` (multi) slot. -}
default :
    M3e.Element.Element { menuItem : M3e.Value.Supported
    , menuItemCheckbox : M3e.Value.Supported
    , menuItemRadio : M3e.Value.Supported
    } msg
    -> Builder a s msg
    -> Builder a s msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }