module M3e.Build.TocItem exposing ( Builder, AttrCaps, SlotCaps, tocItem )

{-|
The ⑤ Build shape for `<m3e-toc-item>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.TocItem as TocItem`.

@docs Builder, AttrCaps, SlotCaps, tocItem
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-toc-item>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg
    , disabled : Maybe Bool
    , selected : Maybe Bool
    , onClick : Maybe (Json.Decode.Decoder msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-toc-item>` with the required fields. -}
tocItem :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> Builder AttrCaps SlotCaps msg
tocItem req_ =
    Builder
        { content = req_.content
        , disabled = Nothing
        , selected = Nothing
        , onClick = Nothing
        , phantomMsg_ = Nothing
        }