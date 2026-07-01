module M3e.Cem.Button exposing (button, disabled, disabledInteractive, download, href, name, onBeforeinput, onChange, onClick, onInput, rel, selected, shape, size, target, toggle, type_, value, variant)

{-| 
@docs button, disabled, disabledInteractive, download, href, name, rel, selected, shape, size, target, toggle, type_, value, variant, onBeforeinput, onInput, onChange, onClick
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.Button
import M3e.Value


{-| A button users interact with to perform an action.

**Events:**
- `beforeinput`: Dispatched before a toggle button's selected state changes.
- `input`: Dispatched when a toggle button's selected state changes.
- `change`: Dispatched when a toggle button's selected state changes.
- `click`: Dispatched when the element is clicked.

**Slots:**
- `icon`: Renders an icon before the button's label.
- `selected`: Renders the label of the button, when selected.
- `selected-icon`: Renders an icon before the button's label, when selected.
- `trailing-icon`: Renders an icon after the button's label.
-}
button :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , download : M3e.Value.Supported
    , href : M3e.Value.Supported
    , name : M3e.Value.Supported
    , rel : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , shape : M3e.Value.Supported
    , size : M3e.Value.Supported
    , target : M3e.Value.Supported
    , toggle : M3e.Value.Supported
    , type_ : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
button attributes children =
    M3e.Cem.Html.Button.button
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Button.disabled


{-| Whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive :
    Bool
    -> M3e.Cem.Attr.Attr { c | disabledInteractive : M3e.Value.Supported } msg
disabledInteractive =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Button.disabledInteractive


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`) -}
download :
    String -> M3e.Cem.Attr.Attr { c | download : M3e.Value.Supported } msg
download =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Button.download


{-| The URL to which the link button points. (default: `""`) -}
href : String -> M3e.Cem.Attr.Attr { c | href : M3e.Value.Supported } msg
href =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Button.href


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form. -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Button.name


{-| The relationship between the `target` of the link button and the document. (default: `""`) -}
rel : String -> M3e.Cem.Attr.Attr { c | rel : M3e.Value.Supported } msg
rel =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Button.rel


{-| Whether the toggle button is selected. (default: `false`) -}
selected : Bool -> M3e.Cem.Attr.Attr { c | selected : M3e.Value.Supported } msg
selected =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Button.selected


{-| The shape of the button. (default: `"rounded"`) -}
shape :
    M3e.Value.Value { rounded : M3e.Value.Supported
    , square : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | shape : M3e.Value.Supported } msg
shape v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Button.shape (M3e.Value.toString v_)


{-| The size of the button. (default: `"small"`) -}
size :
    M3e.Value.Value { extraLarge : M3e.Value.Supported
    , extraSmall : M3e.Value.Supported
    , large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | size : M3e.Value.Supported } msg
size v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Button.size (M3e.Value.toString v_)


{-| The target of the link button. (default: `""`) -}
target : String -> M3e.Cem.Attr.Attr { c | target : M3e.Value.Supported } msg
target =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Button.target


{-| Whether the button will toggle between selected and unselected states. (default: `false`) -}
toggle : Bool -> M3e.Cem.Attr.Attr { c | toggle : M3e.Value.Supported } msg
toggle =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Button.toggle


{-| The type of the element. (default: `"button"`) -}
type_ :
    M3e.Value.Value { button : M3e.Value.Supported
    , reset : M3e.Value.Supported
    , submit : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | type_ : M3e.Value.Supported } msg
type_ v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Button.type_ (M3e.Value.toString v_)


{-| The value associated with the element's name when it's submitted with form data. -}
value : String -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Button.value


{-| The appearance variant of the button. (default: `"text"`) -}
variant :
    M3e.Value.Value { elevated : M3e.Value.Supported
    , filled : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    , text : M3e.Value.Supported
    , tonal : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Button.variant (M3e.Value.toString v_)


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.Button.onBeforeinput
        (Json.Decode.map
            f_
            (Json.Decode.at [ "target", "selected" ] Json.Decode.bool)
        )


{-| Listen for `input` events. -}
onInput :
    (Bool -> msg) -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.Button.onInput
        (Json.Decode.map
            f_
            (Json.Decode.at [ "target", "selected" ] Json.Decode.bool)
        )


{-| Listen for `change` events. -}
onChange :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.Button.onChange
        (Json.Decode.map
            f_
            (Json.Decode.at [ "target", "selected" ] Json.Decode.bool)
        )


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick f_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Button.onClick (Json.Decode.succeed f_)