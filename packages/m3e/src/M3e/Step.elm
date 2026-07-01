module M3e.Step exposing (doneIcon, editIcon, error, errorIcon, hint, icon, step)

{-| 
@docs step, icon, doneIcon, editIcon, errorIcon, hint, error
-}


import M3e.Cem.Attr
import M3e.Cem.Step
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-step>` element (lazy IR). -}
step :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> List (M3e.Cem.Attr.Attr { completed : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , editable : M3e.Value.Supported
    , for : M3e.Value.Supported
    , optional : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , invalid : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { icon : M3e.Value.Supported
    , doneIcon : M3e.Value.Supported
    , editIcon : M3e.Value.Supported
    , errorIcon : M3e.Value.Supported
    , hint : M3e.Value.Supported
    , error : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | step : M3e.Value.Supported } msg
step req_ attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.Step.step (List.map M3e.Cem.Attr.forget erased) ch
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


{-| Place content in the `icon` slot. -}
icon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | icon : M3e.Value.Supported } msg
icon el =
    M3e.Content.slot "icon" el


{-| Place content in the `done-icon` slot. -}
doneIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | doneIcon : M3e.Value.Supported } msg
doneIcon el =
    M3e.Content.slot "done-icon" el


{-| Place content in the `edit-icon` slot. -}
editIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | editIcon : M3e.Value.Supported } msg
editIcon el =
    M3e.Content.slot "edit-icon" el


{-| Place content in the `error-icon` slot. -}
errorIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | errorIcon : M3e.Value.Supported } msg
errorIcon el =
    M3e.Content.slot "error-icon" el


{-| Place content in the `hint` slot. -}
hint :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | hint : M3e.Value.Supported } msg
hint el =
    M3e.Content.slot "hint" el


{-| Place content in the `error` slot. -}
error :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | error : M3e.Value.Supported } msg
error el =
    M3e.Content.slot "error" el