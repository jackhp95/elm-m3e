module M3e.NavMenuItemGroup exposing (child, children, label, navMenuItemGroup)

{-| 
@docs navMenuItemGroup, label, child, children
-}


import M3e.Cem.Attr
import M3e.Cem.NavMenuItemGroup
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-nav-menu-item-group>` element (lazy IR). -}
navMenuItemGroup :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { label : M3e.Value.Supported
    , default : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | navMenuItemGroup : M3e.Value.Supported } msg
navMenuItemGroup attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.NavMenuItemGroup.navMenuItemGroup
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Content.toNode content_)
        )


{-| Place content in the `label` slot. -}
label :
    M3e.Element.Element { text : M3e.Value.Supported
    , heading : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | label : M3e.Value.Supported } msg
label el =
    M3e.Content.slot "label" el


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { navMenuItem : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { navMenuItem : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els