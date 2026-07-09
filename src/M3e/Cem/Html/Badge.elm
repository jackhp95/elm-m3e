module M3e.Cem.Html.Badge exposing ( badge, size, position, for )

{-|
Bottom layer for `<m3e-badge>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

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