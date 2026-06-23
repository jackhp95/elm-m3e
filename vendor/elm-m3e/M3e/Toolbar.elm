module M3e.Toolbar exposing
    ( component
    , elevated
    )

{-| Presents frequently used actions relevant to the current page.


## Component

@docs component


### Attributes

@docs elevated

-}

import Html
import Html.Attributes
import Json.Encode


{-| Presents frequently used actions relevant to the current page.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-toolbar" attributes children


{-| Whether the toolbar is elevated. (default: `false`)
-}
elevated : Bool -> Html.Attribute msg
elevated val_ =
    Html.Attributes.property "elevated" (Json.Encode.bool val_)
