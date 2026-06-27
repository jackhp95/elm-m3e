module Cem.M3e.PseudoCheckbox exposing
    ( component
    , checked, disabled, indeterminate
    )

{-| An element which looks like a checkbox.


## Component

@docs component


### Attributes

@docs checked, disabled, indeterminate

-}

import Html
import Html.Attributes
import Json.Encode


{-| An element which looks like a checkbox.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-pseudo-checkbox" attributes children


{-| A value indicating whether the element is checked. (default: `false`)
-}
checked : Bool -> Html.Attribute msg
checked =
    Html.Attributes.checked


{-| A value indicating whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| A value indicating whether the element's checked state is indeterminate. (default: `false`)
-}
indeterminate : Bool -> Html.Attribute msg
indeterminate val_ =
    Html.Attributes.property "indeterminate" (Json.Encode.bool val_)
