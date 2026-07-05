module M3e.Cem.SplitPane exposing
    ( splitPane, label, max, min, orientation, overshootLimit
    , step, value, wrapDetents, name, disabled, onChange, onBeforeinput
    , onInput
    )

{-|
Middle layer for `<m3e-split-pane>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.SplitPane` module for everyday use.

@docs splitPane, label, max, min, orientation, overshootLimit
@docs step, value, wrapDetents, name, disabled, onChange
@docs onBeforeinput, onInput
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.SplitPane
import M3e.Value


{-| A dual-view layout that separates content with a movable drag handle.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `change`: Dispatched when the user finishes adjusting the drag handle.
- `beforeinput`: Dispatched continuously before the user adjusts the drag handle.
- `input`: Dispatched continuously while the user adjusts the drag handle.

**Slots:**
- `start`: Renders content at the logical start side of the pane.
- `end`: Renders content at the logical end side of the pane.
-}
splitPane :
    List (M3e.Cem.Attr.Attr { label : M3e.Value.Supported
    , max : M3e.Value.Supported
    , min : M3e.Value.Supported
    , orientation : M3e.Value.Supported
    , overshootLimit : M3e.Value.Supported
    , step : M3e.Value.Supported
    , value : M3e.Value.Supported
    , wrapDetents : M3e.Value.Supported
    , name : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
splitPane attributes children =
    M3e.Cem.Html.SplitPane.splitPane
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The accessible label given to the movable drag handle. (default: `"Resize panes"`) -}
label : String -> M3e.Cem.Attr.Attr { c | label : M3e.Value.Supported } msg
label =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.SplitPane.label


{-| A fractional value, between 0 and 100, indicating the maximum size of the start pane. (default: `100`) -}
max : Float -> M3e.Cem.Attr.Attr { c | max : M3e.Value.Supported } msg
max =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.SplitPane.max


{-| A fractional value, between 0 and 100, indicating the minimum size of the start pane. (default: `0`) -}
min : Float -> M3e.Cem.Attr.Attr { c | min : M3e.Value.Supported } msg
min =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.SplitPane.min


{-| The orientation of the split. (default: `"horizontal"`) -}
orientation :
    M3e.Value.Value { auto : M3e.Value.Supported
    , horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | orientation : M3e.Value.Supported } msg
orientation v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.SplitPane.orientation
        (M3e.Value.toString v_)


{-| A fractional value, between 0 and 100, indicating the maximum visual overshoot allowed when dragging past the minimum or maximum size. (default: `4`) -}
overshootLimit :
    Float -> M3e.Cem.Attr.Attr { c | overshootLimit : M3e.Value.Supported } msg
overshootLimit =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.SplitPane.overshootLimit


{-| A fractional value, between 0 and 100, indicating the increment by which to adjust the value when resized via keyboard. (default: `1`) -}
step : Float -> M3e.Cem.Attr.Attr { c | step : M3e.Value.Supported } msg
step =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.SplitPane.step


{-| A fractional value, between 0 and 100, indicating the size of the start pane. (default: `50`) -}
value : Float -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.SplitPane.value


{-| Whether cycling through detents will wrap. (default: `false`) -}
wrapDetents :
    Bool -> M3e.Cem.Attr.Attr { c | wrapDetents : M3e.Value.Supported } msg
wrapDetents =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.SplitPane.wrapDetents


{-| The name that identifies the element when submitting the associated form. -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.SplitPane.name


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.SplitPane.disabled


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.SplitPane.onChange
        (Json.Decode.succeed f_)


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    msg -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.SplitPane.onBeforeinput
        (Json.Decode.succeed f_)


{-| Listen for `input` events. -}
onInput : msg -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.SplitPane.onInput
        (Json.Decode.succeed f_)