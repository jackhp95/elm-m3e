module Cem.M3e.Slide exposing
    ( component
    , selectedIndex
    )

{-| A carousel-like container used to horizontally cycle through slotted items.


## Component

@docs component


### Attributes

@docs selectedIndex

-}

import Html
import Html.Attributes
import Json.Encode


{-| A carousel-like container used to horizontally cycle through slotted items.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-slide" attributes children


{-| The zero-based index of the visible item. (default: `null`)
-}
selectedIndex : Float -> Html.Attribute msg
selectedIndex val_ =
    Html.Attributes.property "selected-index" (Json.Encode.float val_)
