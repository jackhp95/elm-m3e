module M3e.Fab exposing (child, children, closeIcon, fab, label)

{-| 
@docs fab, child, label, closeIcon, children
-}


import Html.Attributes
import M3e.Cem.Attr
import M3e.Cem.Fab
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-fab>` element (lazy IR). -}
fab :
    { ariaLabel : String }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , download : M3e.Value.Supported
    , extended : M3e.Value.Supported
    , href : M3e.Value.Supported
    , lowered : M3e.Value.Supported
    , name : M3e.Value.Supported
    , rel : M3e.Value.Supported
    , size : M3e.Value.Supported
    , target : M3e.Value.Supported
    , type_ : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , label : M3e.Value.Supported
    , closeIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | fab : M3e.Value.Supported } msg
fab req_ attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.Fab.fab (List.map M3e.Cem.Attr.forget erased) ch
            )
            (List.append
                []
                (List.append
                    [ M3e.Cem.Attr.forget
                        (M3e.Cem.Attr.attribute
                            (Html.Attributes.attribute "aria-label")
                            req_.ariaLabel
                        )
                    ]
                    (List.map M3e.Cem.Attr.forget attributes)
                )
            )
            (List.append [] (List.map M3e.Content.toNode content_))
        )


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { icon : M3e.Value.Supported
    , fabMenuTrigger : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place content in the `label` slot. -}
label :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | label : M3e.Value.Supported } msg
label el =
    M3e.Content.slot "label" el


{-| Place content in the `close-icon` slot. -}
closeIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | closeIcon : M3e.Value.Supported } msg
closeIcon el =
    M3e.Content.slot "close-icon" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { icon : M3e.Value.Supported
    , fabMenuTrigger : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els