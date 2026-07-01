module M3e.Chip exposing (chip, icon, trailingIcon, value, variant)

{-| 
@docs chip, value, variant, icon, trailingIcon
-}


import M3e.Cem.Attr
import M3e.Cem.Chip
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-chip>` element (lazy IR). -}
chip :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> List (M3e.Cem.Attr.Attr { value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { icon : M3e.Value.Supported
    , trailingIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | chip : M3e.Value.Supported } msg
chip req_ attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.Chip.chip (List.map M3e.Cem.Attr.forget erased) ch
            )
            (List.append
                []
                (List.append [] (List.map M3e.Cem.Attr.forget attributes))
            )
            (List.append
                [ M3e.Element.toNode req_.content ]
                (List.map M3e.Content.toNode content_)
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
    -> M3e.Content.Content { r | icon : M3e.Value.Supported } msg
icon el =
    M3e.Content.slot "icon" el


{-| Place content in the `trailing-icon` slot. -}
trailingIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | trailingIcon : M3e.Value.Supported } msg
trailingIcon el =
    M3e.Content.slot "trailing-icon" el