module M3e.Html.SplitPane exposing
    ( splitPane, detents, label, max, min, orientation
    , overshootLimit, step, value, wrapDetents, name, disabled
    , onChange, onBeforeinput, onInput
    )

{-| Middle layer for `<m3e-split-pane>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.SplitPane` module for everyday use.

@docs splitPane, detents, label, max, min, orientation
@docs overshootLimit, step, value, wrapDetents, name, disabled
@docs onChange, onBeforeinput, onInput

-}

import Html
import Json.Decode
import M3e.Raw.SplitPane
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


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
    List
        (Markup.Html.Attr.Attr
            { detents : M3e.Token.Supported
            , label : M3e.Token.Supported
            , max : M3e.Token.Supported
            , min : M3e.Token.Supported
            , orientation : M3e.Token.Supported
            , overshootLimit : M3e.Token.Supported
            , step : M3e.Token.Supported
            , valueFloat : M3e.Token.Supported
            , wrapDetents : M3e.Token.Supported
            , name : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
splitPane attributes children =
    M3e.Raw.SplitPane.splitPane
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Detents (discrete sizes) the start pane can snap to. (default: `[]`)
-}
detents : String -> Markup.Html.Attr.Attr { c | detents : M3e.Token.Supported } msg
detents =
    Markup.Html.Attr.Internal.attribute M3e.Raw.SplitPane.detents


{-| The accessible label given to the movable drag handle. (default: `"Resize panes"`)
-}
label : String -> Markup.Html.Attr.Attr { c | label : M3e.Token.Supported } msg
label =
    Markup.Html.Attr.Internal.attribute M3e.Raw.SplitPane.label


{-| A fractional value, between 0 and 100, indicating the maximum size of the start pane. (default: `100`)
-}
max : Float -> Markup.Html.Attr.Attr { c | max : M3e.Token.Supported } msg
max =
    Markup.Html.Attr.Internal.attribute M3e.Raw.SplitPane.max


{-| A fractional value, between 0 and 100, indicating the minimum size of the start pane. (default: `0`)
-}
min : Float -> Markup.Html.Attr.Attr { c | min : M3e.Token.Supported } msg
min =
    Markup.Html.Attr.Internal.attribute M3e.Raw.SplitPane.min


{-| The orientation of the split. (default: `"horizontal"`)
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
        M3e.Raw.SplitPane.orientation
        (M3e.Token.toString v_)


{-| A fractional value, between 0 and 100, indicating the maximum visual overshoot allowed when dragging past the minimum or maximum size. (default: `4`)
-}
overshootLimit :
    Float
    -> Markup.Html.Attr.Attr { c | overshootLimit : M3e.Token.Supported } msg
overshootLimit =
    Markup.Html.Attr.Internal.attribute M3e.Raw.SplitPane.overshootLimit


{-| A fractional value, between 0 and 100, indicating the increment by which to adjust the value when resized via keyboard. (default: `1`)
-}
step : Float -> Markup.Html.Attr.Attr { c | step : M3e.Token.Supported } msg
step =
    Markup.Html.Attr.Internal.attribute M3e.Raw.SplitPane.step


{-| A fractional value, between 0 and 100, indicating the size of the start pane. (default: `50`)
-}
value : Float -> Markup.Html.Attr.Attr { c | valueFloat : M3e.Token.Supported } msg
value =
    Markup.Html.Attr.Internal.attribute M3e.Raw.SplitPane.value


{-| Whether cycling through detents will wrap. (default: `false`)
-}
wrapDetents : Bool -> Markup.Html.Attr.Attr { c | wrapDetents : M3e.Token.Supported } msg
wrapDetents =
    Markup.Html.Attr.Internal.attribute M3e.Raw.SplitPane.wrapDetents


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Markup.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    Markup.Html.Attr.Internal.attribute M3e.Raw.SplitPane.name


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.SplitPane.disabled


{-| Listen for `change` events.
-}
onChange : msg -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.SplitPane.onChange
        (Json.Decode.succeed f_)


{-| Listen for `beforeinput` events.
-}
onBeforeinput : msg -> Markup.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.SplitPane.onBeforeinput
        (Json.Decode.succeed f_)


{-| Listen for `input` events.
-}
onInput : msg -> Markup.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.SplitPane.onInput
        (Json.Decode.succeed f_)
