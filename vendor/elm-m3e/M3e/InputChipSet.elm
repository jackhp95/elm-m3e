module M3e.InputChipSet exposing (component, inputSlot, name, onChange, required)

{-| 
A container that transforms user input into a cohesive set of interactive chips, supporting entry, editing, and removal of discrete values.

## Component

@docs component

### Attributes

@docs name, required

### Events

@docs onChange

### Slots

@docs inputSlot
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A container that transforms user input into a cohesive set of interactive chips, supporting entry, editing, and removal of discrete values.

**Component Info:**
- **Extends:** `M3eChipSetElement` from `/src/chips/ChipSetElement`

**Events:**
- `change`: Dispatched when a chip is added to, or removed from, the set.

**Slots:**
- `input`: Renders the input element used to add new chips to the set.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-input-chip-set" attributes children


{-| The name that identifies the element when submitting the associated form. -}
name : String -> Html.Attribute msg
name val_ =
    Html.Attributes.attribute "name" val_


{-| Whether a value is required for the element. (default: `false`) -}
required : Bool -> Html.Attribute msg
required val_ =
    Html.Attributes.property "required" (Json.Encode.bool val_)


{-| Dispatched when a chip is added to, or removed from, the set.

**Payload type:** `CustomEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged M3e.Common.targetValue)`.
-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Renders the input element used to add new chips to the set. -}
inputSlot : Html.Attribute msg
inputSlot =
    Html.Attributes.attribute "slot" "input"