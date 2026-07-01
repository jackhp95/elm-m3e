module M3e.Cem.Html.FabMenuTrigger exposing (fabMenuTrigger, for)

{-| 
@docs fabMenuTrigger, for
-}


import Html
import Html.Attributes


{-| The raw `<m3e-fab-menu-trigger>` element — a partial application of `Html.node`. -}
fabMenuTrigger :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
fabMenuTrigger =
    Html.node "m3e-fab-menu-trigger"


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> Html.Attribute msg
for =
    Html.Attributes.attribute "for"