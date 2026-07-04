module M3e.Build.SplitPane exposing ( Builder, AttrCaps, SlotCaps, splitPane )

{-|
The ⑤ Build shape for `<m3e-split-pane>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SplitPane as SplitPane`.

@docs Builder, AttrCaps, SlotCaps, splitPane
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-split-pane>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { label : Maybe String
    , max : Maybe Float
    , min : Maybe Float
    , orientation :
        Maybe (M3e.Value.Value { auto : M3e.Value.Supported
        , horizontal : M3e.Value.Supported
        , vertical : M3e.Value.Supported
        })
    , overshootLimit : Maybe Float
    , step : Maybe Float
    , value : Maybe Float
    , wrapDetents : Maybe Bool
    , name : Maybe String
    , disabled : Maybe Bool
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , start : Maybe (M3e.Element.Element {} msg)
    , end : Maybe (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-split-pane>`. -}
splitPane : Builder AttrCaps SlotCaps msg
splitPane =
    Builder
        { label = Nothing
        , max = Nothing
        , min = Nothing
        , orientation = Nothing
        , overshootLimit = Nothing
        , step = Nothing
        , value = Nothing
        , wrapDetents = Nothing
        , name = Nothing
        , disabled = Nothing
        , onChange = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , start = Nothing
        , end = Nothing
        , phantomMsg_ = Nothing
        }