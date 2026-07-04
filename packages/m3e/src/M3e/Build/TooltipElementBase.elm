module M3e.Build.TooltipElementBase exposing
    ( Builder, AttrCaps, SlotCaps, tooltipElementBase, disabled, showDelay
    , hideDelay, touchGestures, for
    )

{-|
The ⑤ Build shape for `<TooltipElementBase>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.TooltipElementBase as TooltipElementBase`.

@docs Builder, AttrCaps, SlotCaps, tooltipElementBase, disabled, showDelay
@docs hideDelay, touchGestures, for
-}


import M3e.Build.Internal
import M3e.Value


{-| Opaque builder for `<TooltipElementBase>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , showDelay : M3e.Build.Internal.Available
    , hideDelay : M3e.Build.Internal.Available
    , touchGestures : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { disabled : Maybe Bool
    , showDelay : Maybe Float
    , hideDelay : Maybe Float
    , touchGestures :
        Maybe (M3e.Value.Value { auto : M3e.Value.Supported
        , off : M3e.Value.Supported
        , on : M3e.Value.Supported
        })
    , for : Maybe String
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<TooltipElementBase>`. -}
tooltipElementBase : Builder AttrCaps SlotCaps msg
tooltipElementBase =
    Builder
        { disabled = Nothing
        , showDelay = Nothing
        , hideDelay = Nothing
        , touchGestures = Nothing
        , for = Nothing
        , phantomMsg_ = Nothing
        }


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`) -}
showDelay :
    Float
    -> Builder { a | showDelay : M3e.Build.Internal.Available } s msg
    -> Builder { a | showDelay : M3e.Build.Internal.Used } s msg
showDelay v_ (Builder f_) =
    Builder { f_ | showDelay = Just v_ }


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`) -}
hideDelay :
    Float
    -> Builder { a | hideDelay : M3e.Build.Internal.Available } s msg
    -> Builder { a | hideDelay : M3e.Build.Internal.Used } s msg
hideDelay v_ (Builder f_) =
    Builder { f_ | hideDelay = Just v_ }


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


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg
    -> Builder { a | for : M3e.Build.Internal.Used } s msg
for v_ (Builder f_) =
    Builder { f_ | for = Just v_ }