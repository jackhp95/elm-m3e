module M3e.Build.Toolbar exposing
    ( Builder, AttrCaps, SlotCaps, toolbar, elevated, shape
    , variant, vertical, default
    )

{-|
The ⑤ Build shape for `<m3e-toolbar>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Toolbar as Toolbar`.

@docs Builder, AttrCaps, SlotCaps, toolbar, elevated, shape
@docs variant, vertical, default
-}


import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-toolbar>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { elevated : M3e.Build.Internal.Available
    , shape : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    , vertical : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { elevated : Maybe Bool
    , shape :
        Maybe (M3e.Value.Value { rounded : M3e.Value.Supported
        , square : M3e.Value.Supported
        })
    , variant :
        Maybe (M3e.Value.Value { standard : M3e.Value.Supported
        , vibrant : M3e.Value.Supported
        })
    , vertical : Maybe Bool
    , default : List (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-toolbar>`. -}
toolbar : Builder AttrCaps SlotCaps msg
toolbar =
    Builder
        { elevated = Nothing
        , shape = Nothing
        , variant = Nothing
        , vertical = Nothing
        , default = []
        , phantomMsg_ = Nothing
        }


{-| Whether the toolbar is elevated. (default: `false`) -}
elevated :
    Bool
    -> Builder { a | elevated : M3e.Build.Internal.Available } s msg
    -> Builder { a | elevated : M3e.Build.Internal.Used } s msg
elevated v_ (Builder f_) =
    Builder { f_ | elevated = Just v_ }


{-| The shape of the toolbar. (default: `"square"`) -}
shape :
    M3e.Value.Value { rounded : M3e.Value.Supported
    , square : M3e.Value.Supported
    }
    -> Builder { a | shape : M3e.Build.Internal.Available } s msg
    -> Builder { a | shape : M3e.Build.Internal.Used } s msg
shape v_ (Builder f_) =
    Builder { f_ | shape = Just v_ }


{-| The appearance variant of the toolbar. (default: `"standard"`) -}
variant :
    M3e.Value.Value { standard : M3e.Value.Supported
    , vibrant : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg
variant v_ (Builder f_) =
    Builder { f_ | variant = Just v_ }


{-| Whether the element is oriented vertically. (default: `false`) -}
vertical :
    Bool
    -> Builder { a | vertical : M3e.Build.Internal.Available } s msg
    -> Builder { a | vertical : M3e.Build.Internal.Used } s msg
vertical v_ (Builder f_) =
    Builder { f_ | vertical = Just v_ }


{-| Add an element to the `unnamed` (multi) slot. -}
default : M3e.Element.Element {} msg -> Builder a s msg -> Builder a s msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }