module M3e.Build.Menu exposing
    ( Builder, AttrCaps, SlotCaps, menu, positionX, positionY
    , variant, submenu, onBeforetoggle, onToggle, default
    )

{-|
The ⑤ Build shape for `<m3e-menu>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Menu as Menu`.

@docs Builder, AttrCaps, SlotCaps, menu, positionX, positionY
@docs variant, submenu, onBeforetoggle, onToggle, default
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-menu>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { positionX : M3e.Build.Internal.Available
    , positionY : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    , submenu : M3e.Build.Internal.Available
    , onBeforetoggle : M3e.Build.Internal.Available
    , onToggle : M3e.Build.Internal.Available
    }


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


{-| The position of the menu, on the x-axis. (default: `"after"`) -}
positionX :
    M3e.Value.Value { after : M3e.Value.Supported
    , before : M3e.Value.Supported
    }
    -> Builder { a | positionX : M3e.Build.Internal.Available } s msg
    -> Builder { a | positionX : M3e.Build.Internal.Used } s msg
positionX v_ (Builder f_) =
    Builder { f_ | positionX = Just v_ }


{-| The position of the menu, on the y-axis. (default: `"below"`) -}
positionY :
    M3e.Value.Value { above : M3e.Value.Supported, below : M3e.Value.Supported }
    -> Builder { a | positionY : M3e.Build.Internal.Available } s msg
    -> Builder { a | positionY : M3e.Build.Internal.Used } s msg
positionY v_ (Builder f_) =
    Builder { f_ | positionY = Just v_ }


{-| The appearance variant of the menu. (default: `"standard"`) -}
variant :
    M3e.Value.Value { standard : M3e.Value.Supported
    , vibrant : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg
variant v_ (Builder f_) =
    Builder { f_ | variant = Just v_ }


{-| A value indicating whether the menu is a submenu. (default: `false`) -}
submenu :
    Bool
    -> Builder { a | submenu : M3e.Build.Internal.Available } s msg
    -> Builder { a | submenu : M3e.Build.Internal.Used } s msg
submenu v_ (Builder f_) =
    Builder { f_ | submenu = Just v_ }


{-| Dispatched before the toggle state changes. -}
onBeforetoggle :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforetoggle : M3e.Build.Internal.Available } s msg
    -> Builder { a | onBeforetoggle : M3e.Build.Internal.Used } s msg
onBeforetoggle v_ (Builder f_) =
    Builder { f_ | onBeforetoggle = Just v_ }


{-| Dispatched after the toggle state has changed. -}
onToggle :
    Json.Decode.Decoder msg
    -> Builder { a | onToggle : M3e.Build.Internal.Available } s msg
    -> Builder { a | onToggle : M3e.Build.Internal.Used } s msg
onToggle v_ (Builder f_) =
    Builder { f_ | onToggle = Just v_ }


{-| Add an element to the `unnamed` (multi) slot. -}
default :
    M3e.Element.Element { menuItem : M3e.Value.Supported
    , menuItemCheckbox : M3e.Value.Supported
    , menuItemRadio : M3e.Value.Supported
    , menuItemGroup : M3e.Value.Supported
    , divider : M3e.Value.Supported
    } msg
    -> Builder a s msg
    -> Builder a s msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }