module M3e.Cem.Accordion exposing (accordion, multi)

{-| 
@docs accordion, multi
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.Accordion
import M3e.Value


{-| Combines multiple expansion panels in to an accordion. -}
accordion :
    List (M3e.Cem.Attr.Attr { multi : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
accordion attributes children =
    M3e.Cem.Html.Accordion.accordion
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether multiple expansion panels can be open at the same time. (default: `false`) -}
multi : Bool -> M3e.Cem.Attr.Attr { c | multi : M3e.Value.Supported } msg
multi =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Accordion.multi