module M3e.Cem.Html.Slide exposing (selectedIndex, slide)

{-| 
@docs slide, selectedIndex
-}


import Html
import Html.Attributes
import Json.Encode


{-| The raw `<m3e-slide>` element — a partial application of `Html.node`. -}
slide : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
slide =
    Html.node "m3e-slide"


{-| The zero-based index of the visible item. (default: `null`) -}
selectedIndex : Float -> Html.Attribute msg
selectedIndex val_ =
    Html.Attributes.property "selectedIndex" (Json.Encode.float val_)