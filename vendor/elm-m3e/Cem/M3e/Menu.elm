module Cem.M3e.Menu exposing
    ( component
    , PositionX(..), positionX, PositionY(..), positionY, Variant(..), variant, submenu
    , onBeforetoggle, onToggle
    , positionXToString, positionYToString, variantToString
    )

{-| Presents a list of choices on a temporary surface.


## Component

@docs component


### Attributes

@docs PositionX, positionX, PositionY, positionY, Variant, variant, submenu


### Events

@docs onBeforetoggle, onToggle

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| Presents a list of choices on a temporary surface.

**Events:**

  - `beforetoggle`: Dispatched before the toggle state changes.
  - `toggle`: Dispatched after the toggle state has changed.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-menu" attributes children


{-| Values for the `position-x` attribute.
-}
type PositionX
    = After
    | Before


{-| The position of the menu, on the x-axis. (default: `"after"`)
-}
positionX : PositionX -> Html.Attribute msg
positionX val_ =
    Html.Attributes.attribute "position-x" (positionXToString val_)


positionXToString : PositionX -> String
positionXToString val_ =
    case val_ of
        After ->
            "after"

        Before ->
            "before"


{-| Values for the `position-y` attribute.
-}
type PositionY
    = Above
    | Below


{-| The position of the menu, on the y-axis. (default: `"below"`)
-}
positionY : PositionY -> Html.Attribute msg
positionY val_ =
    Html.Attributes.attribute "position-y" (positionYToString val_)


positionYToString : PositionY -> String
positionYToString val_ =
    case val_ of
        Above ->
            "above"

        Below ->
            "below"


{-| Values for the `variant` attribute.
-}
type Variant
    = Standard
    | Vibrant


{-| The appearance variant of the menu. (default: `"standard"`)
-}
variant : Variant -> Html.Attribute msg
variant val_ =
    Html.Attributes.attribute "variant" (variantToString val_)


variantToString : Variant -> String
variantToString val_ =
    case val_ of
        Standard ->
            "standard"

        Vibrant ->
            "vibrant"


{-| A value indicating whether the menu is a submenu. (default: `false`)
-}
submenu : Bool -> Html.Attribute msg
submenu val_ =
    Html.Attributes.property "submenu" (Json.Encode.bool val_)


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
