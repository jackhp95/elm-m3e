module M3e.Html.Stepper exposing
    ( stepper, headerPosition, labelPosition, linear, orientation, onChange
    , onBeforeinput, onInput
    )

{-| Middle layer for `<m3e-stepper>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Stepper` module for everyday use.

@docs stepper, headerPosition, labelPosition, linear, orientation, onChange
@docs onBeforeinput, onInput

-}

import Html
import Json.Decode
import M3e.Raw.Stepper
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


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
    List
        (Markup.Html.Attr.Attr
            { headerPosition : M3e.Token.Supported
            , labelPosition : M3e.Token.Supported
            , linear : M3e.Token.Supported
            , orientation : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
stepper attributes children =
    M3e.Raw.Stepper.stepper
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| The position of the step header, when oriented horizontally. (default: `"above"`)
-}
headerPosition :
    M3e.Token.Value { above : M3e.Token.Supported, below : M3e.Token.Supported }
    -> Markup.Html.Attr.Attr { c | headerPosition : M3e.Token.Supported } msg
headerPosition v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Stepper.headerPosition
        (M3e.Token.toString v_)


{-| The position of the step labels, when oriented horizontally. (default: `"end"`)
-}
labelPosition :
    M3e.Token.Value { below : M3e.Token.Supported, end : M3e.Token.Supported }
    -> Markup.Html.Attr.Attr { c | labelPosition : M3e.Token.Supported } msg
labelPosition v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Stepper.labelPosition
        (M3e.Token.toString v_)


{-| Whether the validity of previous steps should be checked or not. (default: `false`)
-}
linear : Bool -> Markup.Html.Attr.Attr { c | linear : M3e.Token.Supported } msg
linear =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Stepper.linear


{-| The orientation of the stepper. (default: `"horizontal"`)
-}
orientation :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , horizontal : M3e.Token.Supported
        , vertical : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | orientation : M3e.Token.Supported } msg
orientation v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Stepper.orientation
        (M3e.Token.toString v_)


{-| Listen for `change` events.
-}
onChange : msg -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Stepper.onChange
        (Json.Decode.succeed f_)


{-| Listen for `beforeinput` events.
-}
onBeforeinput : msg -> Markup.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Stepper.onBeforeinput
        (Json.Decode.succeed f_)


{-| Listen for `input` events.
-}
onInput : msg -> Markup.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Stepper.onInput
        (Json.Decode.succeed f_)
