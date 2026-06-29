module Cem.M3e.Toolbar exposing (component, elevated, shape, variant, vertical)

{-| Presents frequently used actions relevant to the current page.

@docs component, elevated, shape, variant, vertical

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Json.Encode


{-| Presents frequently used actions relevant to the current page.

**CSS Custom Properties:**

  - `--m3e-toolbar-size`: The size (height or width) of the toolbar.
  - `--m3e-toolbar-spacing`: The gap between toolbar items.
  - `--m3e-toolbar-rounded-shape`: Border radius for rounded shape.
  - `--m3e-toolbar-rounded-padding`: Padding for rounded shape.
  - `--m3e-toolbar-square-padding`: Padding for square shape.
  - `--m3e-toolbar-standard-container-color`: Container color for the standard variant.
  - `--m3e-toolbar-standard-color`: Foreground color for the standard variant.
  - `--m3e-toolbar-vibrant-container-color`: Container color for the vibrant variant.
  - `--m3e-toolbar-vibrant-color`: Foreground color for the vibrant variant.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-toolbar" attributes children


{-| Whether the toolbar is elevated. (default: `false`)
-}
elevated : Bool -> Html.Attribute msg
elevated val_ =
    Html.Attributes.property "elevated" (Json.Encode.bool val_)


{-| The shape of the toolbar. (default: `"square"`)
-}
shape :
    Cem.M3e.Common.Value
        { rounded : Cem.M3e.Common.Supported
        , square : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
shape =
    Cem.M3e.Common.shape


{-| The appearance variant of the toolbar. (default: `"standard"`)
-}
variant :
    Cem.M3e.Common.Value
        { standard : Cem.M3e.Common.Supported
        , vibrant : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
variant =
    Cem.M3e.Common.variant


{-| Whether the element is oriented vertically. (default: `false`)
-}
vertical : Bool -> Html.Attribute msg
vertical val_ =
    Html.Attributes.property "vertical" (Json.Encode.bool val_)
