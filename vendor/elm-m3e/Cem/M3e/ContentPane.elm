module Cem.M3e.ContentPane exposing (component)

{-| A shaped surface for vertically scrollable content.

@docs component

-}

import Html


{-| A shaped surface for vertically scrollable content.

**CSS Custom Properties:**

  - `--m3e-content-pane-container-shape`: Corner radius applied to the pane’s outer surface.
  - `--m3e-content-pane-container-color`: Background color of the pane’s surface.
  - `--m3e-content-pane-container-padding`: Internal padding applied to all sides of the scrollable content.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-content-pane" attributes children
