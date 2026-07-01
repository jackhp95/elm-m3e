module M3e.TreeItem exposing (child, children, icon, openToggleIcon, selectedIcon, toggleIcon, treeItem)

{-| 
@docs treeItem, child, icon, selectedIcon, toggleIcon, openToggleIcon, children
-}


import M3e.Cem.Attr
import M3e.Cem.TreeItem
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-tree-item>` element (lazy IR). -}
treeItem :
    { label :
        M3e.Element.Element { text : M3e.Value.Supported
        , link : M3e.Value.Supported
        } msg
    }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , indeterminate : M3e.Value.Supported
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
    , selectedIcon : M3e.Value.Supported
    , toggleIcon : M3e.Value.Supported
    , openToggleIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | treeItem : M3e.Value.Supported } msg
treeItem req_ attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.TreeItem.treeItem
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
    M3e.Element.Element { treeItem : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place content in the `icon` slot. -}
icon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | icon : M3e.Value.Supported } msg
icon el =
    M3e.Content.slot "icon" el


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


{-| Place content in the `open-toggle-icon` slot. -}
openToggleIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | openToggleIcon : M3e.Value.Supported } msg
openToggleIcon el =
    M3e.Content.slot "open-toggle-icon" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { treeItem : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els