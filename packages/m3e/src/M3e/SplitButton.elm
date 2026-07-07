module M3e.SplitButton exposing
    ( view, variant, size, leadingButton, trailingButton
    )

{-|
A button used to show an action with a menu of related actions.

**Component Info:**
- **Extends:** `LitElement`

**Slots:**
- `leading-button`: The leading button used to perform the primary action.
- `trailing-button`: The trailing icon button used to open a menu of related actions.

@docs view, variant, size, leadingButton, trailingButton
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.SplitButton
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-split-button>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { variant : M3e.Value.Supported
    , size : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | splitButton : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.SplitButton.splitButton
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| The appearance variant of the button. (default: `"filled"`) -}
variant :
    M3e.Value.Value { elevated : M3e.Value.Supported
    , filled : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    , tonal : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.SplitButton.variant


{-| The size of the button. (default: `"small"`) -}
size :
    M3e.Value.Value { extraLarge : M3e.Value.Supported
    , extraSmall : M3e.Value.Supported
    , large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | size : M3e.Value.Supported } msg
size =
    M3e.Cem.SplitButton.size


{-| Place content in the `leading-button` slot. -}
leadingButton :
    M3e.Element.Element { button : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
leadingButton el =
    M3e.Element.Internal.placeSlot "leading-button" el


{-| Place content in the `trailing-button` slot. -}
trailingButton :
    M3e.Element.Element { iconButton : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
trailingButton el =
    M3e.Element.Internal.placeSlot "trailing-button" el