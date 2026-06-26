module Cem.M3e.Tabs exposing (HeaderPosition(..), Variant(..), component, disablePagination, headerPosition, nextIconSlot, nextPageLabel, onBeforeinput, onChange, onInput, panelSlot, prevIconSlot, previousPageLabel, stretch, variant)

{-| 
Organizes content into separate views where only one view can be visible at a time.

## Component

@docs component

### Attributes

@docs disablePagination, HeaderPosition, headerPosition, nextPageLabel, previousPageLabel, stretch, Variant, variant

### Events

@docs onChange, onBeforeinput, onInput

### Slots

@docs panelSlot, nextIconSlot, prevIconSlot
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| Organizes content into separate views where only one view can be visible at a time.

**Events:**
- `change`: Dispatched when the selected tab changes.
- `beforeinput`: Dispatched before the selected state of a tab changes.
- `input`: Dispatched when the selected state of a tab changes.

**Slots:**
- `panel`: Renders the panels of the tabs.
- `next-icon`: Renders the icon to present for the next button used to paginate.
- `prev-icon`: Renders the icon to present for the previous button used to paginate.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-tabs" attributes children


{-| Whether scroll buttons are disabled. -}
disablePagination : String -> Html.Attribute msg
disablePagination val_ =
    Html.Attributes.attribute "disable-pagination" val_


{-| Values for the `header-position` attribute. -}
type HeaderPosition
    = After
    | Before


{-| The position of the tab headers. (default: `"before"`) -}
headerPosition : HeaderPosition -> Html.Attribute msg
headerPosition val_ =
    Html.Attributes.attribute "header-position" (headerPositionToString val_)


headerPositionToString : HeaderPosition -> String
headerPositionToString val_ =
    case val_ of
        After ->
            "after"
    
        Before ->
            "before"


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`) -}
nextPageLabel : String -> Html.Attribute msg
nextPageLabel val_ =
    Html.Attributes.attribute "next-page-label" val_


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`) -}
previousPageLabel : String -> Html.Attribute msg
previousPageLabel val_ =
    Html.Attributes.attribute "previous-page-label" val_


{-| Whether tabs are stretched to fill the header. (default: `false`) -}
stretch : Bool -> Html.Attribute msg
stretch val_ =
    Html.Attributes.property "stretch" (Json.Encode.bool val_)


{-| Values for the `variant` attribute. -}
type Variant
    = Primary
    | Secondary


{-| The appearance variant of the tabs. (default: `"secondary"`) -}
variant : Variant -> Html.Attribute msg
variant val_ =
    Html.Attributes.attribute "variant" (variantToString val_)


variantToString : Variant -> String
variantToString val_ =
    case val_ of
        Primary ->
            "primary"
    
        Secondary ->
            "secondary"


{-| Dispatched when the selected tab changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.
-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Dispatched before the selected state of a tab changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onBeforeinput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.
-}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput decoder =
    Html.Events.on "beforeinput" decoder


{-| Dispatched when the selected state of a tab changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onInput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.
-}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput decoder =
    Html.Events.on "input" decoder


{-| Renders the panels of the tabs. -}
panelSlot : Html.Attribute msg
panelSlot =
    Html.Attributes.attribute "slot" "panel"


{-| Renders the icon to present for the next button used to paginate. -}
nextIconSlot : Html.Attribute msg
nextIconSlot =
    Html.Attributes.attribute "slot" "next-icon"


{-| Renders the icon to present for the previous button used to paginate. -}
prevIconSlot : Html.Attribute msg
prevIconSlot =
    Html.Attributes.attribute "slot" "prev-icon"