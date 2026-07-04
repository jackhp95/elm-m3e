module M3e.Build.Tooltip exposing ( Builder, AttrCaps, SlotCaps, tooltip )

{-|
The ⑤ Build shape for `<m3e-tooltip>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Tooltip as Tooltip`.

@docs Builder, AttrCaps, SlotCaps, tooltip
-}


import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-tooltip>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg
    , disabled : Maybe Bool
    , for : Maybe String
    , hideDelay : Maybe Float
    , position :
        Maybe (M3e.Value.Value { above : M3e.Value.Supported
        , after : M3e.Value.Supported
        , before : M3e.Value.Supported
        , below : M3e.Value.Supported
        })
    , showDelay : Maybe Float
    , touchGestures :
        Maybe (M3e.Value.Value { auto : M3e.Value.Supported
        , off : M3e.Value.Supported
        , on : M3e.Value.Supported
        })
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-tooltip>` with the required fields. -}
tooltip :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> Builder AttrCaps SlotCaps msg
tooltip req_ =
    Builder
        { content = req_.content
        , disabled = Nothing
        , for = Nothing
        , hideDelay = Nothing
        , position = Nothing
        , showDelay = Nothing
        , touchGestures = Nothing
        , phantomMsg_ = Nothing
        }