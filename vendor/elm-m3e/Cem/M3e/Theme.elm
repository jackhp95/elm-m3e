module Cem.M3e.Theme exposing
    ( component, color, contrast, density, scheme, strongFocus
    , variant, motion, isdark, onChange
    )

{-| A non-visual element responsible for application-level theming.

@docs component, color, contrast, density, scheme, strongFocus
@docs variant, motion, isdark, onChange

-}

import Cem.M3e.Common
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


{-| The hex color from which to derive dynamic color palettes. (default: `"#6750A4"`)
-}
color : String -> Html.Attribute msg
color val_ =
    Html.Attributes.attribute "color" val_


{-| The contrast level of the theme. (default: `"standard"`)
-}
contrast :
    Cem.M3e.Common.Value
        { high : Cem.M3e.Common.Supported
        , medium : Cem.M3e.Common.Supported
        , standard : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
contrast =
    Cem.M3e.Common.contrast


{-| The density scale (0, -1, -2). (default: `0`)
-}
density : Float -> Html.Attribute msg
density val_ =
    Html.Attributes.property "density" (Json.Encode.float val_)


{-| The color scheme of the theme. (default: `"auto"`)
-}
scheme :
    Cem.M3e.Common.Value
        { auto : Cem.M3e.Common.Supported
        , dark : Cem.M3e.Common.Supported
        , light : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
scheme =
    Cem.M3e.Common.scheme


{-| Whether to enable strong focus indicators. (default: `false`)
-}
strongFocus : Bool -> Html.Attribute msg
strongFocus val_ =
    Html.Attributes.property "strong-focus" (Json.Encode.bool val_)


{-| The color variant of the theme. (default: `"neutral"`)
-}
variant :
    Cem.M3e.Common.Value
        { content : Cem.M3e.Common.Supported
        , expressive : Cem.M3e.Common.Supported
        , fidelity : Cem.M3e.Common.Supported
        , fruitSalad : Cem.M3e.Common.Supported
        , monochrome : Cem.M3e.Common.Supported
        , neutral : Cem.M3e.Common.Supported
        , rainbow : Cem.M3e.Common.Supported
        , tonalSpot : Cem.M3e.Common.Supported
        , vibrant : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
variant =
    Cem.M3e.Common.variant


{-| The motion scheme. (default: `"standard"`)
-}
motion :
    Cem.M3e.Common.Value
        { expressive : Cem.M3e.Common.Supported
        , standard : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
motion =
    Cem.M3e.Common.motion


{-| Whether a dark theme is applied.
-}
isdark : Bool -> Html.Attribute msg
isdark val_ =
    Html.Attributes.property "isDark" (Json.Encode.bool val_)


{-| Dispatched when the theme changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder
