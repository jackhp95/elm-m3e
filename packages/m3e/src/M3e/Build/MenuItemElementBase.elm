module M3e.Build.MenuItemElementBase exposing ( Builder, AttrCaps, SlotCaps, menuItemElementBase )

{-|
The ⑤ Build shape for `<MenuItemElementBase>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.MenuItemElementBase as MenuItemElementBase`.

@docs Builder, AttrCaps, SlotCaps, menuItemElementBase
-}


import Json.Decode


{-| Opaque builder for `<MenuItemElementBase>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { disabled : Maybe Bool, onClick : Maybe (Json.Decode.Decoder msg) }


{-| Seed a `Builder` for `<MenuItemElementBase>`. -}
menuItemElementBase : Builder AttrCaps SlotCaps msg
menuItemElementBase =
    Builder { disabled = Nothing, onClick = Nothing }