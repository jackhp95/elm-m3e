module Cem.M3e.DrawerToggle exposing
    ( component
    , for
    )

{-| An element, nested within a clickable element, used to toggle the opened state of a drawer.


## Component

@docs component


### Attributes

@docs for

-}

import Html
import Html.Attributes


{-| An element, nested within a clickable element, used to toggle the opened state of a drawer.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-drawer-toggle" attributes children


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Html.Attribute msg
for val_ =
    Html.Attributes.attribute "for" val_
