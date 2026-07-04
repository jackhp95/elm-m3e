module M3e.Build.NavMenuItem exposing
    ( Builder, AttrCaps, SlotCaps, navMenuItem, disabled, open
    , selected, onOpening, onOpened, onClosing, onClosed, onClick, icon
    , badge, selectedIcon, toggleIcon, default
    )

{-|
The ⑤ Build shape for `<m3e-nav-menu-item>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.NavMenuItem as NavMenuItem`.

@docs Builder, AttrCaps, SlotCaps, navMenuItem, disabled, open
@docs selected, onOpening, onOpened, onClosing, onClosed, onClick
@docs icon, badge, selectedIcon, toggleIcon, default
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-nav-menu-item>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , open : M3e.Build.Internal.Available
    , selected : M3e.Build.Internal.Available
    , onOpening : M3e.Build.Internal.Available
    , onOpened : M3e.Build.Internal.Available
    , onClosing : M3e.Build.Internal.Available
    , onClosed : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { icon : M3e.Build.Internal.Available
    , badge : M3e.Build.Internal.Available
    , selectedIcon : M3e.Build.Internal.Available
    , toggleIcon : M3e.Build.Internal.Available
    }


type alias Fields msg =
    { label :
        M3e.Element.Element { text : M3e.Value.Supported
        , link : M3e.Value.Supported
        } msg
    , disabled : Maybe Bool
    , open : Maybe Bool
    , selected : Maybe Bool
    , onOpening : Maybe (Json.Decode.Decoder msg)
    , onOpened : Maybe (Json.Decode.Decoder msg)
    , onClosing : Maybe (Json.Decode.Decoder msg)
    , onClosed : Maybe (Json.Decode.Decoder msg)
    , onClick : Maybe (Json.Decode.Decoder msg)
    , icon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , badge :
        Maybe (M3e.Element.Element { text : M3e.Value.Supported
        , badge : M3e.Value.Supported
        } msg)
    , selectedIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , toggleIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , default :
        List (M3e.Element.Element { navMenuItem : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-nav-menu-item>` with the required fields. -}
navMenuItem :
    { label :
        M3e.Element.Element { text : M3e.Value.Supported
        , link : M3e.Value.Supported
        } msg
    }
    -> Builder AttrCaps SlotCaps msg
navMenuItem req_ =
    Builder
        { label = req_.label
        , disabled = Nothing
        , open = Nothing
        , selected = Nothing
        , onOpening = Nothing
        , onOpened = Nothing
        , onClosing = Nothing
        , onClosed = Nothing
        , onClick = Nothing
        , icon = Nothing
        , badge = Nothing
        , selectedIcon = Nothing
        , toggleIcon = Nothing
        , default = []
        , phantomMsg_ = Nothing
        }


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| Whether the item is expanded. (default: `false`) -}
open :
    Bool
    -> Builder { a | open : M3e.Build.Internal.Available } s msg
    -> Builder { a | open : M3e.Build.Internal.Used } s msg
open v_ (Builder f_) =
    Builder { f_ | open = Just v_ }


{-| Whether the item is selected. (default: `false`) -}
selected :
    Bool
    -> Builder { a | selected : M3e.Build.Internal.Available } s msg
    -> Builder { a | selected : M3e.Build.Internal.Used } s msg
selected v_ (Builder f_) =
    Builder { f_ | selected = Just v_ }


{-| Dispatched when the item begins to open. -}
onOpening :
    Json.Decode.Decoder msg
    -> Builder { a | onOpening : M3e.Build.Internal.Available } s msg
    -> Builder { a | onOpening : M3e.Build.Internal.Used } s msg
onOpening v_ (Builder f_) =
    Builder { f_ | onOpening = Just v_ }


{-| Dispatched when the item has opened. -}
onOpened :
    Json.Decode.Decoder msg
    -> Builder { a | onOpened : M3e.Build.Internal.Available } s msg
    -> Builder { a | onOpened : M3e.Build.Internal.Used } s msg
onOpened v_ (Builder f_) =
    Builder { f_ | onOpened = Just v_ }


{-| Dispatched when the item begins to close. -}
onClosing :
    Json.Decode.Decoder msg
    -> Builder { a | onClosing : M3e.Build.Internal.Available } s msg
    -> Builder { a | onClosing : M3e.Build.Internal.Used } s msg
onClosing v_ (Builder f_) =
    Builder { f_ | onClosing = Just v_ }


{-| Dispatched when the item has closed. -}
onClosed :
    Json.Decode.Decoder msg
    -> Builder { a | onClosed : M3e.Build.Internal.Available } s msg
    -> Builder { a | onClosed : M3e.Build.Internal.Used } s msg
onClosed v_ (Builder f_) =
    Builder { f_ | onClosed = Just v_ }


{-| Dispatched when the element is clicked. -}
onClick :
    Json.Decode.Decoder msg
    -> Builder { a | onClick : M3e.Build.Internal.Available } s msg
    -> Builder { a | onClick : M3e.Build.Internal.Used } s msg
onClick v_ (Builder f_) =
    Builder { f_ | onClick = Just v_ }


{-| Set the `icon` slot. Consumes the `icon` slot capability. -}
icon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | icon : M3e.Build.Internal.Available } msg
    -> Builder a { s | icon : M3e.Build.Internal.Used } msg
icon v_ (Builder f_) =
    Builder { f_ | icon = Just v_ }


{-| Set the `badge` slot. Consumes the `badge` slot capability. -}
badge :
    M3e.Element.Element { text : M3e.Value.Supported
    , badge : M3e.Value.Supported
    } msg
    -> Builder a { s | badge : M3e.Build.Internal.Available } msg
    -> Builder a { s | badge : M3e.Build.Internal.Used } msg
badge v_ (Builder f_) =
    Builder { f_ | badge = Just v_ }


{-| Set the `selected-icon` slot. Consumes the `selectedIcon` slot capability. -}
selectedIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | selectedIcon : M3e.Build.Internal.Available } msg
    -> Builder a { s | selectedIcon : M3e.Build.Internal.Used } msg
selectedIcon v_ (Builder f_) =
    Builder { f_ | selectedIcon = Just v_ }


{-| Set the `toggle-icon` slot. Consumes the `toggleIcon` slot capability. -}
toggleIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | toggleIcon : M3e.Build.Internal.Available } msg
    -> Builder a { s | toggleIcon : M3e.Build.Internal.Used } msg
toggleIcon v_ (Builder f_) =
    Builder { f_ | toggleIcon = Just v_ }


{-| Add an element to the `unnamed` (multi) slot. -}
default :
    M3e.Element.Element { navMenuItem : M3e.Value.Supported } msg
    -> Builder a s msg
    -> Builder a s msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }