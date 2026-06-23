module M3e.BreadcrumbItem exposing (component, iconSlot, itemLabel, onClick)

{-| 
An item in a breadcrumb.

## Component

@docs component

### Attributes

@docs itemLabel

### Events

@docs onClick

### Slots

@docs iconSlot
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| An item in a breadcrumb.

**Events:**
- `click`: Dispatched when the element is clicked.

**Slots:**
- `icon`: Renders an icon before the item's label.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-breadcrumb-item" attributes children


{-| The accessible label given to the item's internal button. (default: `""`) -}
itemLabel : String -> Html.Attribute msg
itemLabel val_ =
    Html.Attributes.attribute "item-label" val_


{-| Dispatched when the element is clicked.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder


{-| Renders an icon before the item's label. -}
iconSlot : Html.Attribute msg
iconSlot =
    Html.Attributes.attribute "slot" "icon"