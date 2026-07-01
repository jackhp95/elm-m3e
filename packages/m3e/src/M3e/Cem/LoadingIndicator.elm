module M3e.Cem.LoadingIndicator exposing (loadingIndicator, variant)

{-| 
@docs loadingIndicator, variant
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.LoadingIndicator
import M3e.Value


{-| Shows indeterminate progress for a short wait time. -}
loadingIndicator :
    List (M3e.Cem.Attr.Attr { variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
loadingIndicator attributes children =
    M3e.Cem.Html.LoadingIndicator.loadingIndicator
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The appearance variant of the indicator. (default: `"uncontained"`) -}
variant :
    M3e.Value.Value { contained : M3e.Value.Supported
    , uncontained : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant v_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.LoadingIndicator.variant
        (M3e.Value.toString v_)