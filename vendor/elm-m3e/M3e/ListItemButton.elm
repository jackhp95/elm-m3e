module M3e.ListItemButton exposing (component, leadingSlot, onClick, overlineSlot, supportingTextSlot, trailingSlot)

{-| 


## Component

@docs component

### Events

@docs onClick

### Slots

@docs leadingSlot, overlineSlot, supportingTextSlot, trailingSlot
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| Create a m3e-list-item-button element

**Component Info:**
- **Extends:** `M3eListItemElement` from `/src/list/ListItemElement`

**Events:**
- `click`: No description

**Slots:**
- `leading`: Renders the leading content of the list item.
- `overline`: Renders the overline of the list item.
- `supporting-text`: Renders the supporting text of the list item.
- `trailing`: Renders the trailing content of the list item.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-list-item-button" attributes children


{-| Listen for `click` events.

**Payload type:** `MouseEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder


{-| Renders the leading content of the list item. -}
leadingSlot : Html.Attribute msg
leadingSlot =
    Html.Attributes.attribute "slot" "leading"


{-| Renders the overline of the list item. -}
overlineSlot : Html.Attribute msg
overlineSlot =
    Html.Attributes.attribute "slot" "overline"


{-| Renders the supporting text of the list item. -}
supportingTextSlot : Html.Attribute msg
supportingTextSlot =
    Html.Attributes.attribute "slot" "supporting-text"


{-| Renders the trailing content of the list item. -}
trailingSlot : Html.Attribute msg
trailingSlot =
    Html.Attributes.attribute "slot" "trailing"