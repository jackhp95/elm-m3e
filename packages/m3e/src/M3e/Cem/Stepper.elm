module M3e.Cem.Stepper exposing
    ( stepper, headerPosition, labelPosition, linear, orientation, onChange
    , onBeforeinput, onInput
    )

{-|
Middle layer for `<m3e-stepper>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Stepper` module for everyday use.

@docs stepper, headerPosition, labelPosition, linear, orientation, onChange
@docs onBeforeinput, onInput
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.Stepper
import M3e.Value


{-| Provides a wizard-like workflow by dividing content into logical steps.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `change`: Dispatched when the selected step changes.
- `beforeinput`: Dispatched before the selected state of a step changes.
- `input`: Dispatched when the selected state of a step changes.

**Slots:**
- `step`: Renders a step.
- `panel`: Renders a panel.
-}
stepper :
    List (M3e.Cem.Attr.Attr { headerPosition : M3e.Value.Supported
    , labelPosition : M3e.Value.Supported
    , linear : M3e.Value.Supported
    , orientation : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
stepper attributes children =
    M3e.Cem.Html.Stepper.stepper
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The position of the step header, when oriented horizontally. (default: `"above"`) -}
headerPosition :
    M3e.Value.Value { above : M3e.Value.Supported, below : M3e.Value.Supported }
    -> M3e.Cem.Attr.Attr { c | headerPosition : M3e.Value.Supported } msg
headerPosition v_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.Stepper.headerPosition
        (M3e.Value.toString v_)


{-| The position of the step labels, when oriented horizontally. (default: `"end"`) -}
labelPosition :
    M3e.Value.Value { below : M3e.Value.Supported, end : M3e.Value.Supported }
    -> M3e.Cem.Attr.Attr { c | labelPosition : M3e.Value.Supported } msg
labelPosition v_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.Stepper.labelPosition
        (M3e.Value.toString v_)


{-| Whether the validity of previous steps should be checked or not. (default: `false`) -}
linear : Bool -> M3e.Cem.Attr.Attr { c | linear : M3e.Value.Supported } msg
linear =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Stepper.linear


{-| The orientation of the stepper. (default: `"horizontal"`) -}
orientation :
    M3e.Value.Value { auto : M3e.Value.Supported
    , horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | orientation : M3e.Value.Supported } msg
orientation v_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.Stepper.orientation
        (M3e.Value.toString v_)


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.Stepper.onChange
        (Json.Decode.succeed f_)


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    msg -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.Stepper.onBeforeinput
        (Json.Decode.succeed f_)


{-| Listen for `input` events. -}
onInput : msg -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput f_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Stepper.onInput (Json.Decode.succeed f_)