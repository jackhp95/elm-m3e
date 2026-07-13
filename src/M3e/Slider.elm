module M3e.Slider exposing
    ( view, disabled, discrete, labelled, max, min
    , step, size, onBeforeinput, onInput, onChange
    )

{-| Allows for the selection of numeric values from a range.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `beforeinput`: Dispatched before the value of a thumb changes.
  - `input`: Dispatched when the value of a thumb changes.
  - `change`: Dispatched when the value of a thumb changes.

<!-- elm-cem:docmeta category=Selection -->


## Examples


### Examples

<!-- elm-cem:example title="Basic usage" -->
```elm
M3e.Slider.view [] [ M3e.SliderThumb.view [] [] ]
```

<!-- elm-cem:example title="Selecting a value" -->
```elm
M3e.Slider.view [ M3e.Slider.min 1, M3e.Slider.max 5, M3e.Slider.step 0.5 ] [ M3e.SliderThumb.view [ M3e.SliderThumb.value 1.5 ] [] ]
```

<!-- elm-cem:example title="Selecting a range" -->
```elm
M3e.Slider.view [] [ M3e.SliderThumb.view [ M3e.SliderThumb.value 20 ] [], M3e.SliderThumb.view [ M3e.SliderThumb.value 80 ] [] ]
```

<!-- elm-cem:example title="Negative value ranges" -->
```elm
M3e.Slider.view [ M3e.Slider.min -50 ] [ M3e.SliderThumb.view [ M3e.SliderThumb.value -20 ] [] ]
```

<!-- elm-cem:example title="Labels" -->
```elm
M3e.Slider.view [ M3e.Slider.labelled True ] [ M3e.SliderThumb.view [ M3e.SliderThumb.value 20 ] [] ]
```

<!-- elm-cem:example title="Tick marks" -->
```elm
M3e.Slider.view [ M3e.Slider.discrete True, M3e.Slider.step 10 ] [ M3e.SliderThumb.view [ M3e.SliderThumb.value 20 ] [] ]
```

<!-- elm-cem:example title="Disabling" -->
```elm
M3e.Slider.view [ M3e.Slider.labelled True, M3e.Slider.disabled True ] [ M3e.SliderThumb.view [ M3e.SliderThumb.value 20 ] [] ]
```

<!-- elm-cem:example title="Disabling (2)" -->
```elm
M3e.Slider.view [ M3e.Slider.labelled True ] [ M3e.SliderThumb.view [ M3e.SliderThumb.value 20 ] [], M3e.SliderThumb.view [ M3e.SliderThumb.disabled True, M3e.SliderThumb.value 80 ] [] ]
```


### Sizes

<!-- elm-cem:example title="Sizes" -->
```elm
[ M3e.Slider.view [ M3e.Slider.size M3e.Token.extraSmall ] [ M3e.SliderThumb.view [ M3e.SliderThumb.value 50 ] [] ]
    , M3e.Slider.view [ M3e.Slider.size M3e.Token.small ] [ M3e.SliderThumb.view [ M3e.SliderThumb.value 50 ] [] ]
    , M3e.Slider.view [ M3e.Slider.size M3e.Token.medium ] [ M3e.SliderThumb.view [ M3e.SliderThumb.value 50 ] [] ]
    , M3e.Slider.view [ M3e.Slider.size M3e.Token.large ] [ M3e.SliderThumb.view [ M3e.SliderThumb.value 50 ] [] ]
    , M3e.Slider.view [ M3e.Slider.size M3e.Token.extraLarge ] [ M3e.SliderThumb.view [ M3e.SliderThumb.value 50 ] [] ]
    ]
```

@docs view, disabled, discrete, labelled, max, min
@docs step, size, onBeforeinput, onInput, onChange

-}

import M3e.Html.Slider
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-slider>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , discrete : M3e.Token.Supported
            , labelled : M3e.Token.Supported
            , max : M3e.Token.Supported
            , min : M3e.Token.Supported
            , step : M3e.Token.Supported
            , size : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | slider : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.Slider.slider
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Slider.disabled


{-| Whether to show tick marks. (default: `false`)
-}
discrete : Bool -> Markup.Html.Attr.Attr { c | discrete : M3e.Token.Supported } msg
discrete =
    M3e.Html.Slider.discrete


{-| Whether to show value labels when activated. (default: `false`)
-}
labelled : Bool -> Markup.Html.Attr.Attr { c | labelled : M3e.Token.Supported } msg
labelled =
    M3e.Html.Slider.labelled


{-| The maximum allowable value. (default: `100`)
-}
max : Float -> Markup.Html.Attr.Attr { c | max : M3e.Token.Supported } msg
max =
    M3e.Html.Slider.max


{-| The minimum allowable value. (default: `0`)
-}
min : Float -> Markup.Html.Attr.Attr { c | min : M3e.Token.Supported } msg
min =
    M3e.Html.Slider.min


{-| The value at which the thumb will snap. (default: `1`)
-}
step : Float -> Markup.Html.Attr.Attr { c | step : M3e.Token.Supported } msg
step =
    M3e.Html.Slider.step


{-| The size of the slider. (default: `"extra-small"`)
-}
size :
    M3e.Token.Value
        { extraLarge : M3e.Token.Supported
        , extraSmall : M3e.Token.Supported
        , large : M3e.Token.Supported
        , medium : M3e.Token.Supported
        , small : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | size : M3e.Token.Supported } msg
size =
    M3e.Html.Slider.size


{-| Listen for `beforeinput` events.
-}
onBeforeinput : msg -> Markup.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput =
    M3e.Html.Slider.onBeforeinput


{-| Listen for `input` events.
-}
onInput : msg -> Markup.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput =
    M3e.Html.Slider.onInput


{-| Listen for `change` events.
-}
onChange : msg -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.Slider.onChange
