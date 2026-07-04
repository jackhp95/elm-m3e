module M3e.Build.RichTooltip exposing ( Builder, AttrCaps, SlotCaps, richTooltip )

{-|
The ⑤ Build shape for `<m3e-rich-tooltip>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.RichTooltip as RichTooltip`.

@docs Builder, AttrCaps, SlotCaps, richTooltip
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-rich-tooltip>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg any_ =
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg
    , disabled : Maybe Bool
    , for : Maybe String
    , hideDelay : Maybe Float
    , position :
        Maybe (M3e.Value.Value { above : M3e.Value.Supported
        , aboveAfter : M3e.Value.Supported
        , aboveBefore : M3e.Value.Supported
        , after : M3e.Value.Supported
        , before : M3e.Value.Supported
        , below : M3e.Value.Supported
        , belowAfter : M3e.Value.Supported
        , belowBefore : M3e.Value.Supported
        })
    , showDelay : Maybe Float
    , touchGestures :
        Maybe (M3e.Value.Value { auto : M3e.Value.Supported
        , off : M3e.Value.Supported
        , on : M3e.Value.Supported
        })
    , onBeforetoggle : Maybe (Json.Decode.Decoder msg)
    , onToggle : Maybe (Json.Decode.Decoder msg)
    , subhead : Maybe (M3e.Element.Element { text : M3e.Value.Supported } msg)
    , actions : Maybe (M3e.Element.Element any_ msg)
    }


{-| Seed a `Builder` for `<m3e-rich-tooltip>` with the required fields. -}
richTooltip :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> Builder AttrCaps SlotCaps msg
richTooltip req_ =
    Builder
        { content = req_.content
        , disabled = Nothing
        , for = Nothing
        , hideDelay = Nothing
        , position = Nothing
        , showDelay = Nothing
        , touchGestures = Nothing
        , onBeforetoggle = Nothing
        , onToggle = Nothing
        , subhead = Nothing
        , actions = Nothing
        }