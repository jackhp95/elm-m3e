module M3e.Cem.Html.Badge exposing (badge, for, position, size)

{-| 
@docs badge, size, position, for
-}


import Html
import Html.Attributes


{-| The raw `<m3e-badge>` element — a partial application of `Html.node`. -}
badge : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
badge =
    Html.node "m3e-badge"


{-| The size of the badge. (default: `"medium"`) -}
size : String -> Html.Attribute msg
size =
    Html.Attributes.attribute "size"


{-| The position of the badge, when attached to another element. (default: `"above-after"`) -}
position : String -> Html.Attribute msg
position =
    Html.Attributes.attribute "position"


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> Html.Attribute msg
for =
    Html.Attributes.attribute "for"