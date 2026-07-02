module M3e.Cem.ChipSet exposing ( chipSet, vertical )

{-|
Middle layer for `<m3e-chip-set>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.ChipSet` module for everyday use.

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