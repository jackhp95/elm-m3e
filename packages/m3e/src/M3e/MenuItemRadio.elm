module M3e.MenuItemRadio exposing (child, children, icon, menuItemRadio, trailingIcon)

{-| 
@docs menuItemRadio, child, icon, trailingIcon, children
-}


import M3e.Cem.Attr
import M3e.Cem.MenuItemRadio
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-menu-item-radio>` element (lazy IR). -}
menuItemRadio :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , checked : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , icon : M3e.Value.Supported
    , trailingIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | menuItemRadio : M3e.Value.Supported } msg
menuItemRadio attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.MenuItemRadio.menuItemRadio
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Content.toNode content_)
        )


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


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


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { text : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els