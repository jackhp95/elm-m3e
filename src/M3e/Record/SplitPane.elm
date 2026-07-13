module M3e.Record.SplitPane exposing
    ( view, detents, label, max, min, orientation
    , overshootLimit, step, value, wrapDetents, name, disabled
    , onChange, onBeforeinput, onInput
    )

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

<!-- elm-cem:docmeta category=Containment -->


## Examples


### Examples

<!-- elm-cem:example title="Basic usage" -->
```elm
M3e.SplitPane.view [ M3e.SplitPane.value 50 ] [ M3e.SplitPane.start (M3e.Card.view [] []), M3e.SplitPane.end (M3e.Card.view [] []) ]
```

<!-- elm-cem:example title="Orientation" -->
```elm
M3e.SplitPane.view [ M3e.SplitPane.value 50, M3e.SplitPane.orientation M3e.Token.vertical ] [ M3e.SplitPane.start (M3e.Card.view [] []), M3e.SplitPane.end (M3e.Card.view [] []) ]
```

<!-- elm-cem:example title="Min and max sizes" -->
```elm
M3e.SplitPane.view [ M3e.SplitPane.value 50, M3e.SplitPane.min 25, M3e.SplitPane.max 75 ] [ M3e.SplitPane.start (M3e.Card.view [] []), M3e.SplitPane.end (M3e.Card.view [] []) ]
```

<!-- elm-cem:example title="Step size" -->
```elm
M3e.SplitPane.view [ M3e.SplitPane.value 50, M3e.SplitPane.step 10 ] [ M3e.SplitPane.start (M3e.Card.view [] []), M3e.SplitPane.end (M3e.Card.view [] []) ]
```

<!-- elm-cem:example title="Detents" -->
```elm
M3e.SplitPane.view [ M3e.SplitPane.value 50, M3e.SplitPane.detents "0 25 50 75 100", M3e.SplitPane.wrapDetents True ] [ M3e.SplitPane.start (M3e.Card.view [] []), M3e.SplitPane.end (M3e.Card.view [] []) ]
```

<!-- elm-cem:example title="Disabling" -->
```elm
M3e.SplitPane.view [ M3e.SplitPane.value 50, M3e.SplitPane.disabled True ] [ M3e.SplitPane.start (M3e.Card.view [] []), M3e.SplitPane.end (M3e.Card.view [] []) ]
```

<!-- elm-cem:example title="Conditional rendering" -->
```elm
M3e.SplitPane.view [ M3e.SplitPane.value 50 ] [ M3e.SplitPane.start (M3e.Card.view [] []), M3e.SplitPane.end (M3e.Card.view [ Native.attribute "hidden" "" ] []) ]
```

<!-- elm-cem:example title="Nested panes" -->
```elm
M3e.SplitPane.view [ M3e.SplitPane.value 25, M3e.Attributes.class "complex" ] [ M3e.SplitPane.start (M3e.Card.view [] []), M3e.SplitPane.end (M3e.SplitPane.view [ M3e.SplitPane.value 50, M3e.SplitPane.orientation M3e.Token.vertical ] [ M3e.SplitPane.start (M3e.Card.view [] []), M3e.SplitPane.end (M3e.Card.view [] []) ]) ]
```

@docs view, detents, label, max, min, orientation
@docs overshootLimit, step, value, wrapDetents, name, disabled
@docs onChange, onBeforeinput, onInput

-}

import M3e.Html.SplitPane
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-split-pane>` element (lazy IR).
-}
view :
    { start : Markup.Element.Element any msg
    , end : Markup.Element.Element any msg
    }
    ->
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
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | splitPane : M3e.Kind.Brand } msg
view req_ attributes content_ =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.SplitPane.splitPane
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.append
                [ Markup.Element.toNode
                    (Markup.Element.withSlot "start" req_.start)
                , Markup.Element.toNode
                    (Markup.Element.withSlot "end" req_.end)
                ]
                (List.map Markup.Element.toNode content_)
            )
        )


{-| Detents (discrete sizes) the start pane can snap to. (default: `[]`)
-}
detents : String -> Markup.Html.Attr.Attr { c | detents : M3e.Token.Supported } msg
detents =
    M3e.Html.SplitPane.detents


{-| The accessible label given to the movable drag handle. (default: `"Resize panes"`)
-}
label : String -> Markup.Html.Attr.Attr { c | label : M3e.Token.Supported } msg
label =
    M3e.Html.SplitPane.label


{-| A fractional value, between 0 and 100, indicating the maximum size of the start pane. (default: `100`)
-}
max : Float -> Markup.Html.Attr.Attr { c | max : M3e.Token.Supported } msg
max =
    M3e.Html.SplitPane.max


{-| A fractional value, between 0 and 100, indicating the minimum size of the start pane. (default: `0`)
-}
min : Float -> Markup.Html.Attr.Attr { c | min : M3e.Token.Supported } msg
min =
    M3e.Html.SplitPane.min


{-| The orientation of the split. (default: `"horizontal"`)
-}
orientation :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , horizontal : M3e.Token.Supported
        , vertical : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | orientation : M3e.Token.Supported } msg
orientation =
    M3e.Html.SplitPane.orientation


{-| A fractional value, between 0 and 100, indicating the maximum visual overshoot allowed when dragging past the minimum or maximum size. (default: `4`)
-}
overshootLimit :
    Float
    -> Markup.Html.Attr.Attr { c | overshootLimit : M3e.Token.Supported } msg
overshootLimit =
    M3e.Html.SplitPane.overshootLimit


{-| A fractional value, between 0 and 100, indicating the increment by which to adjust the value when resized via keyboard. (default: `1`)
-}
step : Float -> Markup.Html.Attr.Attr { c | step : M3e.Token.Supported } msg
step =
    M3e.Html.SplitPane.step


{-| A fractional value, between 0 and 100, indicating the size of the start pane. (default: `50`)
-}
value : Float -> Markup.Html.Attr.Attr { c | valueFloat : M3e.Token.Supported } msg
value =
    M3e.Html.SplitPane.value


{-| Whether cycling through detents will wrap. (default: `false`)
-}
wrapDetents : Bool -> Markup.Html.Attr.Attr { c | wrapDetents : M3e.Token.Supported } msg
wrapDetents =
    M3e.Html.SplitPane.wrapDetents


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Markup.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    M3e.Html.SplitPane.name


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.SplitPane.disabled


{-| Listen for `change` events.
-}
onChange : msg -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.SplitPane.onChange


{-| Listen for `beforeinput` events.
-}
onBeforeinput : msg -> Markup.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput =
    M3e.Html.SplitPane.onBeforeinput


{-| Listen for `input` events.
-}
onInput : msg -> Markup.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput =
    M3e.Html.SplitPane.onInput
