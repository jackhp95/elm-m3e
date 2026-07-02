module M3e.Cem.Radio exposing
    ( radio, checked, disabled, name, required, value
    , onBeforeinput, onInput, onChange, onClick
    )

{-|
Middle layer for `<m3e-radio>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Radio` module for everyday use.

@docs radio, checked, disabled, name, required, value
@docs onBeforeinput, onInput, onChange, onClick
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.Radio
import M3e.Value


{-| A radio button that allows a user to select one option from a set of options.

**Events:**
- `beforeinput`: Dispatched before the checked state changes.
- `input`: Dispatched when the checked state changes.
- `change`: Dispatched when the checked state changes.
- `click`: Dispatched when the element is clicked.
-}
radio :
    List (M3e.Cem.Attr.Attr { checked : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , name : M3e.Value.Supported
    , required : M3e.Value.Supported
    , value : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
radio attributes children =
    M3e.Cem.Html.Radio.radio
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the element is checked. (default: `false`) -}
checked : Bool -> M3e.Cem.Attr.Attr { c | checked : M3e.Value.Supported } msg
checked =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Radio.checked


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Radio.disabled


{-| The name that identifies the element when submitting the associated form. -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Radio.name


{-| Whether the element is required. -}
required :
    String -> M3e.Cem.Attr.Attr { c | required : M3e.Value.Supported } msg
required =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Radio.required


{-| A string representing the value of the radio. (default: `"on"`) -}
value : String -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Radio.value


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.Radio.onBeforeinput
        (Json.Decode.map
             f_
             (Json.Decode.at [ "target", "checked" ] Json.Decode.bool)
        )


{-| Listen for `input` events. -}
onInput :
    (Bool -> msg) -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.Radio.onInput
        (Json.Decode.map
             f_
             (Json.Decode.at [ "target", "checked" ] Json.Decode.bool)
        )


{-| Listen for `change` events. -}
onChange :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.Radio.onChange
        (Json.Decode.map
             f_
             (Json.Decode.at [ "target", "checked" ] Json.Decode.bool)
        )


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick f_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Radio.onClick (Json.Decode.succeed f_)