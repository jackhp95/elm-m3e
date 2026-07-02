module M3e.Cem.InputChipSet exposing
    ( inputChipSet, disabled, name, required, vertical, onChange
    )

{-|
Middle layer for `<m3e-input-chip-set>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.InputChipSet` module for everyday use.

@docs inputChipSet, disabled, name, required, vertical, onChange
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.InputChipSet
import M3e.Value


{-| A container that transforms user input into a cohesive set of interactive chips, supporting entry, editing, and removal of discrete values.

**Component Info:**
- **Extends:** `M3eChipSetElement` from `/src/chips/ChipSetElement`

**Events:**
- `change`: Dispatched when a chip is added to, or removed from, the set.

**Slots:**
- `input`: Renders the input element used to add new chips to the set.
-}
inputChipSet :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , name : M3e.Value.Supported
    , required : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
inputChipSet attributes children =
    M3e.Cem.Html.InputChipSet.inputChipSet
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.InputChipSet.disabled


{-| The name that identifies the element when submitting the associated form. -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.Attr.attribute M3e.Cem.Html.InputChipSet.name


{-| Whether a value is required for the element. (default: `false`) -}
required : Bool -> M3e.Cem.Attr.Attr { c | required : M3e.Value.Supported } msg
required =
    M3e.Cem.Attr.attribute M3e.Cem.Html.InputChipSet.required


{-| Whether the element is oriented vertically. (default: `false`) -}
vertical : Bool -> M3e.Cem.Attr.Attr { c | vertical : M3e.Value.Supported } msg
vertical =
    M3e.Cem.Attr.attribute M3e.Cem.Html.InputChipSet.vertical


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.InputChipSet.onChange
        (Json.Decode.succeed f_)