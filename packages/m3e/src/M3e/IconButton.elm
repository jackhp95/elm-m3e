module M3e.IconButton exposing (iconButton, selectedSlot)

{-| 
@docs iconButton, selectedSlot
-}


import Html.Attributes
import M3e.Cem.Attr
import M3e.Cem.IconButton
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-icon-button>` element (lazy IR). -}
iconButton :
    { content : M3e.Element.Element { icon : M3e.Value.Supported } msg
    , ariaLabel : String
    }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , download : M3e.Value.Supported
    , href : M3e.Value.Supported
    , name : M3e.Value.Supported
    , rel : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , shape : M3e.Value.Supported
    , size : M3e.Value.Supported
    , target : M3e.Value.Supported
    , toggle : M3e.Value.Supported
    , type_ : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , width : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { selected : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | iconButton : M3e.Value.Supported } msg
iconButton req_ attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.IconButton.iconButton
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
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
            (List.append
                [ M3e.Element.toNode req_.content ]
                (List.map M3e.Content.toNode content_)
            )
        )


{-| Place content in the `selected` slot. -}
selectedSlot :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | selected : M3e.Value.Supported } msg
selectedSlot el =
    M3e.Content.slot "selected" el