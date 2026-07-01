module M3e.Cem.ButtonSegment exposing (buttonSegment, checked, disabled, onBeforeinput, onChange, onClick, onInput, value)

{-| 
@docs buttonSegment, checked, disabled, value, onBeforeinput, onInput, onChange, onClick
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.ButtonSegment
import M3e.Value


{-| A option that can be selected within a segmented button.

**Events:**
- `beforeinput`: Dispatched before the checked state changes.
- `input`: Dispatched when the checked state changes.
- `change`: Dispatched when the checked state changes.
- `click`: Dispatched when the element is clicked.

**Slots:**
- `icon`: Renders an icon before the option's label.
-}
buttonSegment :
    List (M3e.Cem.Attr.Attr { checked : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , value : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
buttonSegment attributes children =
    M3e.Cem.Html.ButtonSegment.buttonSegment
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the element is checked. (default: `false`) -}
checked : Bool -> M3e.Cem.Attr.Attr { c | checked : M3e.Value.Supported } msg
checked =
    M3e.Cem.Attr.attribute M3e.Cem.Html.ButtonSegment.checked


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.ButtonSegment.disabled


{-| A string representing the value of the segment. (default: `"on"`) -}
value : String -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.Attr.attribute M3e.Cem.Html.ButtonSegment.value


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.ButtonSegment.onBeforeinput
        (Json.Decode.map
            f_
            (Json.Decode.at [ "target", "checked" ] Json.Decode.bool)
        )


{-| Listen for `input` events. -}
onInput :
    (Bool -> msg) -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.ButtonSegment.onInput
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
        M3e.Cem.Html.ButtonSegment.onChange
        (Json.Decode.map
            f_
            (Json.Decode.at [ "target", "checked" ] Json.Decode.bool)
        )


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.ButtonSegment.onClick
        (Json.Decode.succeed f_)