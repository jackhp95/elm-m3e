module M3e.Html.Step exposing
    ( step, completed, disabled, editable, for, optional
    , selected, invalid, onBeforeinput, onInput, onChange, onClick
    )

{-| Middle layer for `<m3e-step>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Step` module for everyday use.

@docs step, completed, disabled, editable, for, optional
@docs selected, invalid, onBeforeinput, onInput, onChange, onClick

-}

import Html
import Json.Decode
import M3e.Raw.Step
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


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
    -> List (Html.Html msg)
    -> Html.Html msg
step attributes children =
    M3e.Raw.Step.step
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether the step has been completed. (default: `false`)
-}
completed : Bool -> Markup.Html.Attr.Attr { c | completed : M3e.Token.Supported } msg
completed =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Step.completed


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Step.disabled


{-| Whether the step is editable and users can return to it after completion. (default: `false`)
-}
editable : Bool -> Markup.Html.Attr.Attr { c | editable : M3e.Token.Supported } msg
editable =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Step.editable


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Markup.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Step.for


{-| Whether the step is optional. (default: `false`)
-}
optional : Bool -> Markup.Html.Attr.Attr { c | optional : M3e.Token.Supported } msg
optional =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Step.optional


{-| Whether the element is selected. (default: `false`)
-}
selected : Bool -> Markup.Html.Attr.Attr { c | selected : M3e.Token.Supported } msg
selected =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Step.selected


{-| Whether the step has an error. (default: `false`)
-}
invalid : Bool -> Markup.Html.Attr.Attr { c | invalid : M3e.Token.Supported } msg
invalid =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Step.invalid


{-| Listen for `beforeinput` events.
-}
onBeforeinput :
    (Bool -> msg)
    -> Markup.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Step.onBeforeinput
        (Json.Decode.map
            f_
            (Json.Decode.at [ "target", "selected" ] Json.Decode.bool)
        )


{-| Listen for `input` events.
-}
onInput :
    (Bool -> msg)
    -> Markup.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Step.onInput
        (Json.Decode.map
            f_
            (Json.Decode.at [ "target", "selected" ] Json.Decode.bool)
        )


{-| Listen for `change` events.
-}
onChange :
    (Bool -> msg)
    -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Step.onChange
        (Json.Decode.map
            f_
            (Json.Decode.at [ "target", "selected" ] Json.Decode.bool)
        )


{-| Listen for `click` events.
-}
onClick : msg -> Markup.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Step.onClick
        (Json.Decode.succeed f_)
