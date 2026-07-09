module M3e.Cem.Step exposing
    ( step, completed, disabled, editable, for, optional
    , selected, invalid, onBeforeinput, onInput, onChange, onClick
    )

{-|
Middle layer for `<m3e-step>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Step` module for everyday use.

@docs step, completed, disabled, editable, for, optional
@docs selected, invalid, onBeforeinput, onInput, onChange, onClick
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.Step
import M3e.Value


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
-}
step :
    List (M3e.Cem.Attr.Attr { completed : M3e.Value.Supported
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
    -> List (Html.Html msg)
    -> Html.Html msg
step attributes children =
    M3e.Cem.Html.Step.step
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the step has been completed. (default: `false`) -}
completed :
    Bool -> M3e.Cem.Attr.Attr { c | completed : M3e.Value.Supported } msg
completed =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Step.completed


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Step.disabled


{-| Whether the step is editable and users can return to it after completion. (default: `false`) -}
editable : Bool -> M3e.Cem.Attr.Attr { c | editable : M3e.Value.Supported } msg
editable =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Step.editable


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Step.for


{-| Whether the step is optional. (default: `false`) -}
optional : Bool -> M3e.Cem.Attr.Attr { c | optional : M3e.Value.Supported } msg
optional =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Step.optional


{-| Whether the element is selected. (default: `false`) -}
selected : Bool -> M3e.Cem.Attr.Attr { c | selected : M3e.Value.Supported } msg
selected =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Step.selected


{-| Whether the step has an error. (default: `false`) -}
invalid : Bool -> M3e.Cem.Attr.Attr { c | invalid : M3e.Value.Supported } msg
invalid =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Step.invalid


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Step.onBeforeinput
        (Json.Decode.map
             f_
             (Json.Decode.at [ "target", "selected" ] Json.Decode.bool)
        )


{-| Listen for `input` events. -}
onInput :
    (Bool -> msg) -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Step.onInput
        (Json.Decode.map
             f_
             (Json.Decode.at [ "target", "selected" ] Json.Decode.bool)
        )


{-| Listen for `change` events. -}
onChange :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Step.onChange
        (Json.Decode.map
             f_
             (Json.Decode.at [ "target", "selected" ] Json.Decode.bool)
        )


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Step.onClick
        (Json.Decode.succeed f_)