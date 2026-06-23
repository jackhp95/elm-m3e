module M3e.Heading exposing
    ( component
    , emphasized
    )

{-| A heading to a page or section.


## Component

@docs component


### Attributes

@docs emphasized

-}

import Html
import Html.Attributes
import Json.Encode


{-| A heading to a page or section.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-heading" attributes children


{-| Whether the heading uses an emphasized typescale. (default: `false`)
-}
emphasized : Bool -> Html.Attribute msg
emphasized val_ =
    Html.Attributes.property "emphasized" (Json.Encode.bool val_)
