module Cem.M3e.Shape exposing (component, name)

{-| A shape used to add emphasis and decorative flair.

@docs component, name

-}

import Cem.M3e.Common
import Html


{-| A shape used to add emphasis and decorative flair.

**CSS Custom Properties:**

  - `--m3e-shape-size`: Default size of the shape.
  - `--m3e-shape-container-color`: Container (background) color of the shape.
  - `--m3e-shape-transition`: Transition used to morph between shapes.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-shape" attributes children


{-| The name of the shape. (default: `null`)
-}
name :
    Cem.M3e.Common.Value
        { value12SidedCookie : Cem.M3e.Common.Supported
        , value4LeafClover : Cem.M3e.Common.Supported
        , value4SidedCookie : Cem.M3e.Common.Supported
        , value6SidedCookie : Cem.M3e.Common.Supported
        , value7SidedCookie : Cem.M3e.Common.Supported
        , value8LeafClover : Cem.M3e.Common.Supported
        , value9SidedCookie : Cem.M3e.Common.Supported
        , arch : Cem.M3e.Common.Supported
        , arrow : Cem.M3e.Common.Supported
        , boom : Cem.M3e.Common.Supported
        , bun : Cem.M3e.Common.Supported
        , burst : Cem.M3e.Common.Supported
        , circle : Cem.M3e.Common.Supported
        , diamond : Cem.M3e.Common.Supported
        , fan : Cem.M3e.Common.Supported
        , flower : Cem.M3e.Common.Supported
        , gem : Cem.M3e.Common.Supported
        , ghostIsh : Cem.M3e.Common.Supported
        , heart : Cem.M3e.Common.Supported
        , hexagon : Cem.M3e.Common.Supported
        , oval : Cem.M3e.Common.Supported
        , pentagon : Cem.M3e.Common.Supported
        , pill : Cem.M3e.Common.Supported
        , pixelCircle : Cem.M3e.Common.Supported
        , pixelTriangle : Cem.M3e.Common.Supported
        , puffy : Cem.M3e.Common.Supported
        , puffyDiamond : Cem.M3e.Common.Supported
        , semicircle : Cem.M3e.Common.Supported
        , slanted : Cem.M3e.Common.Supported
        , softBoom : Cem.M3e.Common.Supported
        , softBurst : Cem.M3e.Common.Supported
        , square : Cem.M3e.Common.Supported
        , sunny : Cem.M3e.Common.Supported
        , triangle : Cem.M3e.Common.Supported
        , verySunny : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
name =
    Cem.M3e.Common.name
