module M3e.Cem.ChipSet exposing (chipSet, vertical)

{-| 
@docs chipSet, vertical
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.ChipSet
import M3e.Value


{-| A container used to organize chips into a cohesive unit. -}
chipSet :
    List (M3e.Cem.Attr.Attr { vertical : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
chipSet attributes children =
    M3e.Cem.Html.ChipSet.chipSet
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the element is oriented vertically. (default: `false`) -}
vertical : Bool -> M3e.Cem.Attr.Attr { c | vertical : M3e.Value.Supported } msg
vertical =
    M3e.Cem.Attr.attribute M3e.Cem.Html.ChipSet.vertical