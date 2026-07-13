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

import M3e.Html.SliderThumb
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-slider-thumb>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
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
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | sliderThumb : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.SliderThumb.sliderThumb
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
    M3e.Html.SliderThumb.disabled


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Markup.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    M3e.Html.SliderThumb.name


{-| The value of the thumb. (default: `null`)
-}
value : Float -> Markup.Html.Attr.Attr { c | valueFloat : M3e.Token.Supported } msg
value =
    M3e.Html.SliderThumb.value


{-| Listen for `value-change` events.
-}
onValueChange : msg -> Markup.Html.Attr.Attr { c | onValueChange : M3e.Token.Supported } msg
onValueChange =
    M3e.Html.SliderThumb.onValueChange


{-| Listen for `beforeinput` events.
-}
onBeforeinput : msg -> Markup.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput =
    M3e.Html.SliderThumb.onBeforeinput


{-| Listen for `input` events.
-}
onInput : msg -> Markup.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput =
    M3e.Html.SliderThumb.onInput


{-| Listen for `change` events.
-}
onChange : msg -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.SliderThumb.onChange


{-| Listen for `click` events.
-}
onClick : msg -> Markup.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick =
    M3e.Html.SliderThumb.onClick
