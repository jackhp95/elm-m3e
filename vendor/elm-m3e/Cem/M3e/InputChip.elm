module Cem.M3e.InputChip exposing
    ( component
    , disabled, disabledInteractive, removable, removeLabel, value, Variant(..), variant
    , onRemove, onClick
    , avatarSlot, iconSlot, removeIconSlot, trailingIconSlot
    , variantToString
    )

{-| A chip which represents a discrete piece of information entered by a user.


## Component

@docs component


### Attributes

@docs disabled, disabledInteractive, removable, removeLabel, value, Variant, variant


### Events

@docs onRemove, onClick


### Slots

@docs avatarSlot, iconSlot, removeIconSlot, trailingIconSlot

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


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
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-input-chip" attributes children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether the element is disabled and interactive. (default: `false`)
-}
disabledInteractive : Bool -> Html.Attribute msg
disabledInteractive val_ =
    Html.Attributes.property "disabledInteractive" (Json.Encode.bool val_)


{-| Whether the chip is removable. (default: `false`)
-}
removable : Bool -> Html.Attribute msg
removable val_ =
    Html.Attributes.property "removable" (Json.Encode.bool val_)


{-| The accessible label given to the button used to remove the chip. (default: `"Remove"`)
-}
removeLabel : String -> Html.Attribute msg
removeLabel val_ =
    Html.Attributes.attribute "remove-label" val_


{-| A string representing the value of the chip.
-}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value


{-| Values for the `variant` attribute.
-}
type Variant
    = Elevated
    | Outlined


{-| The appearance variant of the chip. (default: `"outlined"`)
-}
variant : Variant -> Html.Attribute msg
variant val_ =
    Html.Attributes.attribute "variant" (variantToString val_)


variantToString : Variant -> String
variantToString val_ =
    case val_ of
        Elevated ->
            "elevated"

        Outlined ->
            "outlined"


{-| Dispatched when the remove button is clicked or DELETE or BACKSPACE key is pressed.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onRemove : Json.Decode.Decoder msg -> Html.Attribute msg
onRemove decoder =
    Html.Events.on "remove" decoder


{-| Dispatched when the element is clicked.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder


{-| Renders an avatar before the chip's label.
-}
avatarSlot : Html.Attribute msg
avatarSlot =
    Html.Attributes.attribute "slot" "avatar"


{-| Renders an icon before the chip's label.
-}
iconSlot : Html.Attribute msg
iconSlot =
    Html.Attributes.attribute "slot" "icon"


{-| Renders the icon for the button used to remove the chip.
-}
removeIconSlot : Html.Attribute msg
removeIconSlot =
    Html.Attributes.attribute "slot" "remove-icon"


{-| Renders an icon after the chip's label.
-}
trailingIconSlot : Html.Attribute msg
trailingIconSlot =
    Html.Attributes.attribute "slot" "trailing-icon"
