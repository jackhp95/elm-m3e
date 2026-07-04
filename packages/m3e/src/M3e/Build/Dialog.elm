module M3e.Build.Dialog exposing ( Builder, AttrCaps, SlotCaps, dialog )

{-|
The ⑤ Build shape for `<m3e-dialog>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Dialog as Dialog`.

@docs Builder, AttrCaps, SlotCaps, dialog
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-dialog>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { alert : Maybe Bool
    , closeLabel : Maybe String
    , disableClose : Maybe Bool
    , dismissible : Maybe Bool
    , noFocusTrap : Maybe Bool
    , open : Maybe String
    , onOpening : Maybe (Json.Decode.Decoder msg)
    , onOpened : Maybe (Json.Decode.Decoder msg)
    , onClosing : Maybe (Json.Decode.Decoder msg)
    , onClosed : Maybe (Json.Decode.Decoder msg)
    , onCancel : Maybe (Json.Decode.Decoder msg)
    , header : Maybe (M3e.Element.Element { text : M3e.Value.Supported } msg)
    , actions : Maybe (M3e.Element.Element {} msg)
    , closeIcon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , default : List (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-dialog>`. -}
dialog : Builder AttrCaps SlotCaps msg
dialog =
    Builder
        { alert = Nothing
        , closeLabel = Nothing
        , disableClose = Nothing
        , dismissible = Nothing
        , noFocusTrap = Nothing
        , open = Nothing
        , onOpening = Nothing
        , onOpened = Nothing
        , onClosing = Nothing
        , onClosed = Nothing
        , onCancel = Nothing
        , header = Nothing
        , actions = Nothing
        , closeIcon = Nothing
        , default = []
        , phantomMsg_ = Nothing
        }