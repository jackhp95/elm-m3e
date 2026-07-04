module M3e.Build.RichTooltip exposing
    ( Builder, AttrCaps, SlotCaps, richTooltip, disabled, for
    , hideDelay, position, showDelay, touchGestures, onBeforetoggle, onToggle, subhead
    , actions
    )

{-|
The ⑤ Build shape for `<m3e-rich-tooltip>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.RichTooltip as RichTooltip`.

@docs Builder, AttrCaps, SlotCaps, richTooltip, disabled, for
@docs hideDelay, position, showDelay, touchGestures, onBeforetoggle, onToggle
@docs subhead, actions
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-rich-tooltip>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    , hideDelay : M3e.Build.Internal.Available
    , position : M3e.Build.Internal.Available
    , showDelay : M3e.Build.Internal.Available
    , touchGestures : M3e.Build.Internal.Available
    , onBeforetoggle : M3e.Build.Internal.Available
    , onToggle : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { subhead : M3e.Build.Internal.Available
    , actions : M3e.Build.Internal.Available
    }


type alias Fields msg =
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
    , actions : Maybe (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
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
        , phantomMsg_ = Nothing
        }


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg
    -> Builder { a | for : M3e.Build.Internal.Used } s msg
for v_ (Builder f_) =
    Builder { f_ | for = Just v_ }


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`) -}
hideDelay :
    Float
    -> Builder { a | hideDelay : M3e.Build.Internal.Available } s msg
    -> Builder { a | hideDelay : M3e.Build.Internal.Used } s msg
hideDelay v_ (Builder f_) =
    Builder { f_ | hideDelay = Just v_ }


{-| The position of the tooltip. (default: `"below-after"`) -}
position :
    M3e.Value.Value { above : M3e.Value.Supported
    , aboveAfter : M3e.Value.Supported
    , aboveBefore : M3e.Value.Supported
    , after : M3e.Value.Supported
    , before : M3e.Value.Supported
    , below : M3e.Value.Supported
    , belowAfter : M3e.Value.Supported
    , belowBefore : M3e.Value.Supported
    }
    -> Builder { a | position : M3e.Build.Internal.Available } s msg
    -> Builder { a | position : M3e.Build.Internal.Used } s msg
position v_ (Builder f_) =
    Builder { f_ | position = Just v_ }


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`) -}
showDelay :
    Float
    -> Builder { a | showDelay : M3e.Build.Internal.Available } s msg
    -> Builder { a | showDelay : M3e.Build.Internal.Used } s msg
showDelay v_ (Builder f_) =
    Builder { f_ | showDelay = Just v_ }


{-| The mode in which to handle touch gestures. (default: `"auto"`) -}
touchGestures :
    M3e.Value.Value { auto : M3e.Value.Supported
    , off : M3e.Value.Supported
    , on : M3e.Value.Supported
    }
    -> Builder { a | touchGestures : M3e.Build.Internal.Available } s msg
    -> Builder { a | touchGestures : M3e.Build.Internal.Used } s msg
touchGestures v_ (Builder f_) =
    Builder { f_ | touchGestures = Just v_ }


{-| Dispatched before the toggle state changes. -}
onBeforetoggle :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforetoggle : M3e.Build.Internal.Available } s msg
    -> Builder { a | onBeforetoggle : M3e.Build.Internal.Used } s msg
onBeforetoggle v_ (Builder f_) =
    Builder { f_ | onBeforetoggle = Just v_ }


{-| Dispatched after the toggle state has changed. -}
onToggle :
    Json.Decode.Decoder msg
    -> Builder { a | onToggle : M3e.Build.Internal.Available } s msg
    -> Builder { a | onToggle : M3e.Build.Internal.Used } s msg
onToggle v_ (Builder f_) =
    Builder { f_ | onToggle = Just v_ }


{-| Set the `subhead` slot. Consumes the `subhead` slot capability. -}
subhead :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> Builder a { s | subhead : M3e.Build.Internal.Available } msg
    -> Builder a { s | subhead : M3e.Build.Internal.Used } msg
subhead v_ (Builder f_) =
    Builder { f_ | subhead = Just v_ }


{-| Set the `actions` slot. Consumes the `actions` slot capability. -}
actions :
    M3e.Element.Element {} msg
    -> Builder a { s | actions : M3e.Build.Internal.Available } msg
    -> Builder a { s | actions : M3e.Build.Internal.Used } msg
actions v_ (Builder f_) =
    Builder { f_ | actions = Just v_ }