module M3e.Cem.Toolbar exposing (elevated, shape, toolbar, variant, vertical)

{-| 
@docs toolbar, elevated, shape, variant, vertical
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.Toolbar
import M3e.Value


{-| Presents frequently used actions relevant to the current page. -}
toolbar :
    List (M3e.Cem.Attr.Attr { elevated : M3e.Value.Supported
    , shape : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
toolbar attributes children =
    M3e.Cem.Html.Toolbar.toolbar
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the toolbar is elevated. (default: `false`) -}
elevated : Bool -> M3e.Cem.Attr.Attr { c | elevated : M3e.Value.Supported } msg
elevated =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Toolbar.elevated


{-| The shape of the toolbar. (default: `"square"`) -}
shape :
    M3e.Value.Value { rounded : M3e.Value.Supported
    , square : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | shape : M3e.Value.Supported } msg
shape v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Toolbar.shape (M3e.Value.toString v_)


{-| The appearance variant of the toolbar. (default: `"standard"`) -}
variant :
    M3e.Value.Value { standard : M3e.Value.Supported
    , vibrant : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Toolbar.variant (M3e.Value.toString v_)


{-| Whether the element is oriented vertically. (default: `false`) -}
vertical : Bool -> M3e.Cem.Attr.Attr { c | vertical : M3e.Value.Supported } msg
vertical =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Toolbar.vertical