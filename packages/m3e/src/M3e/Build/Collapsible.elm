module M3e.Build.Collapsible exposing
    ( Builder, AttrCaps, SlotCaps, collapsible, open, orientation
    , noAnimate, onOpening, onOpened, onClosing, onClosed
    )

{-|
The ⑤ Build shape for `<m3e-collapsible>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Collapsible as Collapsible`.

@docs Builder, AttrCaps, SlotCaps, collapsible, open, orientation
@docs noAnimate, onOpening, onOpened, onClosing, onClosed
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-collapsible>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { open : M3e.Build.Internal.Available
    , orientation : M3e.Build.Internal.Available
    , noAnimate : M3e.Build.Internal.Available
    , onOpening : M3e.Build.Internal.Available
    , onOpened : M3e.Build.Internal.Available
    , onClosing : M3e.Build.Internal.Available
    , onClosed : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { open : Maybe Bool
    , orientation :
        Maybe (M3e.Value.Value { horizontal : M3e.Value.Supported
        , vertical : M3e.Value.Supported
        })
    , noAnimate : Maybe Bool
    , onOpening : Maybe (Json.Decode.Decoder msg)
    , onOpened : Maybe (Json.Decode.Decoder msg)
    , onClosing : Maybe (Json.Decode.Decoder msg)
    , onClosed : Maybe (Json.Decode.Decoder msg)
    , default : List (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-collapsible>`. -}
collapsible : Builder AttrCaps SlotCaps msg
collapsible =
    Builder
        { open = Nothing
        , orientation = Nothing
        , noAnimate = Nothing
        , onOpening = Nothing
        , onOpened = Nothing
        , onClosing = Nothing
        , onClosed = Nothing
        , default = []
        , phantomMsg_ = Nothing
        }


{-| Whether content is visible. (default: `false`) -}
open :
    Bool
    -> Builder { a | open : M3e.Build.Internal.Available } s msg
    -> Builder { a | open : M3e.Build.Internal.Used } s msg
open v_ (Builder f_) =
    Builder { f_ | open = Just v_ }


{-| Orientation of collapsible content. (default: `"vertical"`) -}
orientation :
    M3e.Value.Value { horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> Builder { a | orientation : M3e.Build.Internal.Available } s msg
    -> Builder { a | orientation : M3e.Build.Internal.Used } s msg
orientation v_ (Builder f_) =
    Builder { f_ | orientation = Just v_ }


{-| Whether to disable animation. (default: `false`) -}
noAnimate :
    Bool
    -> Builder { a | noAnimate : M3e.Build.Internal.Available } s msg
    -> Builder { a | noAnimate : M3e.Build.Internal.Used } s msg
noAnimate v_ (Builder f_) =
    Builder { f_ | noAnimate = Just v_ }


{-| Dispatched when the collapsible begins to open. -}
onOpening :
    Json.Decode.Decoder msg
    -> Builder { a | onOpening : M3e.Build.Internal.Available } s msg
    -> Builder { a | onOpening : M3e.Build.Internal.Used } s msg
onOpening v_ (Builder f_) =
    Builder { f_ | onOpening = Just v_ }


{-| Dispatched when the collapsible has opened. -}
onOpened :
    Json.Decode.Decoder msg
    -> Builder { a | onOpened : M3e.Build.Internal.Available } s msg
    -> Builder { a | onOpened : M3e.Build.Internal.Used } s msg
onOpened v_ (Builder f_) =
    Builder { f_ | onOpened = Just v_ }


{-| Dispatched when the collapsible begins to close. -}
onClosing :
    Json.Decode.Decoder msg
    -> Builder { a | onClosing : M3e.Build.Internal.Available } s msg
    -> Builder { a | onClosing : M3e.Build.Internal.Used } s msg
onClosing v_ (Builder f_) =
    Builder { f_ | onClosing = Just v_ }


{-| Dispatched when the collapsible has closed. -}
onClosed :
    Json.Decode.Decoder msg
    -> Builder { a | onClosed : M3e.Build.Internal.Available } s msg
    -> Builder { a | onClosed : M3e.Build.Internal.Used } s msg
onClosed v_ (Builder f_) =
    Builder { f_ | onClosed = Just v_ }