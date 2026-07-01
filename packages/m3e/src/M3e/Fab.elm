module M3e.Fab exposing (child, children, closeIcon, disabled, disabledInteractive, download, extended, fab, href, label, lowered, name, onClick, rel, size, target, type_, value, variant)

{-| 
@docs fab, disabled, disabledInteractive, download, extended, href, lowered, name, rel, size, target, type_, value, variant, onClick, child, label, closeIcon, children
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
    { name : String }
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
                            req_.name
                        )
                    ]
                    (List.map M3e.Cem.Attr.forget attributes)
                )
            )
            (List.append [] (List.map M3e.Content.toNode content_))
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Fab.disabled


{-| Whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive :
    Bool
    -> M3e.Cem.Attr.Attr { c | disabledInteractive : M3e.Value.Supported } msg
disabledInteractive =
    M3e.Cem.Fab.disabledInteractive


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`) -}
download :
    String -> M3e.Cem.Attr.Attr { c | download : M3e.Value.Supported } msg
download =
    M3e.Cem.Fab.download


{-| Whether the button is extended to show the label. (default: `false`) -}
extended : Bool -> M3e.Cem.Attr.Attr { c | extended : M3e.Value.Supported } msg
extended =
    M3e.Cem.Fab.extended


{-| The URL to which the link button points. (default: `""`) -}
href : String -> M3e.Cem.Attr.Attr { c | href : M3e.Value.Supported } msg
href =
    M3e.Cem.Fab.href


{-| Whether to present a lowered elevation. (default: `false`) -}
lowered : Bool -> M3e.Cem.Attr.Attr { c | lowered : M3e.Value.Supported } msg
lowered =
    M3e.Cem.Fab.lowered


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form. -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.Fab.name


{-| The relationship between the `target` of the link button and the document. (default: `""`) -}
rel : String -> M3e.Cem.Attr.Attr { c | rel : M3e.Value.Supported } msg
rel =
    M3e.Cem.Fab.rel


{-| The size of the button. (default: `"medium"`) -}
size :
    M3e.Value.Value { large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | size : M3e.Value.Supported } msg
size =
    M3e.Cem.Fab.size


{-| The target of the link button. (default: `""`) -}
target : String -> M3e.Cem.Attr.Attr { c | target : M3e.Value.Supported } msg
target =
    M3e.Cem.Fab.target


{-| The type of the element. (default: `"button"`) -}
type_ :
    M3e.Value.Value { button : M3e.Value.Supported
    , reset : M3e.Value.Supported
    , submit : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | type_ : M3e.Value.Supported } msg
type_ =
    M3e.Cem.Fab.type_


{-| The value associated with the element's name when it's submitted with form data. -}
value : String -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.Fab.value


{-| The appearance variant of the button. (default: `"primary-container"`) -}
variant :
    M3e.Value.Value { primary : M3e.Value.Supported
    , primaryContainer : M3e.Value.Supported
    , secondary : M3e.Value.Supported
    , secondaryContainer : M3e.Value.Supported
    , surface : M3e.Value.Supported
    , tertiary : M3e.Value.Supported
    , tertiaryContainer : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.Fab.variant


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick =
    M3e.Cem.Fab.onClick


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