module Cem.M3e.ButtonGroup exposing (component, multi, size, variant)

{-| Organizes buttons and adds interactions between them.

@docs component, multi, size, variant

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Json.Encode


{-| Organizes buttons and adds interactions between them.

**CSS Custom Properties:**

  - `--m3e-standard-button-group-extra-small-spacing`: Spacing between buttons in standard variant, extra-small size.
  - `--m3e-standard-button-group-small-spacing`: Spacing between buttons in standard variant, small size.
  - `--m3e-standard-button-group-medium-spacing`: Spacing between buttons in standard variant, medium size.
  - `--m3e-standard-button-group-large-spacing`: Spacing between buttons in standard variant, large size.
  - `--m3e-standard-button-group-extra-large-spacing`: Spacing between buttons in standard variant, extra-large size.
  - `--m3e-connected-button-group-spacing`: Spacing between buttons in connected variant.
  - `--m3e-connected-button-group-extra-small-inner-shape`: Corner shape for connected variant, extra-small size.
  - `--m3e-connected-button-group-extra-small-inner-pressed-shape`: Pressed corner shape for connected variant, extra-small size.
  - `--m3e-connected-button-group-small-inner-shape`: Corner shape for connected variant, small size.
  - `--m3e-connected-button-group-small-inner-pressed-shape`: Pressed corner shape for connected variant, small size.
  - `--m3e-connected-button-group-medium-inner-shape`: Corner shape for connected variant, medium size.
  - `--m3e-connected-button-group-medium-inner-pressed-shape`: Pressed corner shape for connected variant, medium size.
  - `--m3e-connected-button-group-large-inner-shape`: Corner shape for connected variant, large size.
  - `--m3e-connected-button-group-large-inner-pressed-shape`: Pressed corner shape for connected variant, large size.
  - `--m3e-connected-button-group-extra-large-inner-shape`: Corner shape for connected variant, extra-large size.
  - `--m3e-connected-button-group-extra-large-inner-pressed-shape`: Pressed corner shape for connected variant, extra-large size.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-button-group" attributes children


{-| Whether multiple toggle buttons can be selected. (default: `false`)
-}
multi : Bool -> Html.Attribute msg
multi val_ =
    Html.Attributes.property "multi" (Json.Encode.bool val_)


{-| The size of the group. (default: `"small"`)
-}
size :
    Cem.M3e.Common.Value
        { extraLarge : Cem.M3e.Common.Supported
        , extraSmall : Cem.M3e.Common.Supported
        , large : Cem.M3e.Common.Supported
        , medium : Cem.M3e.Common.Supported
        , small : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
size =
    Cem.M3e.Common.size


{-| The appearance variant of the group. (default: `"standard"`)
-}
variant :
    Cem.M3e.Common.Value
        { connected : Cem.M3e.Common.Supported
        , standard : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
variant =
    Cem.M3e.Common.variant
