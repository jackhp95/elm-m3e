module Cem.M3e.Badge exposing (component, size, position, for)

{-| A visual indicator used to label content.

@docs component, size, position, for

-}

import Cem.M3e.Common
import Html
import Html.Attributes


{-| A visual indicator used to label content.

**CSS Custom Properties:**

  - `--m3e-badge-shape`: Corner radius of the badge.
  - `--m3e-badge-color`: Foreground color of badge content.
  - `--m3e-badge-container-color`: Background color of the badge.
  - `--m3e-badge-small-size`: Fixed dimensions for small badge. Used for minimal indicators (e.g. dot).
  - `--m3e-badge-medium-size`: Height and min-width for medium badge.
  - `--m3e-badge-medium-font-size`: Font size for medium badge label.
  - `--m3e-badge-medium-font-weight`: Font weight for medium badge label.
  - `--m3e-badge-medium-line-height`: Line height for medium badge label.
  - `--m3e-badge-medium-tracking`: Letter spacing for medium badge label.
  - `--m3e-badge-large-size`: Height and min-width for large badge.
  - `--m3e-badge-large-font-size`: Font size for large badge label.
  - `--m3e-badge-large-font-weight`: Font weight for large badge label.
  - `--m3e-badge-large-line-height`: Line height for large badge label.
  - `--m3e-badge-large-tracking`: Letter spacing for large badge label.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-badge" attributes children


{-| The size of the badge. (default: `"medium"`)
-}
size :
    Cem.M3e.Common.Value
        { large : Cem.M3e.Common.Supported
        , medium : Cem.M3e.Common.Supported
        , small : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
size =
    Cem.M3e.Common.size


{-| The position of the badge, when attached to another element. (default: `"above-after"`)
-}
position :
    Cem.M3e.Common.Value
        { above : Cem.M3e.Common.Supported
        , aboveAfter : Cem.M3e.Common.Supported
        , aboveBefore : Cem.M3e.Common.Supported
        , after : Cem.M3e.Common.Supported
        , before : Cem.M3e.Common.Supported
        , below : Cem.M3e.Common.Supported
        , belowAfter : Cem.M3e.Common.Supported
        , belowBefore : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
position =
    Cem.M3e.Common.position


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Html.Attribute msg
for val_ =
    Html.Attributes.attribute "for" val_
