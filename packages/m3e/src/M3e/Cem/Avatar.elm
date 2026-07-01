module M3e.Cem.Avatar exposing (avatar)

{-| 
@docs avatar
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.Avatar
import M3e.Value


{-| An image, icon or textual initials representing a user or other identity. -}
avatar :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
avatar attributes children =
    M3e.Cem.Html.Avatar.avatar
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children