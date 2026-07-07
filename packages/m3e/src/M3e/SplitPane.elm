module M3e.SplitPane exposing
    ( view, label, max, min, orientation, overshootLimit
    , step, value, wrapDetents, name, disabled, onChange, onBeforeinput
    , onInput, start, end
    )

{-|
A dual-view layout that separates content with a movable drag handle.

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
M3e.SplitPane.view [ M3e.SplitPane.value 50, M3e.SplitPane.orientation M3e.Value.vertical ] [ M3e.SplitPane.start (M3e.Card.view [] []), M3e.SplitPane.end (M3e.Card.view [] []) ]
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
M3e.SplitPane.view [ M3e.SplitPane.value 50, M3e.SplitPane.wrapDetents True ] [ M3e.SplitPane.start (M3e.Card.view [] []), M3e.SplitPane.end (M3e.Card.view [] []) ]
```

<!-- elm-cem:example title="Disabling" -->
```elm
M3e.SplitPane.view [ M3e.SplitPane.value 50, M3e.SplitPane.disabled True ] [ M3e.SplitPane.start (M3e.Card.view [] []), M3e.SplitPane.end (M3e.Card.view [] []) ]
```

<!-- elm-cem:example title="Conditional rendering" -->
```elm
M3e.SplitPane.view [ M3e.SplitPane.value 50 ] [ M3e.SplitPane.start (M3e.Card.view [] []), M3e.SplitPane.end (M3e.Card.view [] []) ]
```

<!-- elm-cem:example title="Nested panes" -->
```elm
M3e.SplitPane.view [ M3e.SplitPane.value 25 ] [ M3e.SplitPane.start (M3e.Card.view [] []), M3e.SplitPane.end (M3e.SplitPane.view [ M3e.SplitPane.value 50, M3e.SplitPane.orientation M3e.Value.vertical ] [ M3e.SplitPane.start (M3e.Card.view [] []), M3e.SplitPane.end (M3e.Card.view [] []) ]) ]
```

@docs view, label, max, min, orientation, overshootLimit
@docs step, value, wrapDetents, name, disabled, onChange
@docs onBeforeinput, onInput, start, end
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.SplitPane
import M3e.Content
import M3e.Content.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-split-pane>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { label : M3e.Value.Supported
    , max : M3e.Value.Supported
    , min : M3e.Value.Supported
    , orientation : M3e.Value.Supported
    , overshootLimit : M3e.Value.Supported
    , step : M3e.Value.Supported
    , valueFloat : M3e.Value.Supported
    , wrapDetents : M3e.Value.Supported
    , name : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { start : M3e.Value.Supported
    , end : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | splitPane : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.SplitPane.splitPane
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| The accessible label given to the movable drag handle. (default: `"Resize panes"`) -}
label : String -> M3e.Cem.Attr.Attr { c | label : M3e.Value.Supported } msg
label =
    M3e.Cem.SplitPane.label


{-| A fractional value, between 0 and 100, indicating the maximum size of the start pane. (default: `100`) -}
max : Float -> M3e.Cem.Attr.Attr { c | max : M3e.Value.Supported } msg
max =
    M3e.Cem.SplitPane.max


{-| A fractional value, between 0 and 100, indicating the minimum size of the start pane. (default: `0`) -}
min : Float -> M3e.Cem.Attr.Attr { c | min : M3e.Value.Supported } msg
min =
    M3e.Cem.SplitPane.min


{-| The orientation of the split. (default: `"horizontal"`) -}
orientation :
    M3e.Value.Value { auto : M3e.Value.Supported
    , horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | orientation : M3e.Value.Supported } msg
orientation =
    M3e.Cem.SplitPane.orientation


{-| A fractional value, between 0 and 100, indicating the maximum visual overshoot allowed when dragging past the minimum or maximum size. (default: `4`) -}
overshootLimit :
    Float -> M3e.Cem.Attr.Attr { c | overshootLimit : M3e.Value.Supported } msg
overshootLimit =
    M3e.Cem.SplitPane.overshootLimit


{-| A fractional value, between 0 and 100, indicating the increment by which to adjust the value when resized via keyboard. (default: `1`) -}
step : Float -> M3e.Cem.Attr.Attr { c | step : M3e.Value.Supported } msg
step =
    M3e.Cem.SplitPane.step


{-| A fractional value, between 0 and 100, indicating the size of the start pane. (default: `50`) -}
value : Float -> M3e.Cem.Attr.Attr { c | valueFloat : M3e.Value.Supported } msg
value =
    M3e.Cem.SplitPane.value


{-| Whether cycling through detents will wrap. (default: `false`) -}
wrapDetents :
    Bool -> M3e.Cem.Attr.Attr { c | wrapDetents : M3e.Value.Supported } msg
wrapDetents =
    M3e.Cem.SplitPane.wrapDetents


{-| The name that identifies the element when submitting the associated form. -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.SplitPane.name


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.SplitPane.disabled


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.SplitPane.onChange


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    msg -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput =
    M3e.Cem.SplitPane.onBeforeinput


{-| Listen for `input` events. -}
onInput : msg -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput =
    M3e.Cem.SplitPane.onInput


{-| Place content in the `start` slot. -}
start :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | start : M3e.Value.Supported } msg
start el =
    M3e.Content.Internal.slot "start" el


{-| Place content in the `end` slot. -}
end :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | end : M3e.Value.Supported } msg
end el =
    M3e.Content.Internal.slot "end" el