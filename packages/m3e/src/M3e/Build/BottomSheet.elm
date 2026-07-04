module M3e.Build.BottomSheet exposing ( Builder, AttrCaps, SlotCaps, bottomSheet )

{-|
The ⑤ Build shape for `<m3e-bottom-sheet>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.BottomSheet as BottomSheet`.

@docs Builder, AttrCaps, SlotCaps, bottomSheet
-}


import Json.Decode
import M3e.Element


{-| Opaque builder for `<m3e-bottom-sheet>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg any_ =
    { detent : Maybe Float
    , handle : Maybe Bool
    , handleLabel : Maybe String
    , hideable : Maybe Bool
    , hideFriction : Maybe Float
    , modal : Maybe Bool
    , open : Maybe Bool
    , overshootLimit : Maybe Float
    , onOpening : Maybe (Json.Decode.Decoder msg)
    , onClosing : Maybe (Json.Decode.Decoder msg)
    , onCancel : Maybe (Json.Decode.Decoder msg)
    , onOpened : Maybe (Json.Decode.Decoder msg)
    , onClosed : Maybe (Json.Decode.Decoder msg)
    , header : Maybe (M3e.Element.Element any_ msg)
    , default : List (M3e.Element.Element any_ msg)
    }


{-| Seed a `Builder` for `<m3e-bottom-sheet>`. -}
bottomSheet : Builder AttrCaps SlotCaps msg
bottomSheet =
    Builder
        { detent = Nothing
        , handle = Nothing
        , handleLabel = Nothing
        , hideable = Nothing
        , hideFriction = Nothing
        , modal = Nothing
        , open = Nothing
        , overshootLimit = Nothing
        , onOpening = Nothing
        , onClosing = Nothing
        , onCancel = Nothing
        , onOpened = Nothing
        , onClosed = Nothing
        , header = Nothing
        , default = []
        }