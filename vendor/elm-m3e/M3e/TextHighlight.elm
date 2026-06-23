module M3e.TextHighlight exposing (Mode(..), component, mode, onHighlight)

{-| 
Highlights text which matches a given search term.

## Component

@docs component

### Attributes

@docs Mode, mode

### Events

@docs onHighlight
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| Highlights text which matches a given search term.

**Events:**
- `highlight`: Dispatched when content is highlighted.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-text-highlight" attributes children


{-| Values for the `mode` attribute. -}
type Mode
    = Contains
    | EndsWith
    | StartsWith


{-| The mode in which to highlight text. (default: `"contains"`) -}
mode : Mode -> Html.Attribute msg
mode val_ =
    Html.Attributes.attribute "mode" (modeToString val_)


modeToString : Mode -> String
modeToString val_ =
    case val_ of
        Contains ->
            "contains"
    
        EndsWith ->
            "ends-with"
    
        StartsWith ->
            "starts-with"


{-| Dispatched when content is highlighted.

**Payload type:** `CustomEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onHighlight : Json.Decode.Decoder msg -> Html.Attribute msg
onHighlight decoder =
    Html.Events.on "highlight" decoder