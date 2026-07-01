module M3e.Snackbar exposing (closeIcon, snackbar)

{-| 
@docs snackbar, closeIcon
-}


import M3e.Cem.Attr
import M3e.Cem.Snackbar
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-snackbar>` element (lazy IR). -}
snackbar :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> List (M3e.Cem.Attr.Attr { action : M3e.Value.Supported
    , closeLabel : M3e.Value.Supported
    , dismissible : M3e.Value.Supported
    , duration : M3e.Value.Supported
    , onBeforetoggle : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { closeIcon : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | snackbar : M3e.Value.Supported } msg
snackbar req_ attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.Snackbar.snackbar
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
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


{-| Place content in the `close-icon` slot. -}
closeIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | closeIcon : M3e.Value.Supported } msg
closeIcon el =
    M3e.Content.slot "close-icon" el