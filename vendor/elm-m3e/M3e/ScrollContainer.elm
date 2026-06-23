module M3e.ScrollContainer exposing
    ( component
    , dividers, thin
    )

{-| A vertically oriented content container which presents dividers above and below content when scrolled.


## Component

@docs component


### Attributes

@docs dividers, thin

-}

import Html
import Html.Attributes
import Json.Encode


{-| A vertically oriented content container which presents dividers above and below content when scrolled.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-scroll-container" attributes children


{-| The dividers used to separate scrollable content. (default: `"above-below"`)
-}
dividers : String -> Html.Attribute msg
dividers val_ =
    Html.Attributes.attribute "dividers" val_


{-| Whether to present thin scrollbars. (default: `false`)
-}
thin : Bool -> Html.Attribute msg
thin val_ =
    Html.Attributes.property "thin" (Json.Encode.bool val_)
