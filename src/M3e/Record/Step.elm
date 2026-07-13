module M3e.Record.Step exposing
    ( view, completed, disabled, editable, for, optional
    , selected, invalid, onBeforeinput, onInput, onChange, onClick
    , icon, doneIcon, editIcon, errorIcon, hint, error
    )

{-| A step in a wizard-like workflow.

**Component Info:**

  - **Extends:** `LitElement`

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

import M3e.Html.Step
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-step>` element (lazy IR).
-}
view :
    { content : Markup.Element.Element { sharedText : Markup.Kind.Shared } msg }
    ->
        List
            (Markup.Html.Attr.Attr
                { completed : M3e.Token.Supported
                , disabled : M3e.Token.Supported
                , editable : M3e.Token.Supported
                , for : M3e.Token.Supported
                , optional : M3e.Token.Supported
                , selected : M3e.Token.Supported
                , invalid : M3e.Token.Supported
                , onBeforeinput : M3e.Token.Supported
                , onInput : M3e.Token.Supported
                , onChange : M3e.Token.Supported
                , onClick : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | step : M3e.Kind.Brand } msg
view req_ attributes content_ =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.Step.step
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.append
                [ Markup.Element.toNode req_.content ]
                (List.map Markup.Element.toNode content_)
            )
        )


{-| Whether the step has been completed. (default: `false`)
-}
completed : Bool -> Markup.Html.Attr.Attr { c | completed : M3e.Token.Supported } msg
completed =
    M3e.Html.Step.completed


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Step.disabled


{-| Whether the step is editable and users can return to it after completion. (default: `false`)
-}
editable : Bool -> Markup.Html.Attr.Attr { c | editable : M3e.Token.Supported } msg
editable =
    M3e.Html.Step.editable


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Markup.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    M3e.Html.Step.for


{-| Whether the step is optional. (default: `false`)
-}
optional : Bool -> Markup.Html.Attr.Attr { c | optional : M3e.Token.Supported } msg
optional =
    M3e.Html.Step.optional


{-| Whether the element is selected. (default: `false`)
-}
selected : Bool -> Markup.Html.Attr.Attr { c | selected : M3e.Token.Supported } msg
selected =
    M3e.Html.Step.selected


{-| Whether the step has an error. (default: `false`)
-}
invalid : Bool -> Markup.Html.Attr.Attr { c | invalid : M3e.Token.Supported } msg
invalid =
    M3e.Html.Step.invalid


{-| Listen for `beforeinput` events.
-}
onBeforeinput :
    (Bool -> msg)
    -> Markup.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput =
    M3e.Html.Step.onBeforeinput


{-| Listen for `input` events.
-}
onInput :
    (Bool -> msg)
    -> Markup.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput =
    M3e.Html.Step.onInput


{-| Listen for `change` events.
-}
onChange :
    (Bool -> msg)
    -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.Step.onChange


{-| Listen for `click` events.
-}
onClick : msg -> Markup.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick =
    M3e.Html.Step.onClick


{-| Place content in the `icon` slot.
-}
icon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
icon el =
    Markup.Element.Internal.placeSlot "icon" el


{-| Place content in the `done-icon` slot.
-}
doneIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
doneIcon el =
    Markup.Element.Internal.placeSlot "done-icon" el


{-| Place content in the `edit-icon` slot.
-}
editIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
editIcon el =
    Markup.Element.Internal.placeSlot "edit-icon" el


{-| Place content in the `error-icon` slot.
-}
errorIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
errorIcon el =
    Markup.Element.Internal.placeSlot "error-icon" el


{-| Place content in the `hint` slot.
-}
hint :
    Markup.Element.Element { sharedText : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
hint el =
    Markup.Element.Internal.placeSlot "hint" el


{-| Place content in the `error` slot.
-}
error :
    Markup.Element.Element { sharedText : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
error el =
    Markup.Element.Internal.placeSlot "error" el
