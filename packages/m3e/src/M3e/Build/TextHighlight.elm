module M3e.Build.TextHighlight exposing
    ( Builder, AttrCaps, SlotCaps, textHighlight, caseSensitive, disabled
    , mode, term, onHighlight
    )

{-|
The ⑤ Build shape for `<m3e-text-highlight>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.TextHighlight as TextHighlight`.

@docs Builder, AttrCaps, SlotCaps, textHighlight, caseSensitive, disabled
@docs mode, term, onHighlight
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-text-highlight>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { caseSensitive : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , mode : M3e.Build.Internal.Available
    , term : M3e.Build.Internal.Available
    , onHighlight : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { caseSensitive : Maybe Bool
    , disabled : Maybe Bool
    , mode :
        Maybe (M3e.Value.Value { contains : M3e.Value.Supported
        , endsWith : M3e.Value.Supported
        , startsWith : M3e.Value.Supported
        })
    , term : Maybe String
    , onHighlight : Maybe (Json.Decode.Decoder msg)
    , default : List (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-text-highlight>`. -}
textHighlight : Builder AttrCaps SlotCaps msg
textHighlight =
    Builder
        { caseSensitive = Nothing
        , disabled = Nothing
        , mode = Nothing
        , term = Nothing
        , onHighlight = Nothing
        , default = []
        , phantomMsg_ = Nothing
        }


{-| Whether matching is case sensitive. (default: `false`) -}
caseSensitive :
    Bool
    -> Builder { a | caseSensitive : M3e.Build.Internal.Available } s msg
    -> Builder { a | caseSensitive : M3e.Build.Internal.Used } s msg
caseSensitive v_ (Builder f_) =
    Builder { f_ | caseSensitive = Just v_ }


{-| A value indicating whether text highlighting is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| The mode in which to highlight text. (default: `"contains"`) -}
mode :
    M3e.Value.Value { contains : M3e.Value.Supported
    , endsWith : M3e.Value.Supported
    , startsWith : M3e.Value.Supported
    }
    -> Builder { a | mode : M3e.Build.Internal.Available } s msg
    -> Builder { a | mode : M3e.Build.Internal.Used } s msg
mode v_ (Builder f_) =
    Builder { f_ | mode = Just v_ }


{-| The term to highlight. (default: `""`) -}
term :
    String
    -> Builder { a | term : M3e.Build.Internal.Available } s msg
    -> Builder { a | term : M3e.Build.Internal.Used } s msg
term v_ (Builder f_) =
    Builder { f_ | term = Just v_ }


{-| Dispatched when content is highlighted. -}
onHighlight :
    Json.Decode.Decoder msg
    -> Builder { a | onHighlight : M3e.Build.Internal.Available } s msg
    -> Builder { a | onHighlight : M3e.Build.Internal.Used } s msg
onHighlight v_ (Builder f_) =
    Builder { f_ | onHighlight = Just v_ }