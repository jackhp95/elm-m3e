module M3e.Fab exposing
    ( component
    , extended, lowered, value
    , onClick
    , labelSlot, closeIconSlot
    )

{-| A floating action button (FAB) used to present important actions.


## Component

@docs component


### Attributes

@docs extended, lowered, value


### Events

@docs onClick


### Slots

@docs labelSlot, closeIconSlot

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A floating action button (FAB) used to present important actions.

**Events:**

  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `label`: Renders the label of an extended button.
  - `close-icon`: Renders the close icon when used to open a FAB menu.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-fab" attributes children


{-| Whether the button is extended to show the label. (default: `false`)
-}
extended : Bool -> Html.Attribute msg
extended val_ =
    Html.Attributes.property "extended" (Json.Encode.bool val_)


{-| Whether to present a lowered elevation. (default: `false`)
-}
lowered : Bool -> Html.Attribute msg
lowered val_ =
    Html.Attributes.property "lowered" (Json.Encode.bool val_)


{-| The value associated with the element's name when it's submitted with form data.
-}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value


{-| Dispatched when the element is clicked.

**Payload type:** `MouseEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder


{-| Renders the label of an extended button.
-}
labelSlot : Html.Attribute msg
labelSlot =
    Html.Attributes.attribute "slot" "label"


{-| Renders the close icon when used to open a FAB menu.
-}
closeIconSlot : Html.Attribute msg
closeIconSlot =
    Html.Attributes.attribute "slot" "close-icon"
