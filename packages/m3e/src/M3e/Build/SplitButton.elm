module M3e.Build.SplitButton exposing ( Builder, AttrCaps, SlotCaps, splitButton )

{-|
The ⑤ Build shape for `<m3e-split-button>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SplitButton as SplitButton`.

@docs Builder, AttrCaps, SlotCaps, splitButton
-}


import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-split-button>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { leadingButton : M3e.Element.Element { button : M3e.Value.Supported } msg
    , trailingButton :
        M3e.Element.Element { iconButton : M3e.Value.Supported } msg
    , variant :
        Maybe (M3e.Value.Value { elevated : M3e.Value.Supported
        , filled : M3e.Value.Supported
        , outlined : M3e.Value.Supported
        , tonal : M3e.Value.Supported
        })
    , size :
        Maybe (M3e.Value.Value { extraLarge : M3e.Value.Supported
        , extraSmall : M3e.Value.Supported
        , large : M3e.Value.Supported
        , medium : M3e.Value.Supported
        , small : M3e.Value.Supported
        })
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-split-button>` with the required fields. -}
splitButton :
    { leadingButton : M3e.Element.Element { button : M3e.Value.Supported } msg
    , trailingButton :
        M3e.Element.Element { iconButton : M3e.Value.Supported } msg
    }
    -> Builder AttrCaps SlotCaps msg
splitButton req_ =
    Builder
        { leadingButton = req_.leadingButton
        , trailingButton = req_.trailingButton
        , variant = Nothing
        , size = Nothing
        , phantomMsg_ = Nothing
        }