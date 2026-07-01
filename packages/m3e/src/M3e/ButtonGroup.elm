module M3e.ButtonGroup exposing (buttonGroup, child, children, multi, size, variant)

{-| 
@docs buttonGroup, multi, size, variant, child, children
-}


import M3e.Cem.Attr
import M3e.Cem.ButtonGroup
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-button-group>` element (lazy IR). -}
buttonGroup :
    List (M3e.Cem.Attr.Attr { multi : M3e.Value.Supported
    , size : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | buttonGroup : M3e.Value.Supported } msg
buttonGroup attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.ButtonGroup.buttonGroup
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Content.toNode content_)
        )


{-| Whether multiple toggle buttons can be selected. (default: `false`) -}
multi : Bool -> M3e.Cem.Attr.Attr { c | multi : M3e.Value.Supported } msg
multi =
    M3e.Cem.ButtonGroup.multi


{-| The size of the group. (default: `"small"`) -}
size :
    M3e.Value.Value { extraLarge : M3e.Value.Supported
    , extraSmall : M3e.Value.Supported
    , large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | size : M3e.Value.Supported } msg
size =
    M3e.Cem.ButtonGroup.size


{-| The appearance variant of the group. (default: `"standard"`) -}
variant :
    M3e.Value.Value { connected : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.ButtonGroup.variant


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { button : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { button : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els