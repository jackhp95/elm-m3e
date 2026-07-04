module M3e.Build.Accordion exposing
    ( Builder, AttrCaps, SlotCaps, accordion, multi
    )

{-|
The ⑤ Build shape for `<m3e-accordion>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Accordion as Accordion`.

@docs Builder, AttrCaps, SlotCaps, accordion, multi
-}


import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-accordion>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { multi : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { multi : Maybe Bool
    , default :
        List (M3e.Element.Element { expansionPanel : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-accordion>`. -}
accordion : Builder AttrCaps SlotCaps msg
accordion =
    Builder { multi = Nothing, default = [], phantomMsg_ = Nothing }


{-| Whether multiple expansion panels can be open at the same time. (default: `false`) -}
multi :
    Bool
    -> Builder { a | multi : M3e.Build.Internal.Available } s msg
    -> Builder { a | multi : M3e.Build.Internal.Used } s msg
multi v_ (Builder f_) =
    Builder { f_ | multi = Just v_ }