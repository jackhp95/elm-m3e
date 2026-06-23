module M3e.Theme exposing
    ( component
    , contrast, density, strongFocus, motion
    , onChange
    )

{-| A non-visual element responsible for application-level theming.


## Component

@docs component


### Attributes

@docs contrast, density, strongFocus, motion


### Events

@docs onChange

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A non-visual element responsible for application-level theming.

**Events:**

  - `change`: Dispatched when the theme changes.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-theme" attributes children


{-| The contrast level of the theme. (default: `"standard"`)
-}
contrast : String -> Html.Attribute msg
contrast val_ =
    Html.Attributes.attribute "contrast" val_


{-| The density scale (0, -1, -2). (default: `0`)
-}
density : Float -> Html.Attribute msg
density val_ =
    Html.Attributes.property "density" (Json.Encode.float val_)


{-| Whether to enable strong focus indicators. (default: `false`)
-}
strongFocus : Bool -> Html.Attribute msg
strongFocus val_ =
    Html.Attributes.property "strong-focus" (Json.Encode.bool val_)


{-| The motion scheme. (default: `"standard"`)
-}
motion : String -> Html.Attribute msg
motion val_ =
    Html.Attributes.attribute "motion" val_


{-| Dispatched when the theme changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged M3e.Common.targetValue)`.

-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder
