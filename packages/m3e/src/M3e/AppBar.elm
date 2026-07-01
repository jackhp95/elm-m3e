module M3e.AppBar exposing (appBar, leading, subtitle, title, trailing)

{-| 
@docs appBar, leading, title, subtitle, trailing
-}


import M3e.Cem.AppBar
import M3e.Cem.Attr
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-app-bar>` element (lazy IR). -}
appBar :
    List (M3e.Cem.Attr.Attr { centered : M3e.Value.Supported
    , for : M3e.Value.Supported
    , size : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { leading : M3e.Value.Supported
    , title : M3e.Value.Supported
    , subtitle : M3e.Value.Supported
    , trailing : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | appBar : M3e.Value.Supported } msg
appBar attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.AppBar.appBar (List.map M3e.Cem.Attr.forget erased) ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Content.toNode content_)
        )


{-| Place content in the `leading` slot. -}
leading :
    M3e.Element.Element { iconButton : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | leading : M3e.Value.Supported } msg
leading el =
    M3e.Content.slot "leading" el


{-| Place content in the `title` slot. -}
title :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | title : M3e.Value.Supported } msg
title el =
    M3e.Content.slot "title" el


{-| Place content in the `subtitle` slot. -}
subtitle :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | subtitle : M3e.Value.Supported } msg
subtitle el =
    M3e.Content.slot "subtitle" el


{-| Place content in the `trailing` slot. -}
trailing :
    M3e.Element.Element { iconButton : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | trailing : M3e.Value.Supported } msg
trailing el =
    M3e.Content.slot "trailing" el