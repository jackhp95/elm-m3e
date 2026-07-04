module M3e.Build.BottomSheet exposing
    ( Builder, AttrCaps, SlotCaps, bottomSheet, detent, handle
    , handleLabel, hideable, hideFriction, modal, open, overshootLimit, onOpening
    , onClosing, onCancel, onOpened, onClosed, header
    )

{-|
The ⑤ Build shape for `<m3e-bottom-sheet>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.BottomSheet as BottomSheet`.

@docs Builder, AttrCaps, SlotCaps, bottomSheet, detent, handle
@docs handleLabel, hideable, hideFriction, modal, open, overshootLimit
@docs onOpening, onClosing, onCancel, onOpened, onClosed, header
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Element


{-| Opaque builder for `<m3e-bottom-sheet>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { detent : M3e.Build.Internal.Available
    , handle : M3e.Build.Internal.Available
    , handleLabel : M3e.Build.Internal.Available
    , hideable : M3e.Build.Internal.Available
    , hideFriction : M3e.Build.Internal.Available
    , modal : M3e.Build.Internal.Available
    , open : M3e.Build.Internal.Available
    , overshootLimit : M3e.Build.Internal.Available
    , onOpening : M3e.Build.Internal.Available
    , onClosing : M3e.Build.Internal.Available
    , onCancel : M3e.Build.Internal.Available
    , onOpened : M3e.Build.Internal.Available
    , onClosed : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { header : M3e.Build.Internal.Available }


type alias Fields msg =
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
    , header : Maybe (M3e.Element.Element {} msg)
    , default : List (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
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
        , phantomMsg_ = Nothing
        }


{-| The zero‑based index of the detent the sheet should open to. (default: `0`) -}
detent :
    Float
    -> Builder { a | detent : M3e.Build.Internal.Available } s msg
    -> Builder { a | detent : M3e.Build.Internal.Used } s msg
detent v_ (Builder f_) =
    Builder { f_ | detent = Just v_ }


{-| Whether to display a drag handle and enable the top region of the sheet as a gesture
surface for dragging between detents. (default: `false`)
-}
handle :
    Bool
    -> Builder { a | handle : M3e.Build.Internal.Available } s msg
    -> Builder { a | handle : M3e.Build.Internal.Used } s msg
handle v_ (Builder f_) =
    Builder { f_ | handle = Just v_ }


{-| The accessible label given to the drag handle. (default: `"Drag handle"`) -}
handleLabel :
    String
    -> Builder { a | handleLabel : M3e.Build.Internal.Available } s msg
    -> Builder { a | handleLabel : M3e.Build.Internal.Used } s msg
handleLabel v_ (Builder f_) =
    Builder { f_ | handleLabel = Just v_ }


{-| Whether the bottom sheet can hide when its swiped down. (default: `false`) -}
hideable :
    Bool
    -> Builder { a | hideable : M3e.Build.Internal.Available } s msg
    -> Builder { a | hideable : M3e.Build.Internal.Used } s msg
hideable v_ (Builder f_) =
    Builder { f_ | hideable = Just v_ }


{-| The friction coefficient to hide the sheet. (default: `0.5`) -}
hideFriction :
    Float
    -> Builder { a | hideFriction : M3e.Build.Internal.Available } s msg
    -> Builder { a | hideFriction : M3e.Build.Internal.Used } s msg
hideFriction v_ (Builder f_) =
    Builder { f_ | hideFriction = Just v_ }


{-| Whether the bottom sheet behaves as modal. (default: `false`) -}
modal :
    Bool
    -> Builder { a | modal : M3e.Build.Internal.Available } s msg
    -> Builder { a | modal : M3e.Build.Internal.Used } s msg
modal v_ (Builder f_) =
    Builder { f_ | modal = Just v_ }


{-| Whether the bottom sheet is open. (default: `false`) -}
open :
    Bool
    -> Builder { a | open : M3e.Build.Internal.Available } s msg
    -> Builder { a | open : M3e.Build.Internal.Used } s msg
open v_ (Builder f_) =
    Builder { f_ | open = Just v_ }


{-| A fractional value, between 0 and 100, indicating the maximum visual overshoot allowed when dragging past the minimum or maximum size. (default: `4`) -}
overshootLimit :
    Float
    -> Builder { a | overshootLimit : M3e.Build.Internal.Available } s msg
    -> Builder { a | overshootLimit : M3e.Build.Internal.Used } s msg
overshootLimit v_ (Builder f_) =
    Builder { f_ | overshootLimit = Just v_ }


{-| Dispatched when the sheet begins to open. -}
onOpening :
    Json.Decode.Decoder msg
    -> Builder { a | onOpening : M3e.Build.Internal.Available } s msg
    -> Builder { a | onOpening : M3e.Build.Internal.Used } s msg
onOpening v_ (Builder f_) =
    Builder { f_ | onOpening = Just v_ }


{-| Dispatched when the sheet begins to close. -}
onClosing :
    Json.Decode.Decoder msg
    -> Builder { a | onClosing : M3e.Build.Internal.Available } s msg
    -> Builder { a | onClosing : M3e.Build.Internal.Used } s msg
onClosing v_ (Builder f_) =
    Builder { f_ | onClosing = Just v_ }


{-| Dispatched when the sheet is cancelled. -}
onCancel :
    Json.Decode.Decoder msg
    -> Builder { a | onCancel : M3e.Build.Internal.Available } s msg
    -> Builder { a | onCancel : M3e.Build.Internal.Used } s msg
onCancel v_ (Builder f_) =
    Builder { f_ | onCancel = Just v_ }


{-| Dispatched when the sheet has opened. -}
onOpened :
    Json.Decode.Decoder msg
    -> Builder { a | onOpened : M3e.Build.Internal.Available } s msg
    -> Builder { a | onOpened : M3e.Build.Internal.Used } s msg
onOpened v_ (Builder f_) =
    Builder { f_ | onOpened = Just v_ }


{-| Dispatched when the sheet has closed. -}
onClosed :
    Json.Decode.Decoder msg
    -> Builder { a | onClosed : M3e.Build.Internal.Available } s msg
    -> Builder { a | onClosed : M3e.Build.Internal.Used } s msg
onClosed v_ (Builder f_) =
    Builder { f_ | onClosed = Just v_ }


{-| Set the `header` slot. Consumes the `header` slot capability. -}
header :
    M3e.Element.Element {} msg
    -> Builder a { s | header : M3e.Build.Internal.Available } msg
    -> Builder a { s | header : M3e.Build.Internal.Used } msg
header v_ (Builder f_) =
    Builder { f_ | header = Just v_ }