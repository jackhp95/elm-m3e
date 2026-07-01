module M3e.Cem.Divider exposing (divider, inset, insetEnd, insetStart, vertical)

{-| 
@docs divider, inset, insetStart, insetEnd, vertical
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.Divider
import M3e.Value


{-| A thin line that separates content in lists or other containers. -}
divider :
    List (M3e.Cem.Attr.Attr { inset : M3e.Value.Supported
    , insetStart : M3e.Value.Supported
    , insetEnd : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
divider attributes children =
    M3e.Cem.Html.Divider.divider
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the divider is indented with equal padding on both sides. (default: `false`) -}
inset : Bool -> M3e.Cem.Attr.Attr { c | inset : M3e.Value.Supported } msg
inset =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Divider.inset


{-| Whether the divider is indented with padding on the leading side. (default: `false`) -}
insetStart :
    Bool -> M3e.Cem.Attr.Attr { c | insetStart : M3e.Value.Supported } msg
insetStart =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Divider.insetStart


{-| Whether the divider is indented with padding on the trailing side. (default: `false`) -}
insetEnd : Bool -> M3e.Cem.Attr.Attr { c | insetEnd : M3e.Value.Supported } msg
insetEnd =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Divider.insetEnd


{-| Whether the divider is vertically aligned with adjacent content. (default: `false`) -}
vertical : Bool -> M3e.Cem.Attr.Attr { c | vertical : M3e.Value.Supported } msg
vertical =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Divider.vertical