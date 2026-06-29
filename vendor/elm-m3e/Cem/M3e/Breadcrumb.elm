module Cem.M3e.Breadcrumb exposing (component, wrap, separatorSlot)

{-| Displays a hierarchical navigation path and identifies the user's
current location within an application.

@docs component, wrap, separatorSlot

-}

import Html
import Html.Attributes
import Json.Encode


{-| Displays a hierarchical navigation path and identifies the user's
current location within an application.

**Slots:**

  - `separator`: Renders a custom separator between breadcrumb items.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-breadcrumb" attributes children


{-| Whether items wrap to a new line. (default: `false`)
-}
wrap : Bool -> Html.Attribute msg
wrap val_ =
    Html.Attributes.property "wrap" (Json.Encode.bool val_)


{-| Renders a custom separator between breadcrumb items.
-}
separatorSlot : Html.Attribute msg
separatorSlot =
    Html.Attributes.attribute "slot" "separator"
