module M3e.Cem.ContentPane exposing (contentPane)

{-| 
@docs contentPane
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.ContentPane
import M3e.Value


{-| A shaped surface for vertically scrollable content. -}
contentPane :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
contentPane attributes children =
    M3e.Cem.Html.ContentPane.contentPane
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children