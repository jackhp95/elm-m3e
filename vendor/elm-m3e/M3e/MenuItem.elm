module M3e.MenuItem exposing
    ( component
    , onClick
    , iconSlot, trailingIconSlot
    )

{-| An item of a floating action button (FAB) menu.


## Component

@docs component


### Events

@docs onClick


### Slots

@docs iconSlot, trailingIconSlot

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| An item of a floating action button (FAB) menu.

**Events:**

  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `icon`: Renders an icon before the items's label.
  - `trailing-icon`: Renders an icon after the item's label.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-menu-item" attributes children


{-| Dispatched when the element is clicked.

**Payload type:** `MouseEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder


{-| Renders an icon before the items's label.
-}
iconSlot : Html.Attribute msg
iconSlot =
    Html.Attributes.attribute "slot" "icon"


{-| Renders an icon after the item's label.
-}
trailingIconSlot : Html.Attribute msg
trailingIconSlot =
    Html.Attributes.attribute "slot" "trailing-icon"
