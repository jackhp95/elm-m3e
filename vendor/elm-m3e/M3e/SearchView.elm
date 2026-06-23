module M3e.SearchView exposing (Mode(..), clearLabel, closeLabel, closedLeadingSlot, closedTrailingSlot, component, contained, hideSearchIcon, inputSlot, mode, onBeforetoggle, onClear, onQuery, onToggle, open, openLeadingSlot, openTrailingSlot)

{-| 
A surface that presents suggestions and results for a search.

## Component

@docs component

### Attributes

@docs contained, Mode, mode, open, clearLabel, closeLabel, hideSearchIcon

### Events

@docs onQuery, onClear, onBeforetoggle, onToggle

### Slots

@docs inputSlot, openLeadingSlot, openTrailingSlot, closedLeadingSlot, closedTrailingSlot
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A surface that presents suggestions and results for a search.

**Events:**
- `query`: Dispatched when the view is opened or when the user modifies the search term.
- `clear`: Dispatched when the search term is cleared.
- `beforetoggle`: Dispatched before the toggle state changes.
- `toggle`: Dispatched after the toggle state has changed.

**Slots:**
- `input`: Renders the input of the view.
- `open-leading`: When open, renders content before the input of the view.
- `open-trailing`: When open, renders content after the input of the view.
- `closed-leading`: When closed, renders content before the input of the view.
- `closed-trailing`: When closed, renders content after the input of the view.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-search-view" attributes children


{-| Whether the view features a persistent, filled search container. (default: `false`) -}
contained : Bool -> Html.Attribute msg
contained val_ =
    Html.Attributes.property "contained" (Json.Encode.bool val_)


{-| Values for the `mode` attribute. -}
type Mode
    = Auto
    | Docked
    | Fullscreen


{-| The behavior mode of the view. (default: `"docked"`) -}
mode : Mode -> Html.Attribute msg
mode val_ =
    Html.Attributes.attribute "mode" (modeToString val_)


modeToString : Mode -> String
modeToString val_ =
    case val_ of
        Auto ->
            "auto"
    
        Docked ->
            "docked"
    
        Fullscreen ->
            "fullscreen"


{-| Whether the view is expanded to show results. (default: `false`) -}
open : Bool -> Html.Attribute msg
open val_ =
    Html.Attributes.property "open" (Json.Encode.bool val_)


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`) -}
clearLabel : String -> Html.Attribute msg
clearLabel val_ =
    Html.Attributes.attribute "clear-label" val_


{-| The accessible label given to the button used to collapse the view. (default: `"Close"`) -}
closeLabel : String -> Html.Attribute msg
closeLabel val_ =
    Html.Attributes.attribute "close-label" val_


{-| Whether to hide the search icon. (default: `false`) -}
hideSearchIcon : Bool -> Html.Attribute msg
hideSearchIcon val_ =
    Html.Attributes.property "hide-search-icon" (Json.Encode.bool val_)


{-| Dispatched when the view is opened or when the user modifies the search term.

**Payload type:** `CustomEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onQuery : Json.Decode.Decoder msg -> Html.Attribute msg
onQuery decoder =
    Html.Events.on "query" decoder


{-| Dispatched when the search term is cleared.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onClear : Json.Decode.Decoder msg -> Html.Attribute msg
onClear decoder =
    Html.Events.on "clear" decoder


{-| Dispatched before the toggle state changes.

**Payload type:** `ToggleEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onBeforetoggle : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforetoggle decoder =
    Html.Events.on "beforetoggle" decoder


{-| Dispatched after the toggle state has changed.

**Payload type:** `ToggleEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onToggle : Json.Decode.Decoder msg -> Html.Attribute msg
onToggle decoder =
    Html.Events.on "toggle" decoder


{-| Renders the input of the view. -}
inputSlot : Html.Attribute msg
inputSlot =
    Html.Attributes.attribute "slot" "input"


{-| When open, renders content before the input of the view. -}
openLeadingSlot : Html.Attribute msg
openLeadingSlot =
    Html.Attributes.attribute "slot" "open-leading"


{-| When open, renders content after the input of the view. -}
openTrailingSlot : Html.Attribute msg
openTrailingSlot =
    Html.Attributes.attribute "slot" "open-trailing"


{-| When closed, renders content before the input of the view. -}
closedLeadingSlot : Html.Attribute msg
closedLeadingSlot =
    Html.Attributes.attribute "slot" "closed-leading"


{-| When closed, renders content after the input of the view. -}
closedTrailingSlot : Html.Attribute msg
closedTrailingSlot =
    Html.Attributes.attribute "slot" "closed-trailing"