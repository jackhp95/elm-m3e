module Cem.M3e.Divider exposing (component, inset, insetStart, insetEnd, vertical)

{-| A thin line that separates content in lists or other containers.

@docs component, inset, insetStart, insetEnd, vertical

-}

import Html
import Html.Attributes
import Json.Encode


{-| A thin line that separates content in lists or other containers.

**CSS Custom Properties:**

  - `--m3e-divider-thickness`: Thickness of the divider line.
  - `--m3e-divider-color`: Color of the divider line.
  - `--m3e-divider-inset-size`: When inset, fallback inset size used when no specific start or end inset is provided.
  - `--m3e-divider-inset-start-size`: When inset, leading inset size.
  - `--m3e-divider-inset-end-size`: When inset, trailing inset size.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-divider" attributes children


{-| Whether the divider is indented with equal padding on both sides. (default: `false`)
-}
inset : Bool -> Html.Attribute msg
inset val_ =
    Html.Attributes.property "inset" (Json.Encode.bool val_)


{-| Whether the divider is indented with padding on the leading side. (default: `false`)
-}
insetStart : Bool -> Html.Attribute msg
insetStart val_ =
    Html.Attributes.property "inset-start" (Json.Encode.bool val_)


{-| Whether the divider is indented with padding on the trailing side. (default: `false`)
-}
insetEnd : Bool -> Html.Attribute msg
insetEnd val_ =
    Html.Attributes.property "inset-end" (Json.Encode.bool val_)


{-| Whether the divider is vertically aligned with adjacent content. (default: `false`)
-}
vertical : Bool -> Html.Attribute msg
vertical val_ =
    Html.Attributes.property "vertical" (Json.Encode.bool val_)
