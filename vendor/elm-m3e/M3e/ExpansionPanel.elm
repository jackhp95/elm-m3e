module M3e.ExpansionPanel exposing (actionsSlot, component, headerSlot, onClosed, onClosing, onOpened, onOpening, open, toggleIconSlot)

{-| 
An expandable details-summary view.

## Component

@docs component

### Attributes

@docs open

### Events

@docs onOpening, onOpened, onClosing, onClosed

### Slots

@docs actionsSlot, headerSlot, toggleIconSlot
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| An expandable details-summary view.

**Events:**
- `opening`: Dispatched when the expansion panel begins to open.
- `opened`: Dispatched when the expansion panel has opened.
- `closing`: Dispatched when the expansion panel begins to close.
- `closed`: Dispatched when the expansion panel has closed.

**Slots:**
- `actions`: Renders the actions bar of the panel.
- `header`: Renders the header content.
- `toggle-icon`: Renders the expansion toggle icon.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-expansion-panel" attributes children


{-| Whether the panel is expanded. (default: `false`) -}
open : Bool -> Html.Attribute msg
open val_ =
    Html.Attributes.property "open" (Json.Encode.bool val_)


{-| Dispatched when the expansion panel begins to open.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onOpening : Json.Decode.Decoder msg -> Html.Attribute msg
onOpening decoder =
    Html.Events.on "opening" decoder


{-| Dispatched when the expansion panel has opened.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onOpened : Json.Decode.Decoder msg -> Html.Attribute msg
onOpened decoder =
    Html.Events.on "opened" decoder


{-| Dispatched when the expansion panel begins to close.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onClosing : Json.Decode.Decoder msg -> Html.Attribute msg
onClosing decoder =
    Html.Events.on "closing" decoder


{-| Dispatched when the expansion panel has closed.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onClosed : Json.Decode.Decoder msg -> Html.Attribute msg
onClosed decoder =
    Html.Events.on "closed" decoder


{-| Renders the actions bar of the panel. -}
actionsSlot : Html.Attribute msg
actionsSlot =
    Html.Attributes.attribute "slot" "actions"


{-| Renders the header content. -}
headerSlot : Html.Attribute msg
headerSlot =
    Html.Attributes.attribute "slot" "header"


{-| Renders the expansion toggle icon. -}
toggleIconSlot : Html.Attribute msg
toggleIconSlot =
    Html.Attributes.attribute "slot" "toggle-icon"