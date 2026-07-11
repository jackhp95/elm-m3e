module M3e.InputChip exposing
    ( view, disabled, disabledInteractive, removable, removeLabel, value
    , variant, onRemove, onClick, avatar, icon, removeIcon
    )

{-| A chip which represents a discrete piece of information entered by a user.

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

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.InputChip
import M3e.Node
import M3e.Token


{-| Build the `<m3e-input-chip>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , disabledInteractive : M3e.Token.Supported
            , removable : M3e.Token.Supported
            , removeLabel : M3e.Token.Supported
            , value : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , onRemove : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element { text : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | inputChip : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.InputChip.inputChip
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.InputChip.disabled


{-| Whether the element is disabled and interactive. (default: `false`)
-}
disabledInteractive :
    Bool
    -> M3e.Html.Attr.Attr { c | disabledInteractive : M3e.Token.Supported } msg
disabledInteractive =
    M3e.Html.InputChip.disabledInteractive


{-| Whether the chip is removable. (default: `false`)
-}
removable : Bool -> M3e.Html.Attr.Attr { c | removable : M3e.Token.Supported } msg
removable =
    M3e.Html.InputChip.removable


{-| The accessible label given to the button used to remove the chip. (default: `"Remove"`)
-}
removeLabel : String -> M3e.Html.Attr.Attr { c | removeLabel : M3e.Token.Supported } msg
removeLabel =
    M3e.Html.InputChip.removeLabel


{-| A string representing the value of the chip.
-}
value : String -> M3e.Html.Attr.Attr { c | value : M3e.Token.Supported } msg
value =
    M3e.Html.InputChip.value


{-| The appearance variant of the chip. (default: `"outlined"`)
-}
variant :
    M3e.Token.Value
        { elevated : M3e.Token.Supported
        , outlined : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant =
    M3e.Html.InputChip.variant


{-| Listen for `remove` events.
-}
onRemove : msg -> M3e.Html.Attr.Attr { c | onRemove : M3e.Token.Supported } msg
onRemove =
    M3e.Html.InputChip.onRemove


{-| Listen for `click` events.
-}
onClick : msg -> M3e.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick =
    M3e.Html.InputChip.onClick


{-| Place content in the `avatar` slot.
-}
avatar :
    M3e.Element.Element { avatar : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
avatar el =
    M3e.Element.Internal.placeSlot "avatar" el


{-| Place content in the `icon` slot.
-}
icon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
icon el =
    M3e.Element.Internal.placeSlot "icon" el


{-| Place content in the `remove-icon` slot.
-}
removeIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
removeIcon el =
    M3e.Element.Internal.placeSlot "remove-icon" el
