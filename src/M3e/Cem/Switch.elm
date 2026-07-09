module M3e.Cem.Switch exposing
    ( switch, checked, disabled, icons, name, value
    , onBeforeinput, onInput, onChange, onClick
    )

{-|
Middle layer for `<m3e-switch>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Switch` module for everyday use.

@docs switch, checked, disabled, icons, name, value
@docs onBeforeinput, onInput, onChange, onClick
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.Switch
import M3e.Value


{-| An on/off control that can be toggled by clicking.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `beforeinput`: Dispatched before the checked state changes.
- `input`: Dispatched when the checked state changes.
- `change`: Dispatched when the checked state changes.
- `click`: Dispatched when the element is clicked.
-}
switch :
    List (M3e.Cem.Attr.Attr { checked : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , icons : M3e.Value.Supported
    , name : M3e.Value.Supported
    , value : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
switch attributes children =
    M3e.Cem.Html.Switch.switch
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the element is checked. (default: `false`) -}
checked : Bool -> M3e.Cem.Attr.Attr { c | checked : M3e.Value.Supported } msg
checked =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Switch.checked


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Switch.disabled


{-| The icons to present. (default: `"none"`) -}
icons :
    M3e.Value.Value { both : M3e.Value.Supported
    , none : M3e.Value.Supported
    , selected : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | icons : M3e.Value.Supported } msg
icons v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Switch.icons
        (M3e.Value.toString v_)


{-| The name that identifies the element when submitting the associated form. -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Switch.name


{-| A string representing the value of the switch. (default: `"on"`) -}
value : String -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Switch.value


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Switch.onBeforeinput
        (Json.Decode.map
             f_
             (Json.Decode.at [ "target", "checked" ] Json.Decode.bool)
        )


{-| Listen for `input` events. -}
onInput :
    (Bool -> msg) -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Switch.onInput
        (Json.Decode.map
             f_
             (Json.Decode.at [ "target", "checked" ] Json.Decode.bool)
        )


{-| Listen for `change` events. -}
onChange :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Switch.onChange
        (Json.Decode.map
             f_
             (Json.Decode.at [ "target", "checked" ] Json.Decode.bool)
        )


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Switch.onClick
        (Json.Decode.succeed f_)