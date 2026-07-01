module M3e.SlideGroup exposing (child, children, nextIcon, prevIcon, slideGroup)

{-| 
@docs slideGroup, child, nextIcon, prevIcon, children
-}


import M3e.Cem.Attr
import M3e.Cem.SlideGroup
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-slide-group>` element (lazy IR). -}
slideGroup :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , nextPageLabel : M3e.Value.Supported
    , previousPageLabel : M3e.Value.Supported
    , threshold : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , nextIcon : M3e.Value.Supported
    , prevIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | slideGroup : M3e.Value.Supported } msg
slideGroup attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.SlideGroup.slideGroup
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Content.toNode content_)
        )


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { slide : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place content in the `next-icon` slot. -}
nextIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | nextIcon : M3e.Value.Supported } msg
nextIcon el =
    M3e.Content.slot "next-icon" el


{-| Place content in the `prev-icon` slot. -}
prevIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | prevIcon : M3e.Value.Supported } msg
prevIcon el =
    M3e.Content.slot "prev-icon" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { slide : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els