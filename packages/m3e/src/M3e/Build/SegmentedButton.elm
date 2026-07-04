module M3e.Build.SegmentedButton exposing ( Builder, AttrCaps, SlotCaps, segmentedButton )

{-|
The ⑤ Build shape for `<m3e-segmented-button>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SegmentedButton as SegmentedButton`.

@docs Builder, AttrCaps, SlotCaps, segmentedButton
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-segmented-button>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { disabled : Maybe Bool
    , hideSelectionIndicator : Maybe Bool
    , multi : Maybe Bool
    , name : Maybe String
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , default :
        List (M3e.Element.Element { buttonSegment : M3e.Value.Supported } msg)
    }


{-| Seed a `Builder` for `<m3e-segmented-button>`. -}
segmentedButton : Builder AttrCaps SlotCaps msg
segmentedButton =
    Builder
        { disabled = Nothing
        , hideSelectionIndicator = Nothing
        , multi = Nothing
        , name = Nothing
        , onChange = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , default = []
        }