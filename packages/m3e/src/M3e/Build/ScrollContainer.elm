module M3e.Build.ScrollContainer exposing
    ( Builder, AttrCaps, SlotCaps, scrollContainer, dividers, thin
    )

{-|
The ⑤ Build shape for `<m3e-scroll-container>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ScrollContainer as ScrollContainer`.

@docs Builder, AttrCaps, SlotCaps, scrollContainer, dividers, thin
-}


import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-scroll-container>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { dividers : M3e.Build.Internal.Available
    , thin : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { dividers :
        Maybe (M3e.Value.Value { above : M3e.Value.Supported
        , aboveBelow : M3e.Value.Supported
        , below : M3e.Value.Supported
        , none : M3e.Value.Supported
        })
    , thin : Maybe Bool
    , default : List (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-scroll-container>`. -}
scrollContainer : Builder AttrCaps SlotCaps msg
scrollContainer =
    Builder
        { dividers = Nothing
        , thin = Nothing
        , default = []
        , phantomMsg_ = Nothing
        }


{-| The dividers used to separate scrollable content. (default: `"above-below"`) -}
dividers :
    M3e.Value.Value { above : M3e.Value.Supported
    , aboveBelow : M3e.Value.Supported
    , below : M3e.Value.Supported
    , none : M3e.Value.Supported
    }
    -> Builder { a | dividers : M3e.Build.Internal.Available } s msg
    -> Builder { a | dividers : M3e.Build.Internal.Used } s msg
dividers v_ (Builder f_) =
    Builder { f_ | dividers = Just v_ }


{-| Whether to present thin scrollbars. (default: `false`) -}
thin :
    Bool
    -> Builder { a | thin : M3e.Build.Internal.Available } s msg
    -> Builder { a | thin : M3e.Build.Internal.Used } s msg
thin v_ (Builder f_) =
    Builder { f_ | thin = Just v_ }