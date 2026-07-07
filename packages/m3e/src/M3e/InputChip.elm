module M3e.InputChip exposing
    ( view, disabled, disabledInteractive, removable, removeLabel, value
    , variant, onRemove, onClick, avatar, icon, removeIcon
    )

{-|
A chip which represents a discrete piece of information entered by a user.

**Component Info:**
- **Extends:** `M3eChipElement` from `/src/chips/ChipElement`

**Events:**
- `remove`: Dispatched when the remove button is clicked or DELETE or BACKSPACE key is pressed.
- `click`: Dispatched when the element is clicked.

**Slots:**
- `avatar`: Renders an avatar before the chip's label.
- `icon`: Renders an icon before the chip's label.
- `remove-icon`: Renders the icon for the button used to remove the chip.
- `trailing-icon`: Renders an icon after the chip's label.

@docs view, disabled, disabledInteractive, removable, removeLabel, value
@docs variant, onRemove, onClick, avatar, icon, removeIcon
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.InputChip
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-input-chip>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , removable : M3e.Value.Supported
    , removeLabel : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , onRemove : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element { text : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | inputChip : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.InputChip.inputChip
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.InputChip.disabled


{-| Whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive :
    Bool
    -> M3e.Cem.Attr.Attr { c | disabledInteractive : M3e.Value.Supported } msg
disabledInteractive =
    M3e.Cem.InputChip.disabledInteractive


{-| Whether the chip is removable. (default: `false`) -}
removable :
    Bool -> M3e.Cem.Attr.Attr { c | removable : M3e.Value.Supported } msg
removable =
    M3e.Cem.InputChip.removable


{-| The accessible label given to the button used to remove the chip. (default: `"Remove"`) -}
removeLabel :
    String -> M3e.Cem.Attr.Attr { c | removeLabel : M3e.Value.Supported } msg
removeLabel =
    M3e.Cem.InputChip.removeLabel


{-| A string representing the value of the chip. -}
value : String -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.InputChip.value


{-| The appearance variant of the chip. (default: `"outlined"`) -}
variant :
    M3e.Value.Value { elevated : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.InputChip.variant


{-| Listen for `remove` events. -}
onRemove : msg -> M3e.Cem.Attr.Attr { c | onRemove : M3e.Value.Supported } msg
onRemove =
    M3e.Cem.InputChip.onRemove


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick =
    M3e.Cem.InputChip.onClick


{-| Place content in the `avatar` slot. -}
avatar :
    M3e.Element.Element { avatar : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
avatar el =
    M3e.Element.Internal.placeSlot "avatar" el


{-| Place content in the `icon` slot. -}
icon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
icon el =
    M3e.Element.Internal.placeSlot "icon" el


{-| Place content in the `remove-icon` slot. -}
removeIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
removeIcon el =
    M3e.Element.Internal.placeSlot "remove-icon" el