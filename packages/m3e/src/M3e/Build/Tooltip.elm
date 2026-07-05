module M3e.Build.Tooltip exposing
    ( Builder, AttrCaps, SlotCaps, tooltip, disabled, for
    , hideDelay, position, showDelay, touchGestures, build
    )

{-|
The ⑤ Build shape for `<m3e-tooltip>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Tooltip as Tooltip`.

@docs Builder, AttrCaps, SlotCaps, tooltip, disabled, for
@docs hideDelay, position, showDelay, touchGestures, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Tooltip
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-tooltip>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | tooltip : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    , hideDelay : M3e.Build.Internal.Available
    , position : M3e.Build.Internal.Available
    , showDelay : M3e.Build.Internal.Available
    , touchGestures : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-tooltip>` with the required fields. -}
tooltip :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> Builder AttrCaps SlotCaps msg kind
tooltip req_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Tooltip.tooltip
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.map M3e.Cem.Attr.forget [])
             [ M3e.Element.toNode req_.content ]
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Tooltip.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg kind
    -> Builder { for : M3e.Build.Internal.Used } s msg kind
for v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Tooltip.for v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`) -}
hideDelay :
    Float
    -> Builder { a | hideDelay : M3e.Build.Internal.Available } s msg kind
    -> Builder { hideDelay : M3e.Build.Internal.Used } s msg kind
hideDelay v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Tooltip.hideDelay v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The position of the tooltip. (default: `"below"`) -}
position :
    M3e.Value.Value { above : M3e.Value.Supported
    , after : M3e.Value.Supported
    , before : M3e.Value.Supported
    , below : M3e.Value.Supported
    }
    -> Builder { a | position : M3e.Build.Internal.Available } s msg kind
    -> Builder { position : M3e.Build.Internal.Used } s msg kind
position v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Tooltip.position v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`) -}
showDelay :
    Float
    -> Builder { a | showDelay : M3e.Build.Internal.Available } s msg kind
    -> Builder { showDelay : M3e.Build.Internal.Used } s msg kind
showDelay v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Tooltip.showDelay v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The mode in which to handle touch gestures. (default: `"auto"`) -}
touchGestures :
    M3e.Value.Value { auto : M3e.Value.Supported
    , off : M3e.Value.Supported
    , on : M3e.Value.Supported
    }
    -> Builder { a | touchGestures : M3e.Build.Internal.Available } s msg kind
    -> Builder { touchGestures : M3e.Build.Internal.Used } s msg kind
touchGestures v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Tooltip.touchGestures v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-tooltip>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { tooltip : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)