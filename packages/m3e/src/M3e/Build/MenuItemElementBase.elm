module M3e.Build.MenuItemElementBase exposing
    ( Builder, AttrCaps, SlotCaps, menuItemElementBase, disabled, onClick
    )

{-|
The ⑤ Build shape for `<MenuItemElementBase>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.MenuItemElementBase as MenuItemElementBase`.

@docs Builder, AttrCaps, SlotCaps, menuItemElementBase, disabled, onClick
-}


import Json.Decode
import M3e.Build.Internal


{-| Opaque builder for `<MenuItemElementBase>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { disabled : Maybe Bool
    , onClick : Maybe (Json.Decode.Decoder msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<MenuItemElementBase>`. -}
menuItemElementBase : Builder AttrCaps SlotCaps msg
menuItemElementBase =
    Builder { disabled = Nothing, onClick = Nothing, phantomMsg_ = Nothing }


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| onClick event handler. -}
onClick :
    Json.Decode.Decoder msg
    -> Builder { a | onClick : M3e.Build.Internal.Available } s msg
    -> Builder { a | onClick : M3e.Build.Internal.Used } s msg
onClick v_ (Builder f_) =
    Builder { f_ | onClick = Just v_ }