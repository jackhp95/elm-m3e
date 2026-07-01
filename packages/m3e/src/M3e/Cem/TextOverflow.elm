module M3e.Cem.TextOverflow exposing (textOverflow)

{-| 
@docs textOverflow
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.TextOverflow
import M3e.Value


{-| An inline container which presents an ellipsis when content overflows. -}
textOverflow :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
textOverflow attributes children =
    M3e.Cem.Html.TextOverflow.textOverflow
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children