module M3e.Build.ExpansionPanel exposing
    ( Builder, AttrCaps, SlotCaps, expansionPanel, disabled, hideToggle
    , open, toggleDirection, togglePosition, onOpening, onOpened, onClosing, onClosed
    , default, header, toggleIcon
    )

{-|
The ⑤ Build shape for `<m3e-expansion-panel>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ExpansionPanel as ExpansionPanel`.

@docs Builder, AttrCaps, SlotCaps, expansionPanel, disabled, hideToggle
@docs open, toggleDirection, togglePosition, onOpening, onOpened, onClosing
@docs onClosed, default, header, toggleIcon
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-expansion-panel>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , hideToggle : M3e.Build.Internal.Available
    , open : M3e.Build.Internal.Available
    , toggleDirection : M3e.Build.Internal.Available
    , togglePosition : M3e.Build.Internal.Available
    , onOpening : M3e.Build.Internal.Available
    , onOpened : M3e.Build.Internal.Available
    , onClosing : M3e.Build.Internal.Available
    , onClosed : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available
    , header : M3e.Build.Internal.Available
    , toggleIcon : M3e.Build.Internal.Available
    }


type alias Fields msg =
    { disabled : Maybe Bool
    , hideToggle : Maybe Bool
    , open : Maybe Bool
    , toggleDirection :
        Maybe (M3e.Value.Value { horizontal : M3e.Value.Supported
        , vertical : M3e.Value.Supported
        })
    , togglePosition :
        Maybe (M3e.Value.Value { after : M3e.Value.Supported
        , before : M3e.Value.Supported
        })
    , onOpening : Maybe (Json.Decode.Decoder msg)
    , onOpened : Maybe (Json.Decode.Decoder msg)
    , onClosing : Maybe (Json.Decode.Decoder msg)
    , onClosed : Maybe (Json.Decode.Decoder msg)
    , default : Maybe (M3e.Element.Element {} msg)
    , header : Maybe (M3e.Element.Element {} msg)
    , toggleIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , actions : List (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-expansion-panel>`. -}
expansionPanel : Builder AttrCaps SlotCaps msg
expansionPanel =
    Builder
        { disabled = Nothing
        , hideToggle = Nothing
        , open = Nothing
        , toggleDirection = Nothing
        , togglePosition = Nothing
        , onOpening = Nothing
        , onOpened = Nothing
        , onClosing = Nothing
        , onClosed = Nothing
        , default = Nothing
        , header = Nothing
        , toggleIcon = Nothing
        , actions = []
        , phantomMsg_ = Nothing
        }


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| Whether to hide the expansion toggle. (default: `false`) -}
hideToggle :
    Bool
    -> Builder { a | hideToggle : M3e.Build.Internal.Available } s msg
    -> Builder { a | hideToggle : M3e.Build.Internal.Used } s msg
hideToggle v_ (Builder f_) =
    Builder { f_ | hideToggle = Just v_ }


{-| Whether the panel is expanded. (default: `false`) -}
open :
    Bool
    -> Builder { a | open : M3e.Build.Internal.Available } s msg
    -> Builder { a | open : M3e.Build.Internal.Used } s msg
open v_ (Builder f_) =
    Builder { f_ | open = Just v_ }


{-| The direction of the expansion toggle. (default: `"vertical"`) -}
toggleDirection :
    M3e.Value.Value { horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> Builder { a | toggleDirection : M3e.Build.Internal.Available } s msg
    -> Builder { a | toggleDirection : M3e.Build.Internal.Used } s msg
toggleDirection v_ (Builder f_) =
    Builder { f_ | toggleDirection = Just v_ }


{-| The position of the expansion toggle. (default: `"after"`) -}
togglePosition :
    M3e.Value.Value { after : M3e.Value.Supported
    , before : M3e.Value.Supported
    }
    -> Builder { a | togglePosition : M3e.Build.Internal.Available } s msg
    -> Builder { a | togglePosition : M3e.Build.Internal.Used } s msg
togglePosition v_ (Builder f_) =
    Builder { f_ | togglePosition = Just v_ }


{-| Dispatched when the expansion panel begins to open. -}
onOpening :
    Json.Decode.Decoder msg
    -> Builder { a | onOpening : M3e.Build.Internal.Available } s msg
    -> Builder { a | onOpening : M3e.Build.Internal.Used } s msg
onOpening v_ (Builder f_) =
    Builder { f_ | onOpening = Just v_ }


{-| Dispatched when the expansion panel has opened. -}
onOpened :
    Json.Decode.Decoder msg
    -> Builder { a | onOpened : M3e.Build.Internal.Available } s msg
    -> Builder { a | onOpened : M3e.Build.Internal.Used } s msg
onOpened v_ (Builder f_) =
    Builder { f_ | onOpened = Just v_ }


{-| Dispatched when the expansion panel begins to close. -}
onClosing :
    Json.Decode.Decoder msg
    -> Builder { a | onClosing : M3e.Build.Internal.Available } s msg
    -> Builder { a | onClosing : M3e.Build.Internal.Used } s msg
onClosing v_ (Builder f_) =
    Builder { f_ | onClosing = Just v_ }


{-| Dispatched when the expansion panel has closed. -}
onClosed :
    Json.Decode.Decoder msg
    -> Builder { a | onClosed : M3e.Build.Internal.Available } s msg
    -> Builder { a | onClosed : M3e.Build.Internal.Used } s msg
onClosed v_ (Builder f_) =
    Builder { f_ | onClosed = Just v_ }


{-| Set the `unnamed` slot. Consumes the `default` slot capability. -}
default :
    M3e.Element.Element {} msg
    -> Builder a { s | default : M3e.Build.Internal.Available } msg
    -> Builder a { s | default : M3e.Build.Internal.Used } msg
default v_ (Builder f_) =
    Builder { f_ | default = Just v_ }


{-| Set the `header` slot. Consumes the `header` slot capability. -}
header :
    M3e.Element.Element {} msg
    -> Builder a { s | header : M3e.Build.Internal.Available } msg
    -> Builder a { s | header : M3e.Build.Internal.Used } msg
header v_ (Builder f_) =
    Builder { f_ | header = Just v_ }


{-| Set the `toggle-icon` slot. Consumes the `toggleIcon` slot capability. -}
toggleIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | toggleIcon : M3e.Build.Internal.Available } msg
    -> Builder a { s | toggleIcon : M3e.Build.Internal.Used } msg
toggleIcon v_ (Builder f_) =
    Builder { f_ | toggleIcon = Just v_ }