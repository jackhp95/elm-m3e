module M3e.OptionPanel exposing (State(..), component, onBeforetoggle, onToggle, state)

{-| 
Presents a list of options on a temporary surface.

## Component

@docs component

### Attributes

@docs State, state

### Events

@docs onBeforetoggle, onToggle
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| Presents a list of options on a temporary surface.

**Events:**
- `beforetoggle`: Dispatched before the toggle state changes.
- `toggle`: Dispatched after the toggle state has changed.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-option-panel" attributes children


{-| Values for the `state` attribute. -}
type State
    = Content
    | Loading
    | NoData


{-| The state for which to present content. (default: `"content"`) -}
state : State -> Html.Attribute msg
state val_ =
    Html.Attributes.attribute "state" (stateToString val_)


stateToString : State -> String
stateToString val_ =
    case val_ of
        Content ->
            "content"
    
        Loading ->
            "loading"
    
        NoData ->
            "no-data"


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