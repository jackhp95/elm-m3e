module M3e.ExpansionHeader exposing (child, children, expansionHeader, toggleIcon)

{-| 
@docs expansionHeader, child, toggleIcon, children
-}


import M3e.Cem.Attr
import M3e.Cem.ExpansionHeader
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-expansion-header>` element (lazy IR). -}
expansionHeader :
    List (M3e.Cem.Attr.Attr { hideToggle : M3e.Value.Supported
    , toggleDirection : M3e.Value.Supported
    , togglePosition : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , toggleIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | expansionHeader : M3e.Value.Supported } msg
expansionHeader attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.ExpansionHeader.expansionHeader
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


{-| Place content in the `toggle-icon` slot. -}
toggleIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | toggleIcon : M3e.Value.Supported } msg
toggleIcon el =
    M3e.Content.slot "toggle-icon" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { text : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els