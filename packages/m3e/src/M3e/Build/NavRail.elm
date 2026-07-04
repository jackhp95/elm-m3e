module M3e.Build.NavRail exposing
    ( Builder, AttrCaps, SlotCaps, navRail, mode, onBeforeinput
    , onInput, onChange
    )

{-|
The ⑤ Build shape for `<m3e-nav-rail>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.NavRail as NavRail`.

@docs Builder, AttrCaps, SlotCaps, navRail, mode, onBeforeinput
@docs onInput, onChange
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-nav-rail>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { mode : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { mode :
        Maybe (M3e.Value.Value { auto : M3e.Value.Supported
        , compact : M3e.Value.Supported
        , expanded : M3e.Value.Supported
        })
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , onChange : Maybe (Json.Decode.Decoder msg)
    , default :
        List (M3e.Element.Element { navItem : M3e.Value.Supported
        , iconButton : M3e.Value.Supported
        , fab : M3e.Value.Supported
        } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-nav-rail>`. -}
navRail : Builder AttrCaps SlotCaps msg
navRail =
    Builder
        { mode = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , onChange = Nothing
        , default = []
        , phantomMsg_ = Nothing
        }


{-| The mode in which items in the rail are presented. (default: `"compact"`) -}
mode :
    M3e.Value.Value { auto : M3e.Value.Supported
    , compact : M3e.Value.Supported
    , expanded : M3e.Value.Supported
    }
    -> Builder { a | mode : M3e.Build.Internal.Available } s msg
    -> Builder { a | mode : M3e.Build.Internal.Used } s msg
mode v_ (Builder f_) =
    Builder { f_ | mode = Just v_ }


{-| Dispatched before the selected state of an item changes. -}
onBeforeinput :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg
onBeforeinput v_ (Builder f_) =
    Builder { f_ | onBeforeinput = Just v_ }


{-| Dispatched when the selected state of an item changes. -}
onInput :
    Json.Decode.Decoder msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg
onInput v_ (Builder f_) =
    Builder { f_ | onInput = Just v_ }


{-| Dispatched when the selected state of an item changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg
onChange v_ (Builder f_) =
    Builder { f_ | onChange = Just v_ }