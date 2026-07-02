module M3e.Step exposing
    ( view, completed, disabled, editable, for, optional
    , selected, invalid, onBeforeinput, onInput, onChange, onClick, icon
    , doneIcon, editIcon, errorIcon, hint, error
    )

{-|
A step in a wizard-like workflow.

**Events:**
- `beforeinput`: Dispatched before the selected state changes.
- `input`: Dispatched when the selected state changes.
- `change`: Dispatched when the selected state changes.
- `click`: Dispatched when the element is clicked.

**Slots:**
- `icon`: Renders the icon of the step.
- `done-icon`: Renders the icon of a completed step.
- `edit-icon`: Renders the icon of a completed editable step.
- `error-icon`: Renders icon of an invalid step.
- `hint`: Renders the hint text of the step.
- `error`: Renders the error message for an invalid step.

@docs view, completed, disabled, editable, for, optional
@docs selected, invalid, onBeforeinput, onInput, onChange, onClick
@docs icon, doneIcon, editIcon, errorIcon, hint, error
-}


import M3e.Cem.Attr
import M3e.Cem.Step
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-step>` element (lazy IR). -}
view :
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
view req_ attributes content_ =
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


{-| Whether the step has been completed. (default: `false`) -}
completed :
    Bool -> M3e.Cem.Attr.Attr { c | completed : M3e.Value.Supported } msg
completed =
    M3e.Cem.Step.completed


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Step.disabled


{-| Whether the step is editable and users can return to it after completion. (default: `false`) -}
editable : Bool -> M3e.Cem.Attr.Attr { c | editable : M3e.Value.Supported } msg
editable =
    M3e.Cem.Step.editable


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Step.for


{-| Whether the step is optional. (default: `false`) -}
optional : Bool -> M3e.Cem.Attr.Attr { c | optional : M3e.Value.Supported } msg
optional =
    M3e.Cem.Step.optional


{-| Whether the element is selected. (default: `false`) -}
selected : Bool -> M3e.Cem.Attr.Attr { c | selected : M3e.Value.Supported } msg
selected =
    M3e.Cem.Step.selected


{-| Whether the step has an error. (default: `false`) -}
invalid : Bool -> M3e.Cem.Attr.Attr { c | invalid : M3e.Value.Supported } msg
invalid =
    M3e.Cem.Step.invalid


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput =
    M3e.Cem.Step.onBeforeinput


{-| Listen for `input` events. -}
onInput :
    (Bool -> msg) -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput =
    M3e.Cem.Step.onInput


{-| Listen for `change` events. -}
onChange :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.Step.onChange


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick =
    M3e.Cem.Step.onClick


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