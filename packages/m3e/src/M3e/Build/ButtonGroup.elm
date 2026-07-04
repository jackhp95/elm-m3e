module M3e.Build.ButtonGroup exposing
    ( Builder, AttrCaps, SlotCaps, buttonGroup, multi, size
    , variant, default
    )

{-|
The ⑤ Build shape for `<m3e-button-group>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ButtonGroup as ButtonGroup`.

@docs Builder, AttrCaps, SlotCaps, buttonGroup, multi, size
@docs variant, default
-}


import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-button-group>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { multi : M3e.Build.Internal.Available
    , size : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { multi : Maybe Bool
    , size :
        Maybe (M3e.Value.Value { extraLarge : M3e.Value.Supported
        , extraSmall : M3e.Value.Supported
        , large : M3e.Value.Supported
        , medium : M3e.Value.Supported
        , small : M3e.Value.Supported
        })
    , variant :
        Maybe (M3e.Value.Value { connected : M3e.Value.Supported
        , standard : M3e.Value.Supported
        })
    , default :
        List (M3e.Element.Element { button : M3e.Value.Supported
        , iconButton : M3e.Value.Supported
        } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-button-group>`. -}
buttonGroup : Builder AttrCaps SlotCaps msg
buttonGroup =
    Builder
        { multi = Nothing
        , size = Nothing
        , variant = Nothing
        , default = []
        , phantomMsg_ = Nothing
        }


{-| Whether multiple toggle buttons can be selected. (default: `false`) -}
multi :
    Bool
    -> Builder { a | multi : M3e.Build.Internal.Available } s msg
    -> Builder { a | multi : M3e.Build.Internal.Used } s msg
multi v_ (Builder f_) =
    Builder { f_ | multi = Just v_ }


{-| The size of the group. (default: `"small"`) -}
size :
    M3e.Value.Value { extraLarge : M3e.Value.Supported
    , extraSmall : M3e.Value.Supported
    , large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> Builder { a | size : M3e.Build.Internal.Available } s msg
    -> Builder { a | size : M3e.Build.Internal.Used } s msg
size v_ (Builder f_) =
    Builder { f_ | size = Just v_ }


{-| The appearance variant of the group. (default: `"standard"`) -}
variant :
    M3e.Value.Value { connected : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg
variant v_ (Builder f_) =
    Builder { f_ | variant = Just v_ }


{-| Add an element to the `unnamed` (multi) slot. -}
default :
    M3e.Element.Element { button : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> Builder a s msg
    -> Builder a s msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }