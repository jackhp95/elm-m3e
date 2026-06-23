module M3e.SuggestionChip exposing
    ( component
    , value
    , onClick
    , iconSlot, trailingIconSlot
    )

{-| A chip used to help narrow a user's intent by presenting dynamically generated suggestions, such as
suggested responses or search filters.


## Component

@docs component


### Attributes

@docs value


### Events

@docs onClick


### Slots

@docs iconSlot, trailingIconSlot

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| A chip used to help narrow a user's intent by presenting dynamically generated suggestions, such as
suggested responses or search filters.

**Component Info:**

  - **Extends:** `M3eChipElement` from `/src/chips/ChipElement`

**Events:**

  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `icon`: Renders an icon before the chip's label.
  - `trailing-icon`: Renders an icon after the chip's label.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-suggestion-chip" attributes children


{-| A string representing the value of the chip.
-}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value


{-| Dispatched when the element is clicked.

**Payload type:** `MouseEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder


{-| Renders an icon before the chip's label.
-}
iconSlot : Html.Attribute msg
iconSlot =
    Html.Attributes.attribute "slot" "icon"


{-| Renders an icon after the chip's label.
-}
trailingIconSlot : Html.Attribute msg
trailingIconSlot =
    Html.Attributes.attribute "slot" "trailing-icon"
