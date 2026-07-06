module M3e.Build.InputChip exposing
    ( Builder, AttrCaps, SlotCaps, inputChip, disabled, disabledInteractive
    , removable, removeLabel, value, variant, onRemove, onClick, avatar
    , icon, removeIcon, build
    )

{-|
The ⑤ Build shape for `<m3e-input-chip>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.InputChip as InputChip`.

@docs Builder, AttrCaps, SlotCaps, inputChip, disabled, disabledInteractive
@docs removable, removeLabel, value, variant, onRemove, onClick
@docs avatar, icon, removeIcon, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.InputChip
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-input-chip>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | inputChip : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , disabledInteractive : M3e.Build.Internal.Available
    , removable : M3e.Build.Internal.Available
    , removeLabel : M3e.Build.Internal.Available
    , value : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    , onRemove : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { avatar : M3e.Build.Internal.Available
    , icon : M3e.Build.Internal.Available
    , removeIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-input-chip>` with the required fields. -}
inputChip :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> Builder AttrCaps SlotCaps msg kind
inputChip req_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.InputChip.inputChip
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             [ M3e.Element.toNode req_.content ]
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.InputChip.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive :
    Bool
    -> Builder { a
        | disabledInteractive : M3e.Build.Internal.Available
    } s msg kind
    -> Builder { a | disabledInteractive : M3e.Build.Internal.Used } s msg kind
disabledInteractive v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.InputChip.disabledInteractive v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the chip is removable. (default: `false`) -}
removable :
    Bool
    -> Builder { a | removable : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | removable : M3e.Build.Internal.Used } s msg kind
removable v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.InputChip.removable v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to remove the chip. (default: `"Remove"`) -}
removeLabel :
    String
    -> Builder { a | removeLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | removeLabel : M3e.Build.Internal.Used } s msg kind
removeLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.InputChip.removeLabel v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| A string representing the value of the chip. -}
value :
    String
    -> Builder { a | value : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | value : M3e.Build.Internal.Used } s msg kind
value v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.InputChip.value v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The appearance variant of the chip. (default: `"outlined"`) -}
variant :
    M3e.Value.Value { elevated : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.InputChip.variant v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the remove button is clicked or DELETE or BACKSPACE key is pressed. -}
onRemove :
    msg
    -> Builder { a | onRemove : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onRemove : M3e.Build.Internal.Used } s msg kind
onRemove v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.InputChip.onRemove v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the element is clicked. -}
onClick :
    msg
    -> Builder { a | onClick : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClick : M3e.Build.Internal.Used } s msg kind
onClick v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.InputChip.onClick v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `avatar` slot. -}
avatar :
    M3e.Element.Element { avatar : M3e.Value.Supported } msg
    -> Builder a { s | avatar : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | avatar : M3e.Build.Internal.Used } msg kind
avatar el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "avatar" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `icon` slot. -}
icon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | icon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | icon : M3e.Build.Internal.Used } msg kind
icon el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "icon" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `remove-icon` slot. -}
removeIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | removeIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | removeIcon : M3e.Build.Internal.Used } msg kind
removeIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "remove-icon" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-input-chip>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { inputChip : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)