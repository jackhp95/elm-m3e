module M3e.SliderThumb exposing
    ( view, disabled, name, value, onValueChange, onBeforeinput
    , onInput, onChange, onClick
    )

{-| A thumb used to select a value in a slider.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `value-change`: No description
  - `beforeinput`: Dispatched before the value changes.
  - `input`: Dispatched when the value changes.
  - `change`: Dispatched when the value changes.
  - `click`: Dispatched when the element is clicked.

@docs view, disabled, name, value, onValueChange, onBeforeinput
@docs onInput, onChange, onClick

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.SliderThumb
import M3e.Node
import M3e.Token


{-| Build the `<m3e-slider-thumb>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , name : M3e.Token.Supported
            , valueFloat : M3e.Token.Supported
            , onValueChange : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | sliderThumb : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.SliderThumb.sliderThumb
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.SliderThumb.disabled


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> M3e.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    M3e.Html.SliderThumb.name


{-| The value of the thumb. (default: `null`)
-}
value : Float -> M3e.Html.Attr.Attr { c | valueFloat : M3e.Token.Supported } msg
value =
    M3e.Html.SliderThumb.value


{-| Listen for `value-change` events.
-}
onValueChange : msg -> M3e.Html.Attr.Attr { c | onValueChange : M3e.Token.Supported } msg
onValueChange =
    M3e.Html.SliderThumb.onValueChange


{-| Listen for `beforeinput` events.
-}
onBeforeinput : msg -> M3e.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput =
    M3e.Html.SliderThumb.onBeforeinput


{-| Listen for `input` events.
-}
onInput : msg -> M3e.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput =
    M3e.Html.SliderThumb.onInput


{-| Listen for `change` events.
-}
onChange : msg -> M3e.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.SliderThumb.onChange


{-| Listen for `click` events.
-}
onClick : msg -> M3e.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick =
    M3e.Html.SliderThumb.onClick
