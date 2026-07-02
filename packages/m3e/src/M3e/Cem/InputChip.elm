module M3e.Cem.InputChip exposing
    ( inputChip, disabled, disabledInteractive, removable, removeLabel, value
    , variant, onRemove, onClick
    )

{-|
Middle layer for `<m3e-input-chip>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.InputChip` module for everyday use.

@docs inputChip, disabled, disabledInteractive, removable, removeLabel, value
@docs variant, onRemove, onClick
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.InputChip
import M3e.Value


{-| A chip which represents a discrete piece of information entered by a user.

**Component Info:**
- **Extends:** `M3eChipElement` from `/src/chips/ChipElement`

**Events:**
- `remove`: Dispatched when the remove button is clicked or DELETE or BACKSPACE key is pressed.
- `click`: Dispatched when the element is clicked.

**Slots:**
- `avatar`: Renders an avatar before the chip's label.
- `icon`: Renders an icon before the chip's label.
- `remove-icon`: Renders the icon for the button used to remove the chip.
- `trailing-icon`: Renders an icon after the chip's label.
-}
inputChip :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , removable : M3e.Value.Supported
    , removeLabel : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , onRemove : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
inputChip attributes children =
    M3e.Cem.Html.InputChip.inputChip
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.InputChip.disabled


{-| Whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive :
    Bool
    -> M3e.Cem.Attr.Attr { c | disabledInteractive : M3e.Value.Supported } msg
disabledInteractive =
    M3e.Cem.Attr.attribute M3e.Cem.Html.InputChip.disabledInteractive


{-| Whether the chip is removable. (default: `false`) -}
removable :
    Bool -> M3e.Cem.Attr.Attr { c | removable : M3e.Value.Supported } msg
removable =
    M3e.Cem.Attr.attribute M3e.Cem.Html.InputChip.removable


{-| The accessible label given to the button used to remove the chip. (default: `"Remove"`) -}
removeLabel :
    String -> M3e.Cem.Attr.Attr { c | removeLabel : M3e.Value.Supported } msg
removeLabel =
    M3e.Cem.Attr.attribute M3e.Cem.Html.InputChip.removeLabel


{-| A string representing the value of the chip. -}
value : String -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.Attr.attribute M3e.Cem.Html.InputChip.value


{-| The appearance variant of the chip. (default: `"outlined"`) -}
variant :
    M3e.Value.Value { elevated : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant v_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.InputChip.variant
        (M3e.Value.toString v_)


{-| Listen for `remove` events. -}
onRemove : msg -> M3e.Cem.Attr.Attr { c | onRemove : M3e.Value.Supported } msg
onRemove f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.InputChip.onRemove
        (Json.Decode.succeed f_)


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.InputChip.onClick
        (Json.Decode.succeed f_)