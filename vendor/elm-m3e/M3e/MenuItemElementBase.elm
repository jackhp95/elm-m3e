module M3e.MenuItemElementBase exposing (component, onClick)

{-| 
A base implementation for an item of a menu. This class must be inherited.

## Component

@docs component

### Events

@docs onClick
-}


import Html
import Html.Events
import Json.Decode


{-| A base implementation for an item of a menu. This class must be inherited.

**Events:**
- `click`: No description
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "div" attributes children


{-| Listen for `click` events.

**Payload type:** `MouseEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder