module M3e.Tabs exposing (child, children, nextIcon, panel, prevIcon, tabs)

{-| 
@docs tabs, child, panel, nextIcon, prevIcon, children
-}


import M3e.Cem.Attr
import M3e.Cem.Tabs
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-tabs>` element (lazy IR). -}
tabs :
    List (M3e.Cem.Attr.Attr { disablePagination : M3e.Value.Supported
    , headerPosition : M3e.Value.Supported
    , nextPageLabel : M3e.Value.Supported
    , previousPageLabel : M3e.Value.Supported
    , stretch : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , panel : M3e.Value.Supported
    , nextIcon : M3e.Value.Supported
    , prevIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | tabs : M3e.Value.Supported } msg
tabs attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.Tabs.tabs (List.map M3e.Cem.Attr.forget erased) ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Content.toNode content_)
        )


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { tab : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place content in the `panel` slot. -}
panel :
    M3e.Element.Element { tabPanel : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | panel : M3e.Value.Supported } msg
panel el =
    M3e.Content.slot "panel" el


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
    List (M3e.Element.Element { tab : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els