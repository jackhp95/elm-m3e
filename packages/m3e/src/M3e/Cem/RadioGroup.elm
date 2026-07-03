module M3e.Cem.RadioGroup exposing
    ( radioGroup, ariaInvalid, disabled, name, required, onBeforeinput
    , onInput, onChange
    )

{-|
Middle layer for `<m3e-radio-group>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.RadioGroup` module for everyday use.

@docs radioGroup, ariaInvalid, disabled, name, required, onBeforeinput
@docs onInput, onChange
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.RadioGroup
import M3e.Value


{-| A container for a set of radio buttons.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `beforeinput`: Dispatched before the checked state of a radio button changes.
- `input`: Dispatched when the checked state of a radio button changes.
- `change`: Dispatched when the checked state of a radio button changes.
-}
radioGroup :
    List (M3e.Cem.Attr.Attr { ariaInvalid : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , name : M3e.Value.Supported
    , required : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
radioGroup attributes children =
    M3e.Cem.Html.RadioGroup.radioGroup
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Set the `aria-invalid` attribute. -}
ariaInvalid :
    String -> M3e.Cem.Attr.Attr { c | ariaInvalid : M3e.Value.Supported } msg
ariaInvalid =
    M3e.Cem.Attr.attribute M3e.Cem.Html.RadioGroup.ariaInvalid


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.RadioGroup.disabled


{-| The name that identifies the element when submitting the associated form. -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.Attr.attribute M3e.Cem.Html.RadioGroup.name


{-| Whether the element is required. (default: `false`) -}
required : Bool -> M3e.Cem.Attr.Attr { c | required : M3e.Value.Supported } msg
required =
    M3e.Cem.Attr.attribute M3e.Cem.Html.RadioGroup.required


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    msg -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.RadioGroup.onBeforeinput
        (Json.Decode.succeed f_)


{-| Listen for `input` events. -}
onInput : msg -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.RadioGroup.onInput
        (Json.Decode.succeed f_)


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.RadioGroup.onChange
        (Json.Decode.succeed f_)