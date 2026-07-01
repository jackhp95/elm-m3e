module M3e.Cem.Breadcrumb exposing (breadcrumb, wrap)

{-| 
@docs breadcrumb, wrap
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.Breadcrumb
import M3e.Value


{-| Displays a hierarchical navigation path and identifies the user's
current location within an application.

**Slots:**
- `separator`: Renders a custom separator between breadcrumb items.
-}
breadcrumb :
    List (M3e.Cem.Attr.Attr { wrap : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
breadcrumb attributes children =
    M3e.Cem.Html.Breadcrumb.breadcrumb
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether items wrap to a new line. (default: `false`) -}
wrap : Bool -> M3e.Cem.Attr.Attr { c | wrap : M3e.Value.Supported } msg
wrap =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Breadcrumb.wrap