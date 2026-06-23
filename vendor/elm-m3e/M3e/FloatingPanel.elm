module M3e.FloatingPanel exposing (component, onBeforetoggle, onToggle)

{-| 
A lightweight, generic floating surface used to present content above the page.

## Component

@docs component

### Events

@docs onBeforetoggle, onToggle
-}


import Html
import Html.Events
import Json.Decode


{-| A lightweight, generic floating surface used to present content above the page.

**Events:**
- `beforetoggle`: Dispatched before the toggle state changes.
- `toggle`: Dispatched after the toggle state has changed.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-floating-panel" attributes children


{-| Dispatched before the toggle state changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onBeforetoggle : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforetoggle decoder =
    Html.Events.on "beforetoggle" decoder


{-| Dispatched after the toggle state has changed.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onToggle : Json.Decode.Decoder msg -> Html.Attribute msg
onToggle decoder =
    Html.Events.on "toggle" decoder