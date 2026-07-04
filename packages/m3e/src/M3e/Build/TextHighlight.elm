module M3e.Build.TextHighlight exposing ( Builder, AttrCaps, SlotCaps, textHighlight )

{-|
The ⑤ Build shape for `<m3e-text-highlight>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.TextHighlight as TextHighlight`.

@docs Builder, AttrCaps, SlotCaps, textHighlight
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-text-highlight>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg any_ =
    { caseSensitive : Maybe Bool
    , disabled : Maybe Bool
    , mode :
        Maybe (M3e.Value.Value { contains : M3e.Value.Supported
        , endsWith : M3e.Value.Supported
        , startsWith : M3e.Value.Supported
        })
    , term : Maybe String
    , onHighlight : Maybe (Json.Decode.Decoder msg)
    , default : List (M3e.Element.Element any_ msg)
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
        }