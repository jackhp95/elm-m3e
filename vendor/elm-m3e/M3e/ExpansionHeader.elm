module M3e.ExpansionHeader exposing (component, onClick, toggleIconSlot)

{-| 
A button used to toggle the expanded state of an expansion panel.

## Component

@docs component

### Events

@docs onClick

### Slots

@docs toggleIconSlot
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| A button used to toggle the expanded state of an expansion panel.

**Events:**
- `click`: Dispatched when the element is clicked.

**Slots:**
- `toggle-icon`: Renders the icon of the expansion toggle.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-expansion-header" attributes children


{-| Dispatched when the element is clicked.

**Payload type:** `MouseEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder


{-| Renders the icon of the expansion toggle. -}
toggleIconSlot : Html.Attribute msg
toggleIconSlot =
    Html.Attributes.attribute "slot" "toggle-icon"