module Cem.M3e.Tree exposing (component, multi, cascade, onChange)

{-| Presents hierarchical data in a tree structure.

@docs component, multi, cascade, onChange

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| Presents hierarchical data in a tree structure.

**Events:**

  - `change`: Dispatched when the selected state changes.

**CSS Custom Properties:**

  - `--m3e-tree-scrollbar-width`: Width of the tree scrollbar.
  - `--m3e-tree-scrollbar-color`: Color of the tree scrollbar.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-tree" attributes children


{-| Whether multiple items can be selected. (default: `false`)
-}
multi : Bool -> Html.Attribute msg
multi val_ =
    Html.Attributes.property "multi" (Json.Encode.bool val_)


{-| Whether multiple item selection cascades to child items. (default: `false`)
-}
cascade : Bool -> Html.Attribute msg
cascade val_ =
    Html.Attributes.property "cascade" (Json.Encode.bool val_)


{-| Dispatched when the selected state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder
