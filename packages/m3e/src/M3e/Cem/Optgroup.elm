module M3e.Cem.Optgroup exposing (optgroup)

{-| 
@docs optgroup
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.Optgroup
import M3e.Value


{-| Groups options under a subheading.

**Slots:**
- `label`: Renders the label of the group.
-}
optgroup :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
optgroup attributes children =
    M3e.Cem.Html.Optgroup.optgroup
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children