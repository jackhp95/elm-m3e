module M3e.NavMenuItem exposing (badge, child, children, icon, navMenuItem, selectedIcon, toggleIcon)

{-| 
@docs navMenuItem, child, icon, badge, selectedIcon, toggleIcon, children
-}


import M3e.Cem.Attr
import M3e.Cem.NavMenuItem
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-nav-menu-item>` element (lazy IR). -}
navMenuItem :
    { label :
        M3e.Element.Element { text : M3e.Value.Supported
        , link : M3e.Value.Supported
        } msg
    }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , open : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , onOpening : M3e.Value.Supported
    , onOpened : M3e.Value.Supported
    , onClosing : M3e.Value.Supported
    , onClosed : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , icon : M3e.Value.Supported
    , badge : M3e.Value.Supported
    , selectedIcon : M3e.Value.Supported
    , toggleIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | navMenuItem : M3e.Value.Supported } msg
navMenuItem req_ attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.NavMenuItem.navMenuItem
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.append
                []
                (List.append [] (List.map M3e.Cem.Attr.forget attributes))
            )
            (List.append
                [ M3e.Element.toNode (M3e.Element.withSlot "label" req_.label) ]
                (List.map M3e.Content.toNode content_)
            )
        )


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { navMenuItem : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place content in the `icon` slot. -}
icon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | icon : M3e.Value.Supported } msg
icon el =
    M3e.Content.slot "icon" el


{-| Place content in the `badge` slot. -}
badge :
    M3e.Element.Element { badge : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | badge : M3e.Value.Supported } msg
badge el =
    M3e.Content.slot "badge" el


{-| Place content in the `selected-icon` slot. -}
selectedIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | selectedIcon : M3e.Value.Supported } msg
selectedIcon el =
    M3e.Content.slot "selected-icon" el


{-| Place content in the `toggle-icon` slot. -}
toggleIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | toggleIcon : M3e.Value.Supported } msg
toggleIcon el =
    M3e.Content.slot "toggle-icon" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { navMenuItem : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els