module M3e.Record.Chip exposing
    ( view, value, variant, icon, trailingIcon
    )

{-|
A non-interactive chip used to convey small pieces of information.

**Component Info:**
- **Extends:** `LitElement`

**Slots:**
- `icon`: Renders an icon before the chip's label.
- `trailing-icon`: Renders an icon after the chip's label.

@docs view, value, variant, icon, trailingIcon
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Chip
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-chip>` element (lazy IR). -}
view :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> List (M3e.Cem.Attr.Attr { value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | chip : M3e.Value.Supported } msg
view req_ attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Chip.chip
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.append
                  [ M3e.Element.toNode req_.content ]
                  (List.map M3e.Element.toNode content_)
             )
        )


{-| A string representing the value of the chip. -}
value : String -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.Chip.value


{-| The appearance variant of the chip. (default: `"outlined"`) -}
variant :
    M3e.Value.Value { elevated : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.Chip.variant


{-| Place content in the `icon` slot. -}
icon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
icon el =
    M3e.Element.Internal.placeSlot "icon" el


{-| Place content in the `trailing-icon` slot. -}
trailingIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
trailingIcon el =
    M3e.Element.Internal.placeSlot "trailing-icon" el