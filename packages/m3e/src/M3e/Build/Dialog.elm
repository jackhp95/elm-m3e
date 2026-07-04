module M3e.Build.Dialog exposing
    ( Builder, AttrCaps, SlotCaps, dialog, alert, closeLabel
    , disableClose, dismissible, noFocusTrap, open, onOpening, onOpened, onClosing
    , onClosed, onCancel, header, actions, closeIcon, default
    )

{-|
The ⑤ Build shape for `<m3e-dialog>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Dialog as Dialog`.

@docs Builder, AttrCaps, SlotCaps, dialog, alert, closeLabel
@docs disableClose, dismissible, noFocusTrap, open, onOpening, onOpened
@docs onClosing, onClosed, onCancel, header, actions, closeIcon
@docs default
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-dialog>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { alert : M3e.Build.Internal.Available
    , closeLabel : M3e.Build.Internal.Available
    , disableClose : M3e.Build.Internal.Available
    , dismissible : M3e.Build.Internal.Available
    , noFocusTrap : M3e.Build.Internal.Available
    , open : M3e.Build.Internal.Available
    , onOpening : M3e.Build.Internal.Available
    , onOpened : M3e.Build.Internal.Available
    , onClosing : M3e.Build.Internal.Available
    , onClosed : M3e.Build.Internal.Available
    , onCancel : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { header : M3e.Build.Internal.Available
    , actions : M3e.Build.Internal.Available
    , closeIcon : M3e.Build.Internal.Available
    }


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


{-| Whether the dialog is an alert. (default: `false`) -}
alert :
    Bool
    -> Builder { a | alert : M3e.Build.Internal.Available } s msg
    -> Builder { a | alert : M3e.Build.Internal.Used } s msg
alert v_ (Builder f_) =
    Builder { f_ | alert = Just v_ }


{-| The accessible label given to the button used to dismiss the dialog. (default: `"Close"`) -}
closeLabel :
    String
    -> Builder { a | closeLabel : M3e.Build.Internal.Available } s msg
    -> Builder { a | closeLabel : M3e.Build.Internal.Used } s msg
closeLabel v_ (Builder f_) =
    Builder { f_ | closeLabel = Just v_ }


{-| Whether users cannot click the backdrop or press ESC to dismiss the dialog. (default: `false`) -}
disableClose :
    Bool
    -> Builder { a | disableClose : M3e.Build.Internal.Available } s msg
    -> Builder { a | disableClose : M3e.Build.Internal.Used } s msg
disableClose v_ (Builder f_) =
    Builder { f_ | disableClose = Just v_ }


{-| Whether a button is presented that can be used to close the dialog. (default: `false`) -}
dismissible :
    Bool
    -> Builder { a | dismissible : M3e.Build.Internal.Available } s msg
    -> Builder { a | dismissible : M3e.Build.Internal.Used } s msg
dismissible v_ (Builder f_) =
    Builder { f_ | dismissible = Just v_ }


{-| Whether to disable focus trapping, which keeps keyboard `Tab` navigation within the dialog. (default: `false`) -}
noFocusTrap :
    Bool
    -> Builder { a | noFocusTrap : M3e.Build.Internal.Available } s msg
    -> Builder { a | noFocusTrap : M3e.Build.Internal.Used } s msg
noFocusTrap v_ (Builder f_) =
    Builder { f_ | noFocusTrap = Just v_ }


{-| Whether the dialog is open. (default: `false`) -}
open :
    String
    -> Builder { a | open : M3e.Build.Internal.Available } s msg
    -> Builder { a | open : M3e.Build.Internal.Used } s msg
open v_ (Builder f_) =
    Builder { f_ | open = Just v_ }


{-| Dispatched when the dialog begins to open. -}
onOpening :
    Json.Decode.Decoder msg
    -> Builder { a | onOpening : M3e.Build.Internal.Available } s msg
    -> Builder { a | onOpening : M3e.Build.Internal.Used } s msg
onOpening v_ (Builder f_) =
    Builder { f_ | onOpening = Just v_ }


{-| Dispatched when the dialog has opened. -}
onOpened :
    Json.Decode.Decoder msg
    -> Builder { a | onOpened : M3e.Build.Internal.Available } s msg
    -> Builder { a | onOpened : M3e.Build.Internal.Used } s msg
onOpened v_ (Builder f_) =
    Builder { f_ | onOpened = Just v_ }


{-| Dispatched when the dialog begins to close. -}
onClosing :
    Json.Decode.Decoder msg
    -> Builder { a | onClosing : M3e.Build.Internal.Available } s msg
    -> Builder { a | onClosing : M3e.Build.Internal.Used } s msg
onClosing v_ (Builder f_) =
    Builder { f_ | onClosing = Just v_ }


{-| Dispatched when the dialog has closed. -}
onClosed :
    Json.Decode.Decoder msg
    -> Builder { a | onClosed : M3e.Build.Internal.Available } s msg
    -> Builder { a | onClosed : M3e.Build.Internal.Used } s msg
onClosed v_ (Builder f_) =
    Builder { f_ | onClosed = Just v_ }


{-| Dispatched when the dialog is cancelled. -}
onCancel :
    Json.Decode.Decoder msg
    -> Builder { a | onCancel : M3e.Build.Internal.Available } s msg
    -> Builder { a | onCancel : M3e.Build.Internal.Used } s msg
onCancel v_ (Builder f_) =
    Builder { f_ | onCancel = Just v_ }


{-| Set the `header` slot. Consumes the `header` slot capability. -}
header :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> Builder a { s | header : M3e.Build.Internal.Available } msg
    -> Builder a { s | header : M3e.Build.Internal.Used } msg
header v_ (Builder f_) =
    Builder { f_ | header = Just v_ }


{-| Set the `actions` slot. Consumes the `actions` slot capability. -}
actions :
    M3e.Element.Element {} msg
    -> Builder a { s | actions : M3e.Build.Internal.Available } msg
    -> Builder a { s | actions : M3e.Build.Internal.Used } msg
actions v_ (Builder f_) =
    Builder { f_ | actions = Just v_ }


{-| Set the `close-icon` slot. Consumes the `closeIcon` slot capability. -}
closeIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | closeIcon : M3e.Build.Internal.Available } msg
    -> Builder a { s | closeIcon : M3e.Build.Internal.Used } msg
closeIcon v_ (Builder f_) =
    Builder { f_ | closeIcon = Just v_ }


{-| Add an element to the `unnamed` (multi) slot. -}
default : M3e.Element.Element {} msg -> Builder a s msg -> Builder a s msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }