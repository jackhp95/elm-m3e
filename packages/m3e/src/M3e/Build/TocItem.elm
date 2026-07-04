module M3e.Build.TocItem exposing
    ( Builder, AttrCaps, SlotCaps, tocItem, disabled, selected
    , onClick
    )

{-|
The ⑤ Build shape for `<m3e-toc-item>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.TocItem as TocItem`.

@docs Builder, AttrCaps, SlotCaps, tocItem, disabled, selected
@docs onClick
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-toc-item>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , selected : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


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


{-| A value indicating whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| Whether the element is selected. (default: `false`) -}
selected :
    Bool
    -> Builder { a | selected : M3e.Build.Internal.Available } s msg
    -> Builder { a | selected : M3e.Build.Internal.Used } s msg
selected v_ (Builder f_) =
    Builder { f_ | selected = Just v_ }


{-| Dispatched when the element is clicked. -}
onClick :
    Json.Decode.Decoder msg
    -> Builder { a | onClick : M3e.Build.Internal.Available } s msg
    -> Builder { a | onClick : M3e.Build.Internal.Used } s msg
onClick v_ (Builder f_) =
    Builder { f_ | onClick = Just v_ }