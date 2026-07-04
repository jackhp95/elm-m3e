module M3e.Build.Collapsible exposing ( Builder, AttrCaps, SlotCaps, collapsible )

{-|
The ⑤ Build shape for `<m3e-collapsible>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Collapsible as Collapsible`.

@docs Builder, AttrCaps, SlotCaps, collapsible
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-collapsible>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { open : Maybe Bool
    , orientation :
        Maybe (M3e.Value.Value { horizontal : M3e.Value.Supported
        , vertical : M3e.Value.Supported
        })
    , noAnimate : Maybe Bool
    , onOpening : Maybe (Json.Decode.Decoder msg)
    , onOpened : Maybe (Json.Decode.Decoder msg)
    , onClosing : Maybe (Json.Decode.Decoder msg)
    , onClosed : Maybe (Json.Decode.Decoder msg)
    , default : List (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-collapsible>`. -}
collapsible : Builder AttrCaps SlotCaps msg
collapsible =
    Builder
        { open = Nothing
        , orientation = Nothing
        , noAnimate = Nothing
        , onOpening = Nothing
        , onOpened = Nothing
        , onClosing = Nothing
        , onClosed = Nothing
        , default = []
        , phantomMsg_ = Nothing
        }