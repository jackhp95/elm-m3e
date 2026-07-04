module M3e.Build.ButtonGroup exposing ( Builder, AttrCaps, SlotCaps, buttonGroup )

{-|
The ⑤ Build shape for `<m3e-button-group>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ButtonGroup as ButtonGroup`.

@docs Builder, AttrCaps, SlotCaps, buttonGroup
-}


import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-button-group>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


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
    }


{-| Seed a `Builder` for `<m3e-button-group>`. -}
buttonGroup : Builder AttrCaps SlotCaps msg
buttonGroup =
    Builder { multi = Nothing, size = Nothing, variant = Nothing, default = [] }